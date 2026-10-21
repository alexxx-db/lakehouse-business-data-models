from unittest.mock import MagicMock

import pytest
from databricks.sdk._base_client import _BaseClient
from databricks.sdk.clock import Clock
from databricks.sdk.errors import (
    BadRequest,
    NotFound,
    PermissionDenied,
    TemporarilyUnavailable,
    TooManyRequests,
)

from vibe_modeling.backend.taxonomy.llm import (
    GATEWAY_CHAT_PATH,
    TaxonomyLLM,
    TaxonomyLLMBusy,
    TaxonomyLLMDenied,
    TaxonomyLLMError,
    TaxonomyLLMNotFound,
    error_text,
    extract_json,
)
from vibe_modeling.backend.taxonomy.models import TaxonomySection

SERVICE = "system.ai.claude-sonnet-5-5"
SP_ID = "11111111-2222-3333-4444-555555555555"


def _reply(content):
    return {"choices": [{"message": {"role": "assistant", "content": content}}]}


def _llm(*contents):
    ws = MagicMock()
    ws.api_client.do.side_effect = [_reply(c) for c in contents]
    return TaxonomyLLM(ws, SERVICE), ws


def _failing(exc):
    ws = MagicMock()
    ws.config.client_id = SP_ID
    ws.api_client.do.side_effect = exc
    return TaxonomyLLM(ws, SERVICE), ws


def _from(outer, inner):
    """``outer`` raised from ``inner``, as the SDK's ``retried`` does."""
    try:
        raise outer from inner
    except type(outer) as e:
        return e


GOOD = '{"claims": [{"text": "A CIS owns billing.", "provenance": "industry"}]}'


def test_extract_json_plain():
    assert extract_json(GOOD) == GOOD


def test_extract_json_fenced():
    assert extract_json(f"```json\n{GOOD}\n```") == GOOD


def test_extract_json_with_prose_around():
    assert extract_json(f"Here you go:\n{GOOD}\nHope this helps!") == GOOD


def test_extract_json_none():
    with pytest.raises(ValueError):
        extract_json("no braces here")


def test_complete_json_calls_gateway_once_when_valid():
    llm, ws = _llm(GOOD)
    out = llm.complete_json("sys", "user", TaxonomySection)
    assert out.claims[0].provenance == "industry"
    method, path = ws.api_client.do.call_args.args[:2]
    assert (method, path) == ("POST", "/ai-gateway/mlflow/v1/chat/completions")
    assert GATEWAY_CHAT_PATH == path
    body = ws.api_client.do.call_args.kwargs["body"]
    assert body["model"] == SERVICE
    assert body["max_tokens"] == 8000
    assert body["messages"][0] == {"role": "system", "content": "sys"}
    assert "response_format" not in body and "tools" not in body


def test_complete_json_retries_once_with_error_feedback():
    llm, ws = _llm('{"claims": [{"text": "x", "provenance": "guess"}]}', GOOD)
    out = llm.complete_json("sys", "user", TaxonomySection)
    assert out.claims[0].text == "A CIS owns billing."
    second = ws.api_client.do.call_args_list[1].kwargs["body"]["messages"]
    assert second[-1]["role"] == "user" and "did not match" in second[-1]["content"]


def test_complete_json_fails_after_two_bad_replies():
    llm, _ = _llm("nope", "still nope")
    with pytest.raises(TaxonomyLLMError, match="after retry"):
        llm.complete_json("sys", "user", TaxonomySection)


def test_unknown_error_is_wrapped_with_its_text():
    llm, _ = _failing(BadRequest("Invalid Unity Catalog name: 'ai.claude'."))
    with pytest.raises(TaxonomyLLMError, match="Invalid Unity Catalog name") as exc:
        llm.complete_text("s", "u")
    assert type(exc.value) is TaxonomyLLMError


def test_unexpected_shape_is_wrapped():
    ws = MagicMock()
    ws.api_client.do.return_value = {"foo": 1}
    with pytest.raises(TaxonomyLLMError, match="unexpected"):
        TaxonomyLLM(ws, SERVICE).complete_text("s", "u")


def test_config_seed_defaults():
    from vibe_modeling.backend.core._config import AppConfig
    cfg = AppConfig()
    assert cfg.taxonomy_builder_enabled is False
    assert cfg.taxonomy_model_service == ""


# --- error classification (shapes observed on a test workspace 2026-10-18) ---


@pytest.mark.parametrize("cause", [TooManyRequests("slow down"), TemporarilyUnavailable("later")])
def test_retry_timeout_from_rate_limit_is_busy(cause):
    llm, _ = _failing(_from(TimeoutError("Timed out after 0:00:01"), cause))
    with pytest.raises(TaxonomyLLMBusy, match="busy right now"):
        llm.complete_text("s", "u")


