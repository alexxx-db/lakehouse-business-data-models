"""UC model-service name rule (``taxonomy/service_name.py``), shared by Settings and the installer."""
import pytest

from vibe_modeling.backend.taxonomy.service_name import split_model_service_name, strip_resource_prefix


@pytest.mark.parametrize("name", ["system.ai.claude-sonnet-5-5", "main.models.drafting_v2", 'main.models.say"hi"'])
def test_model_service_name_accepts_three_parts(name):
    assert ".".join(split_model_service_name(name)) == name


@pytest.mark.parametrize(
    "name",
    [
        "",
        "ai.claude",
        "a.b.c.d",
        "a..c",
        "a b.c.d",
        "a/b.c.d",
        "a.b.c\x01",
        "a.b.c\n",
        "\na.b.c",
        f"{'x' * 256}.b.c",
    ],
)
def test_model_service_name_rejects_gateway_invalid(name):
    with pytest.raises(ValueError):
        split_model_service_name(name)


def test_strip_model_services_prefix():
    assert strip_resource_prefix("model-services/system.ai.x") == "system.ai.x"
    assert strip_resource_prefix("system.ai.x") == "system.ai.x"
