"""Model-service access check for the Domain Taxonomy Builder.

``ModelServiceAccess`` is the in-process record of test calls (probes):

- ``passed``: service names whose last probe was ``ok``, with when it passed.
  The LLM routes skip the probe for these, so a probe runs before the first
  draft after boot, after the service changes (installer-seeded values
  Settings never checked are covered too), and once a pass is older than
  ``PASSED_TTL``.
- ``last_check``: the most recent probe result per service, shown in Settings.

``busy`` is recorded in ``last_check`` but never cached: a 429 normally comes
after authorization, and the next draft probes again. ``denied``,
``not_found`` and ``error`` drop the name from the cache. Draft calls feed it
too: a draft call that comes back ``denied``/``not_found`` is recorded here
(``taxonomy/drafts.py``), so ``ready`` turns false and the landing card hides.

The probe runs on ``TAXONOMY_EXECUTOR`` under one ``LLMSlots`` slot, and the
caller waits at most ``PROBE_WAIT_SECONDS``; the thread itself is bounded by
the LLM client's HTTP timeout. No free slot, or the wait expiring, is
``busy``.

Self-healing: a refused check would otherwise hide the wizard until an admin
acts. ``maybe_recheck`` (called by ``GET /config/taxonomy``) starts ONE
background probe when the service's last check is refused and older than
``REFUSED_RECHECK_AFTER``; boot starts one with ``start_background_probe``.
Background probes are fire-and-forget, deduplicated per service, and go
through the same slots; with no free slot nothing is started or recorded.
"""

from __future__ import annotations

import asyncio
import logging
import threading
from concurrent.futures import Executor, Future
from datetime import datetime, timedelta, timezone
from typing import Callable

from .llm import ProbeResult, TaxonomyLLM, busy_message
from .models import TaxonomyCheckOut
from .slots import TAXONOMY_EXECUTOR, LLMSlots, NoFreeSlot

log = logging.getLogger(__name__)

PROBE_WAIT_SECONDS = 20
# Last-check statuses that refuse a save / a draft and make ``ready`` false.
REFUSED_CHECKS: frozenset[str] = frozenset({"denied", "not_found", "error"})
# A refused check older than this is re-probed in the background.
REFUSED_RECHECK_AFTER = timedelta(minutes=5)
# A passed check older than this no longer skips the pre-draft probe, so a
# revoked grant is caught before a draft is created.
PASSED_TTL = timedelta(minutes=15)


class ModelServiceAccess:
    def __init__(self, clock: Callable[[], datetime] = lambda: datetime.now(timezone.utc)) -> None:
        self._lock = threading.Lock()
        self._clock = clock
        self._passed: dict[str, datetime] = {}
        self._last: dict[str, TaxonomyCheckOut] = {}
        self._in_flight: set[str] = set()

    def now(self) -> datetime:
        """This cache's clock: pass it as ``record(..., not_before=)`` for a
        call that started now."""
        return self._clock()

    def is_cached(self, model_service: str) -> bool:
        with self._lock:
            passed_at = self._passed.get(model_service)
            if passed_at is None:
                return False
            if self._clock() - passed_at >= PASSED_TTL:
                del self._passed[model_service]
                return False
            return True

    def last_check(self, model_service: str) -> TaxonomyCheckOut | None:
        with self._lock:
            return self._last.get(model_service)

    def record(
        self, model_service: str, result: ProbeResult, *, not_before: datetime | None = None,
    ) -> TaxonomyCheckOut:
        """Store ``result`` as the service's ``last_check`` and update the
        cache. ``not_before`` is when the call behind ``result`` started (a
        background probe, or a draft call that came back ``denied``/
        ``not_found``): if a check was stored at or after it (a Test or Save
        finished first), the newer check wins and nothing is written."""
        check = TaxonomyCheckOut(status=result.status, message=result.message, checked_at=self._clock())
        with self._lock:
            current = self._last.get(model_service)
            if not_before is not None and current is not None and current.checked_at >= not_before:
                return current
            self._last[model_service] = check
            if result.status == "ok":
                self._passed[model_service] = check.checked_at
            elif result.status != "busy":
                self._passed.pop(model_service, None)
        return check

    def clear(self) -> None:
        """Test-only: forget every check, cached pass and in-flight marker."""
        with self._lock:
            self._passed.clear()
            self._last.clear()
            self._in_flight.clear()

    def is_refused(self, model_service: str) -> bool:
        check = self.last_check(model_service)
        return check is not None and check.status in REFUSED_CHECKS

    def start_background_probe(
        self, llm: TaxonomyLLM, slots: LLMSlots, *, executor: Executor = TAXONOMY_EXECUTOR,
    ) -> bool:
        """Start one fire-and-forget probe of ``llm.model_service`` unless one
        is already running for it or no slot is free. The result is recorded
        when the thread ends. Returns whether a probe was started."""
        name = llm.model_service
        with self._lock:
            if name in self._in_flight:
                return False
            self._in_flight.add(name)
        started = self._clock()
        try:
            fut = slots.submit(llm.probe, executor=executor)
        except NoFreeSlot:
            self._release_in_flight(name)
            return False
        except BaseException:
            self._release_in_flight(name)
            raise

        def _done(f: Future[ProbeResult]) -> None:
            try:
                self.record(name, f.result(), not_before=started)
            except Exception:  # noqa: BLE001 - a background probe must never raise
                log.exception("background probe of model service '%s' failed", name)
            finally:
                self._release_in_flight(name)

        fut.add_done_callback(_done)
        return True

    def _release_in_flight(self, model_service: str) -> None:
        with self._lock:
            self._in_flight.discard(model_service)

    def is_in_flight(self, model_service: str) -> bool:
        """Test-only: whether a background probe of the service is running."""
        with self._lock:
            return model_service in self._in_flight

    def maybe_recheck(
        self, model_service: str, llm_factory: Callable[[], TaxonomyLLM], slots: LLMSlots,
        *, executor: Executor = TAXONOMY_EXECUTOR,
    ) -> bool:
        """Start a background probe when the service's last check is refused
        and older than ``REFUSED_RECHECK_AFTER``. Never waits."""
        check = self.last_check(model_service)
        if check is None or check.status not in REFUSED_CHECKS:
            return False
        if self._clock() - check.checked_at < REFUSED_RECHECK_AFTER:
            return False
        return self.start_background_probe(llm_factory(), slots, executor=executor)

    async def probe(
        self, llm: TaxonomyLLM, slots: LLMSlots, *, wait_seconds: float = PROBE_WAIT_SECONDS,
    ) -> TaxonomyCheckOut:
        """Run ``llm.probe()`` on the taxonomy executor and record the result."""
        try:
            result = await asyncio.wait_for(slots.run(llm.probe), wait_seconds)
        except (NoFreeSlot, asyncio.TimeoutError):
            result = ProbeResult("busy", busy_message(llm.model_service))
        return self.record(llm.model_service, result)


MODEL_SERVICE_ACCESS = ModelServiceAccess()
