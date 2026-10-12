import json

CLASSIFIER_SYSTEM = "You state exactly what each extracted requirement asks a data model to change."


def is_classifier_call(system, user=""):
    return system == CLASSIFIER_SYSTEM or "Return one spec per requirement" in str(user or "")


def requested_items(user):
    block = str(user).split("REQUIREMENTS:\n", 1)[1].split("\n\nOutput JSON:", 1)[0]
    return json.loads(block)


def requested_ids(user):
    return [str(item["id"]) for item in requested_items(user)]


def _target(fqn):
    parts = (str(fqn).split(".") + ["", "", ""])[:3]
    return {"domain": parts[0], "product": parts[1], "column": parts[2]}


def spec(vid, action, targets=(), breadth="named", **fields):
    out = {"id": vid, "action": action, "breadth": breadth, "targets": [_target(t) for t in targets], "fields": [], "fill_only": False,
           "columns": [], "fk_target": "", "new_name": "", "destination_domain": "", "split_into": [], "merge_into": "", "column_type": "",
           "interpretable": True, "reason": "canned test spec"}
    out.update(fields)
    return out


def field(level, name):
    return {"level": level, "field": name}


def reply(user, specs):
    if callable(specs):
        return {"specs": [s for s in (specs(item) for item in requested_items(user)) if s]}
    by_id = {s["id"]: s for s in specs}
    return {"specs": [by_id[vid] for vid in requested_ids(user) if vid in by_id]}


class SpecOnlyLLM:
    def __init__(self, specs):
        self.specs = specs
        self.prompts = []

    def complete_json(self, system, user, temperature=0.0, response_schema=None):
        self.prompts.append((system, user))
        if is_classifier_call(system, user):
            return reply(user, self.specs)
        raise AssertionError("only the requirement classifier may call the LLM")

    def complete_with_tools(self, system, user, tools, tool_handlers, max_iters=6, temperature=0.0, response_schema=None):
        return self.complete_json(system, user, temperature, response_schema)


def register(ah, model, *specs):
    idx = ah._vreq_spec_index(model)
    ah.register_vreq_specs({s["id"]: ah._normalize_vreq_spec(s, idx) for s in specs})
