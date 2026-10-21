"""Map Jobs API run state + progress.json heartbeat to an AssessDomainRun status."""
from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime, timezone

from ..error_sanitization import sanitize_error_message


@dataclass
class StatusUpdate:
    status: str
    stage: str = ""
    attempt: int = 0
    resume_at: datetime | None = None
    last_message: str = ""
    error_message: str = ""
    terminal_success: bool = False


def _v(x) -> str:
    return getattr(x, "value", x) or ""


def map_status(run, progress: dict | None) -> StatusUpdate:
    p = progress if isinstance(progress, dict) else {}
    stage = str(p.get("stage") or "")
    attempt = int(p.get("attempt") or 0)
    ra = p.get("resume_at")
    resume_at = datetime.fromtimestamp(float(ra), tz=timezone.utc) if ra else None
    msg = str(p.get("last_message") or "")[:300]
    st = run.state
    lc, rs = _v(st.life_cycle_state), _v(getattr(st, "result_state", None))
    base = dict(stage=stage, attempt=attempt, last_message=msg)
    if lc == "QUEUED":
        return StatusUpdate("queued", **base)
    if lc in ("PENDING", "BLOCKED", "WAITING_FOR_RETRY"):
        return StatusUpdate("starting", **base)
    if lc == "RUNNING":
        if stage == "rate_limited":
            return StatusUpdate("rate_limited", resume_at=resume_at, **base)
        if stage in ("preflight", "installing"):
            return StatusUpdate("starting", **base)
        return StatusUpdate("assessing", **base)
    if lc in ("TERMINATING", "TERMINATED") and rs == "SUCCESS":
        return StatusUpdate("assessing", terminal_success=True, **base)
    if rs == "CANCELED" or lc == "SKIPPED":
        return StatusUpdate("cancelled", **base)
    if lc == "TERMINATING":
        return StatusUpdate("assessing", **base)
    if stage == "preflight_failed":
        err = f"Pre-flight failed — {msg}"
    else:
        err = f"{rs or lc}: {getattr(st, 'state_message', '') or msg}".strip()
    # The Jobs/pre-flight text as is (sanitized); the UI pairs it with the run's job + job-run links.
    return StatusUpdate("failed", error_message=sanitize_error_message(err)[:2000], **base)
