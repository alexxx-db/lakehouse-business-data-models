"""App-wide hard cap on live Domain Taxonomy Builder LLM calls.

One slot = one live ``TAXONOMY_EXECUTOR`` thread calling the gateway. A slot is
taken just before ``executor.submit`` and released by the submitted future's
done-callback, so it frees exactly once, when the THREAD finishes - success,
error, or abandoned after the asyncio side was cancelled or timed out. That
keeps the count equal to the real number of calls hitting the gateway.

The dedicated pool keeps LLM calls off asyncio's shared default executor, so
other routes' ``to_thread`` work never queues behind them. Its size is the
largest capacity an admin can set, so live threads never exceed the capacity.

The capacity has one owner: ``DraftStore`` applies the stored
``max_concurrency`` on every create and retry (``taxonomy/drafts.py``), so a
saved change takes effect at the next draft. Test calls outside a draft (boot,
Settings Test/Save) run under the current capacity.
"""

from __future__ import annotations

import asyncio
import threading
from concurrent.futures import Executor, Future, ThreadPoolExecutor
from typing import Any, Callable, TypeVar

MIN_CAPACITY = 1
MAX_CAPACITY = 16
DEFAULT_CAPACITY = 6

T = TypeVar("T")

TAXONOMY_EXECUTOR = ThreadPoolExecutor(max_workers=MAX_CAPACITY, thread_name_prefix="taxonomy-llm")


class NoFreeSlot(RuntimeError):
    """Every slot is held by a live call; the caller reports ``busy``."""


class LLMSlots:
    """A lock-guarded counter. ``try_acquire`` never waits."""

    def __init__(self, capacity: int = DEFAULT_CAPACITY) -> None:
        self._lock = threading.Lock()
        self._capacity = self._clamp(capacity)
        self._in_use = 0

    @staticmethod
    def _clamp(capacity: int) -> int:
        return max(MIN_CAPACITY, min(MAX_CAPACITY, int(capacity)))

    @property
    def capacity(self) -> int:
        return self._capacity

    @property
    def in_use(self) -> int:
        return self._in_use

    def set_capacity(self, capacity: int) -> None:
        """Change the cap. Lowering it below ``in_use`` preempts nothing; new
        grants wait until enough live calls finish."""
        with self._lock:
            self._capacity = self._clamp(capacity)

    def try_acquire(self) -> bool:
        with self._lock:
            if self._in_use >= self._capacity:
                return False
            self._in_use += 1
            return True

    def release(self) -> None:
        with self._lock:
            if self._in_use <= 0:
                raise RuntimeError("LLMSlots.release without a matching acquire")
            self._in_use -= 1

    def submit(self, fn: Callable[..., T], *args: Any, executor: Executor = TAXONOMY_EXECUTOR) -> Future[T]:
        """Take a slot and run ``fn(*args)`` on ``executor``. Raises
        ``NoFreeSlot`` when none is free. The slot is released by the future's
        done-callback, registered here, before any asyncio wrapping, so
        cancelling an awaiting task can never skip the release."""
        if not self.try_acquire():
            raise NoFreeSlot()
        released = False
        guard = threading.Lock()

        def _release(_fut: Future[Any] | None = None) -> None:
            nonlocal released
            with guard:
                if released:
                    return
                released = True
            self.release()

        try:
            fut = executor.submit(fn, *args)
        except BaseException:
            _release()
            raise
        fut.add_done_callback(_release)
        return fut

    async def run(self, fn: Callable[..., T], *args: Any, executor: Executor = TAXONOMY_EXECUTOR) -> T:
        """``submit`` + await. Cancelling the awaiting task leaves the thread
        (and its slot) running until the call itself ends."""
        fut = self.submit(fn, *args, executor=executor)
        return await asyncio.wrap_future(fut)


# The one app-wide counter: the probe and every draft call share it.
TAXONOMY_SLOTS = LLMSlots()