def test_direct_too_many_requests_is_busy():
    """An unparseable 429 body raises TooManyRequests itself (no wrapper)."""
    llm, _ = _failing(TooManyRequests("unable to parse response."))
    with pytest.raises(TaxonomyLLMBusy):
        llm.complete_text("s", "u")


def test_rate_limit_found_via_context():
    try:
        try:
            raise TooManyRequests("x")
        except TooManyRequests:
            raise TimeoutError("Timed out")
    except TimeoutError as e:
        exc = e
    llm, _ = _failing(exc)
    with pytest.raises(TaxonomyLLMBusy):
        llm.complete_text("s", "u")


def test_bare_timeout_is_plain_failure():
    llm, _ = _failing(TimeoutError("Timed out after 0:00:01"))
    with pytest.raises(TaxonomyLLMError) as exc:
        llm.complete_text("s", "u")
    assert type(exc.value) is TaxonomyLLMError


def test_not_found_is_classified():
    llm, _ = _failing(NotFound(f"'{SERVICE}' does not exist."))
    with pytest.raises(TaxonomyLLMNotFound, match=f"Model service '{SERVICE}' was not found."):
        llm.complete_text("s", "u")


def test_denied_names_the_sp_and_drops_the_debug_suffix():
    sdk_msg = "User does not have EXECUTE on model service. Config: host=https://x, auth_type=oauth-m2m. Env: DATABRICKS_HOST"
    llm, _ = _failing(PermissionDenied(sdk_msg))
    with pytest.raises(TaxonomyLLMDenied) as exc:
        llm.complete_text("s", "u")
    msg = str(exc.value)
    assert SP_ID in msg and f"'{SERVICE}'" in msg
    assert "User does not have EXECUTE on model service. An admin must grant" in msg
    assert "Config:" not in msg and "auth_type" not in msg


def test_error_text_unwraps_openai_style_body():
    assert error_text(BadRequest({"error": {"message": "bad thing", "type": "invalid_request"}})) == "bad thing"
    assert error_text(BadRequest("{'error': {'message': 'from repr'}}")) == "from repr"
    assert error_text(BadRequest("plain")) == "plain"


def test_sdk_retried_sleeps_once_for_retry_after_at_one_second_budget():
    """Pin the SDK behaviour the busy path relies on: with
    retry_timeout_seconds=1, a 429 sleeps once for Retry-After (+ <1 s jitter)
    and then raises TimeoutError from TooManyRequests."""

    class FakeClock(Clock):
        def __init__(self):
            self.now = 1000.0
            self.sleeps: list[float] = []

        def time(self):
            return self.now

        def sleep(self, seconds):
            self.sleeps.append(seconds)
            self.now += seconds

    clock = FakeClock()
    client = _BaseClient(retry_timeout_seconds=1, clock=clock)
    calls = []

    def perform(*_a, **_kw):
        calls.append(1)
        raise TooManyRequests("slow down", retry_after_secs=7)

    client._perform = perform
    with pytest.raises(TimeoutError) as exc:
        client.do("POST", "https://example.invalid" + GATEWAY_CHAT_PATH, body={"model": SERVICE})
    assert isinstance(exc.value.__cause__, TooManyRequests)
    assert len(calls) == 1 and len(clock.sleeps) == 1
    assert 7 <= clock.sleeps[0] < 8


# --- probe ---


def _probe_ws(reply=None, exc=None):
    ws = MagicMock()
    ws.config.client_id = SP_ID
    if exc is not None:
        ws.api_client.do.side_effect = exc
    else:
        ws.api_client.do.return_value = reply
    return ws


def test_probe_payload_is_one_tiny_message():
    ws = _probe_ws(reply=_reply("OK"))
    assert TaxonomyLLM(ws, SERVICE).probe().status == "ok"
    assert ws.api_client.do.call_count == 1
    method, path = ws.api_client.do.call_args.args[:2]
    assert (method, path) == ("POST", GATEWAY_CHAT_PATH)
    assert ws.api_client.do.call_args.kwargs["body"] == {
        "model": SERVICE, "messages": [{"role": "user", "content": "Reply with OK"}], "max_tokens": 5,
    }


@pytest.mark.parametrize("content", ["", None, [{"type": "reasoning", "summary": []}]])
def test_probe_ok_with_choices_and_no_text(content):
    assert TaxonomyLLM(_probe_ws(reply=_reply(content)), SERVICE).probe().status == "ok"


