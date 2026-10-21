"""CLI pins for the assessment job: VERSIONS.json shape, the notebook's
download plan, and the tag-keyed cache that re-hashes before reuse."""
from __future__ import annotations

import hashlib
import importlib.util
import json
import re
from pathlib import Path

import pytest

REPO = Path(__file__).resolve().parents[2]
VENDOR = REPO / "src/app/vendored/assessment"
_spec = importlib.util.spec_from_file_location("assess_lib", VENDOR / "assess_lib.py")
assess_lib = importlib.util.module_from_spec(_spec); _spec.loader.exec_module(assess_lib)

VERSIONS = json.loads((VENDOR / "VERSIONS.json").read_text())
SHA = re.compile(r"^[0-9a-f]{64}$")


def test_versions_pin_both_clis_with_sha256_per_arch():
    assert set(VERSIONS["genie"]["sha256"]) == {"x86_64", "aarch64"}
    assert set(VERSIONS["databricks_cli"]["sha256"]) == {"amd64", "arm64"}
    for tool in ("genie", "databricks_cli"):
        assert re.match(r"^v\d+\.\d+\.\d+", VERSIONS[tool]["tag"]), tool
        assert all(SHA.match(v) for v in VERSIONS[tool]["sha256"].values()), tool
    assert "genie_version" not in VERSIONS


def test_versions_pin_the_model():
    assert VERSIONS["genie_model"] == "gpt-5.6-sol"
    assert VERSIONS["genie_model_service"] == "system.ai.gpt-5-6-sol"
    ui = (REPO / "src/app/src/vibe_modeling/ui/lib/assessment.ts").read_text()
    assert f'export const ASSESS_MODEL = "{VERSIONS["genie_model"]}";' in ui


def test_notebook_has_no_unpinned_download_or_hardcoded_model():
    nb = (VENDOR / "assess_domain.py").read_text()
    assert "releases/latest" not in nb
    assert ".sha256\"" not in nb and ".sha256'" not in nb
    assert 'model = "gpt-' not in nb
    assert "assess_lib.ensure_pinned_archive" in nb and "assess_lib.tool_downloads" in nb
    assert "vibe-assess-headless" not in nb


def test_install_reads_the_model_service_from_versions():
    sh = (REPO / "install/install.sh").read_text()
    assert "jq -r .genie_model_service src/app/vendored/assessment/VERSIONS.json" in sh
    assert "gpt-5-6-sol" not in sh


@pytest.mark.parametrize("machine,genie_arch,cli_arch", [
    ("x86_64", "x86_64", "amd64"), ("aarch64", "aarch64", "arm64"), ("arm64", "aarch64", "arm64"),
])
def test_tool_downloads(machine, genie_arch, cli_arch):
    d = assess_lib.tool_downloads(VERSIONS, machine)
    g, c = d["genie"], d["databricks_cli"]
    assert g["tag"] == VERSIONS["genie"]["tag"] and g["sha256"] == VERSIONS["genie"]["sha256"][genie_arch]
    assert g["url"] == (f"https://github.com/databricks/genie-code-cli/releases/download/{g['tag']}/"
                        f"genie-package-{genie_arch}-unknown-linux-musl.tar.gz")
    ver = VERSIONS["databricks_cli"]["tag"].lstrip("v")
    assert c["sha256"] == VERSIONS["databricks_cli"]["sha256"][cli_arch]
    assert c["url"] == (f"https://github.com/databricks/cli/releases/download/{VERSIONS['databricks_cli']['tag']}/"
                        f"databricks_cli_{ver}_linux_{cli_arch}.zip")


def _download(payload: bytes, asset="tool.zip"):
    return {"tag": "v1", "asset": asset, "url": "https://x/tool.zip", "sha256": hashlib.sha256(payload).hexdigest()}


def _fetcher(payload: bytes, calls: list):
    def fetch(url, dest):
        calls.append(url)
        Path(dest).write_bytes(payload)
        return dest
    return fetch


def test_downloads_and_verifies_into_the_tag_folder(tmp_path):
    calls: list = []
    cache = tmp_path / "tool" / "v1"
    path = assess_lib.ensure_pinned_archive(cache, _download(b"good"), _fetcher(b"good", calls))
    assert path == cache / "tool.zip" and path.read_bytes() == b"good" and calls == ["https://x/tool.zip"]


def test_reuses_a_cached_archive_that_matches_the_pin(tmp_path):
    calls: list = []
    cache = tmp_path / "tool" / "v1"
    cache.mkdir(parents=True)
    (cache / "tool.zip").write_bytes(b"good")
    assess_lib.ensure_pinned_archive(cache, _download(b"good"), _fetcher(b"good", calls))
    assert calls == []


def test_refetches_a_tampered_cached_archive(tmp_path):
    calls: list = []
    cache = tmp_path / "tool" / "v1"
    cache.mkdir(parents=True)
    (cache / "tool.zip").write_bytes(b"tampered")
    (cache / "stale-binary").write_bytes(b"x")
    path = assess_lib.ensure_pinned_archive(cache, _download(b"good"), _fetcher(b"good", calls))
    assert calls and path.read_bytes() == b"good" and not (cache / "stale-binary").exists()


def test_a_download_that_does_not_match_the_pin_raises(tmp_path):
    cache = tmp_path / "tool" / "v1"
    with pytest.raises(RuntimeError, match="sha256 mismatch"):
        assess_lib.ensure_pinned_archive(cache, _download(b"good"), _fetcher(b"evil", []))
    assert not (cache / "tool.zip").exists()
