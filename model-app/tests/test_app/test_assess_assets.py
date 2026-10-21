"""Vendored assessment skills stay in sync with VERSIONS.json and ship with their markers.

The packaging test (design §6): every staged and hand-off skill resolves from the
packaged tree with a SKILL.md and a ``.vibe-skill-version`` marker equal to
``"<skills_version> <skills_ref>"``, the marker reaches both the job folder upload and
a user's skills install, and the notebook stages the skills from that bundle only.
"""
import importlib.util
import json
import pathlib

from vibe_modeling.backend.assessment import assets
from vibe_modeling.backend.assessment.skill_install import _skill_files

ROOT = pathlib.Path(__file__).parents[2] / "src/app/vendored/assessment"


def _lib():
    spec = importlib.util.spec_from_file_location("assess_lib", ROOT / "assess_lib.py")
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def test_vendored_skills_cover_every_handoff_skill():
    v = json.loads((ROOT / "VERSIONS.json").read_text())
    assert v["staged_skills"] == ["domain-model-assessment", "autonomous-validation"]
    assert set(v["staged_skills"]) <= set(v["handoff_skills"])
    assert len(v["handoff_skills"]) == 6
    for name in v["handoff_skills"]:
        assert (ROOT / "skills" / name / "SKILL.md").is_file(), name
        stamp = (ROOT / "skills" / name / ".vibe-skill-version").read_text().strip()
        assert stamp == f'{v["skills_version"]} {v["skills_ref"]}'


def test_every_staged_and_handoff_skill_resolves_with_a_matching_marker():
    root = assets.resolve_vendored_assessment()
    assert root is not None
    v = assets.read_versions()
    expected = f'{v["skills_version"]} {v["skills_ref"]}'
    names = list(dict.fromkeys(v["staged_skills"] + v["handoff_skills"]))
    assert assets.read_bundled_skill_versions(names) == {n: expected for n in names}
    for n in names:
        assert (root / "skills" / n / "SKILL.md").is_file(), n


def test_the_job_folder_upload_carries_each_skill_and_its_marker():
    root, files = assets.bundle_files()
    rel = {f.relative_to(root).as_posix() for f in files}
    v = assets.read_versions()
    for n in v["handoff_skills"]:
        assert f"skills/{n}/SKILL.md" in rel, n
        assert f"skills/{n}/{assets.SKILL_VERSION_FILE}" in rel, n
    assert not any("__pycache__" in r or r.endswith(".DS_Store") for r in rel)


def test_a_users_skills_install_carries_the_marker_last():
    v = assets.read_versions()
    for n in v["handoff_skills"]:
        files = _skill_files(n)
        assert files[-1].name == assets.SKILL_VERSION_FILE, n
        assert any(f.name == "SKILL.md" for f in files), n


def test_the_notebook_stages_the_bundle_it_ships_with(tmp_path):
    lib = _lib()
    assert lib.SKILL_VERSION_FILE == assets.SKILL_VERSION_FILE
    v = assets.read_versions()
    info = lib.stage_bundled_skills(ROOT / "skills", tmp_path / "skills", v["staged_skills"])
    expected = f'{v["skills_version"]} {v["skills_ref"]}'
    assert info["markers"] == {n: expected for n in v["staged_skills"]}
    assert (info["version"], info["ref"]) == (v["skills_version"], v["skills_ref"])
    assert sorted(p.name for p in (tmp_path / "skills").iterdir()) == sorted(v["staged_skills"])


def test_the_notebook_never_fetches_skills():
    src = (ROOT / "assess_domain.py").read_text()
    for gone in ("api.github.com", "codeload.github.com", "skills_repo", "skills_ref", "bundle_fallback",
                 "skills_source_plan", "dev_skills_info"):
        assert gone not in src, gone
    lib_src = (ROOT / "assess_lib.py").read_text()
    assert "def skills_source_plan" not in lib_src and "def dev_skills_info" not in lib_src