@pytest.mark.parametrize(
    "exc,status,needle",
    [
        (PermissionDenied("no EXECUTE. Config: host=x"), "denied", SP_ID),
        (NotFound(f"'{SERVICE}' does not exist."), "not_found", "was not found"),
        (_from(TimeoutError("Timed out"), TooManyRequests("x")), "busy", "busy right now"),
        (_from(TimeoutError("Timed out"), TemporarilyUnavailable("x")), "busy", "busy right now"),
        (BadRequest("INVALID_PARAMETER_VALUE: bad"), "error", "failed the test call: INVALID_PARAMETER_VALUE: bad"),
        (TimeoutError("Timed out after 0:01:30"), "error", "failed the test call: Timed out"),
    ],
)
def test_probe_outcomes(exc, status, needle):
    result = TaxonomyLLM(_probe_ws(exc=exc), SERVICE).probe()
    assert result.status == status
    assert needle in result.message


def _probe_ws_404_then(get_outcome):
    """POST (the gateway call) 404s; the UC GET then returns or raises
    ``get_outcome``."""
    ws = _probe_ws()

    def do(method, path, **kw):
        if method == "POST":
            raise NotFound(f"'{SERVICE}' does not exist.")
        assert path == f"/api/2.1/unity-catalog/model-services/{SERVICE}"
        if isinstance(get_outcome, Exception):
            raise get_outcome
        return get_outcome

    ws.api_client.do.side_effect = do
    return ws


def test_probe_not_found_but_service_exists_says_wait():
    """Right after a grant the gateway 404s for a minute or two (observed on a test workspace)."""
    result = TaxonomyLLM(_probe_ws_404_then({"name": f"model-services/{SERVICE}"}), SERVICE).probe()
    assert result.status == "not_found"
    assert result.message == (
        f"Model service '{SERVICE}' exists but the app can't use it yet. If access was just "
        "granted, wait a couple of minutes and test again."
    )


def test_probe_not_found_twice_says_not_found():
    result = TaxonomyLLM(_probe_ws_404_then(NotFound("Resource not found")), SERVICE).probe()
    assert result.status == "not_found"
    assert result.message == f"Model service '{SERVICE}' was not found."


def test_probe_not_found_and_lookup_fails_claims_neither():
    result = TaxonomyLLM(_probe_ws_404_then(PermissionDenied("no")), SERVICE).probe()
    assert result.status == "not_found"
    assert "was not found, or the app can't use it yet" in result.message


def test_probe_without_choices_is_error():
    result = TaxonomyLLM(_probe_ws(reply={"object": "chat.completion"}), SERVICE).probe()
    assert result.status == "error"


def test_complete_json_with_list_content_reasoning_and_text():
    """List content with reasoning block + text block containing JSON should parse."""
    content_list = [
        {"type": "reasoning", "summary": [{"type": "summary_text", "text": "", "signature": "sig"}]},
        {"type": "text", "text": GOOD}
    ]
    llm, _ = _llm(content_list)
    out = llm.complete_json("sys", "user", TaxonomySection)
    assert out.claims[0].provenance == "industry"


def test_complete_json_with_list_content_two_text_blocks():
    """List content with two text blocks that together form JSON should concatenate and parse."""
    content_list = [
        {"type": "text", "text": '{"claims": [{"text": "A CIS owns billing.", '},
        {"type": "text", "text": '"provenance": "industry"}]}'},
    ]
    llm, _ = _llm(content_list)
    out = llm.complete_json("sys", "user", TaxonomySection)
    assert out.claims[0].text == "A CIS owns billing."


def test_complete_json_with_list_content_only_reasoning_block():
    """List content with only reasoning block should raise 'empty reply' error."""
    content_list = [
        {"type": "reasoning", "summary": [{"type": "summary_text", "text": "", "signature": "sig"}]},
    ]
    llm, _ = _llm(content_list)
    with pytest.raises(TaxonomyLLMError, match="empty reply"):
        llm.complete_json("sys", "user", TaxonomySection)


def test_complete_json_with_int_content():
    """Content that is an int should raise 'unexpected' error."""
    llm, _ = _llm(42)
    with pytest.raises(TaxonomyLLMError, match="unexpected"):
        llm.complete_json("sys", "user", TaxonomySection)


def test_complete_text_with_list_content():
    """complete_text with list content should return joined text."""
    content_list = [
        {"type": "reasoning", "summary": [{"type": "summary_text", "text": "", "signature": "sig"}]},
        {"type": "text", "text": "Hello "},
        {"type": "text", "text": "world"},
    ]
    llm, _ = _llm(content_list)
    result = llm.complete_text("sys", "user")
    assert result == "Hello world"
