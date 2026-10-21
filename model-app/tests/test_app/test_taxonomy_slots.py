"""LLMSlots: app-wide hard cap on live taxonomy LLM calls (taxonomy/slots.py)."""

from __future__ import annotations

import asyncio
import threading
from concurrent.futures import ThreadPoolExecutor

import pytest

from vibe_modeling.backend.taxonomy.slots import (
    DEFAULT_CAPACITY,
    MAX_CAPACITY,
    TAXONOMY_EXECUTOR,
    LLMSlots,
    NoFreeSlot,
)


def test_grant_until_capacity_then_refuse():
    slots = LLMSlots(2)
    assert slots.try_acquire() and slots.try_acquire()
    assert not slots.try_acquire()
    assert slots.in_use == 2


def test_release_frees_a_slot():
    slots = LLMSlots(1)
    assert slots.try_acquire()
    slots.release()
    assert slots.in_use == 0 and slots.try_acquire()


def test_release_without_acquire_raises():
    with pytest.raises(RuntimeError):
        LLMSlots(1).release()


def test_capacity_is_clamped_and_defaults():
    assert LLMSlots().capacity == DEFAULT_CAPACITY == 6
    assert LLMSlots(0).capacity == 1
    assert LLMSlots(99).capacity == MAX_CAPACITY == 16


def test_capacity_change_never_preempts():
    slots = LLMSlots(3)
    for _ in range(3):
        assert slots.try_acquire()
    slots.set_capacity(1)
    assert slots.capacity == 1 and slots.in_use == 3
    assert not slots.try_acquire()
    slots.release()
    slots.release()
    assert not slots.try_acquire()  # 1 in use == capacity 1
    slots.release()
    assert slots.try_acquire()
    slots.set_capacity(4)
    assert slots.try_acquire() and slots.in_use == 2


def test_executor_is_dedicated_and_sized_to_max_capacity():
    assert TAXONOMY_EXECUTOR._max_workers == MAX_CAPACITY
    assert TAXONOMY_EXECUTOR._thread_name_prefix == "taxonomy-llm"


# Future.result() can return before the done-callback runs (callbacks fire after
# waiters wake), so these tests use a private pool and shut it down with
# wait=True: the worker thread runs the callback before it exits.


def test_submit_releases_once_on_success():
    slots = LLMSlots(1)
    pool = ThreadPoolExecutor(max_workers=1)
    fut = slots.submit(lambda: 42, executor=pool)
    assert fut.result(timeout=5) == 42
    pool.shutdown(wait=True)
    assert slots.in_use == 0


def test_submit_releases_once_on_error():
    slots = LLMSlots(1)
    pool = ThreadPoolExecutor(max_workers=1)

    def boom():
        raise ValueError("x")

    fut = slots.submit(boom, executor=pool)
    with pytest.raises(ValueError):
        fut.result(timeout=5)
    pool.shutdown(wait=True)
    assert slots.in_use == 0


def test_submit_without_free_slot_raises_and_runs_nothing():
    slots = LLMSlots(1)
    assert slots.try_acquire()
    ran = []
    with pytest.raises(NoFreeSlot):
        slots.submit(lambda: ran.append(1))
    assert ran == [] and slots.in_use == 1


def test_submit_on_shut_down_executor_releases():
    slots = LLMSlots(1)
    pool = ThreadPoolExecutor(max_workers=1)
    pool.shutdown()
    with pytest.raises(RuntimeError):
        slots.submit(lambda: 1, executor=pool)
    assert slots.in_use == 0


def test_cancelled_await_keeps_slot_until_thread_ends():
    """Cancelling the asyncio side must not free the slot: the thread is still
    calling the gateway. It frees exactly once, when the thread finishes."""
    slots = LLMSlots(1)
    started, finish = threading.Event(), threading.Event()
    pool = ThreadPoolExecutor(max_workers=1)

    def call():
        started.set()
        finish.wait(5)
        return "late"

    async def scenario():
        task = asyncio.create_task(slots.run(call, executor=pool))
        while not started.is_set():
            await asyncio.sleep(0.01)
        task.cancel()
        with pytest.raises(asyncio.CancelledError):
            await task
        assert slots.in_use == 1
        assert not slots.try_acquire()

    asyncio.run(scenario())
    finish.set()
    pool.shutdown(wait=True)
    assert slots.in_use == 0
    assert slots.try_acquire()  # exactly one release: counter is not negative/over-freed
    assert slots.in_use == 1


def test_timed_out_await_keeps_slot_until_thread_ends():
    slots = LLMSlots(1)
    finish = threading.Event()
    pool = ThreadPoolExecutor(max_workers=1)

    async def scenario():
        with pytest.raises(asyncio.TimeoutError):
            await asyncio.wait_for(slots.run(lambda: finish.wait(5), executor=pool), 0.05)
        assert slots.in_use == 1

    asyncio.run(scenario())
    finish.set()
    pool.shutdown(wait=True)
    assert slots.in_use == 0


def test_live_calls_never_exceed_capacity():
    slots = LLMSlots(3)
    lock = threading.Lock()
    live = peak = 0
    gate = threading.Event()

    def call():
        nonlocal live, peak
        with lock:
            live += 1
            peak = max(peak, live)
        gate.wait(5)
        with lock:
            live -= 1

    pool = ThreadPoolExecutor(max_workers=10)
    futures, refused = [], 0
    for _ in range(10):
        try:
            futures.append(slots.submit(call, executor=pool))
        except NoFreeSlot:
            refused += 1
    gate.set()
    for f in futures:
        f.result(timeout=5)
    pool.shutdown(wait=True)
    assert len(futures) == 3 and refused == 7
    assert peak <= 3 and slots.in_use == 0
