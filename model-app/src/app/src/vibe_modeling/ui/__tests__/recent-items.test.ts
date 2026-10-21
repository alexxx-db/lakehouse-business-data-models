/**
 * Pure tests for the "Jump back in" visit convention: `collectVisits` reads
 * business and model-version visit rows out of the preference list,
 * `pruneVisits` picks the stale and excess rows to delete on home load,
 * `buildRecentItems` merges businesses, industries (both `businesses` rows) and
 * visited model versions into one recency-ordered, capped list.
 */
import { describe, it, expect } from "vitest";
import type { BusinessListOut, UserPreferenceOut } from "@/lib/api";
import {
  MAX_BUSINESS_VISITS,
  MAX_PRUNE_PER_LOAD,
  MAX_VERSION_VISITS,
  PRUNE_GRACE_MS,
  RECENT_KIND_META,
  buildRecentItems,
  businessVisitKey,
  collectVisits,
  parseVersionPlace,
  parseVersionVisitKey,
  pruneVisits,
  versionPlaceValue,
  versionVisitKey,
} from "@/components/home/recent-items";

function biz(id: string, over: Partial<BusinessListOut> = {}): BusinessListOut {
  return {
    id,
    name: `Name ${id}`,
    kind: "business",
    industry_alignment: "",
    created_at: "2026-09-01T10:00:00Z",
    model_count: 0,
    ...over,
  };
}

function pref(key: string, updated_at: string, value = "1"): UserPreferenceOut {
  return { key, value, updated_at };
}

describe("collectVisits", () => {
  it("maps business visit keys to their updated_at", () => {
    const visits = collectVisits([
      pref("visit:business:biz-1", "2026-09-20T10:00:00Z"),
      pref("visit:business:ind-1", "2026-09-21T10:00:00Z"),
    ]);
    expect(Object.fromEntries(visits.businesses)).toEqual({
      "biz-1": "2026-09-20T10:00:00Z",
      "ind-1": "2026-09-21T10:00:00Z",
    });
    expect(visits.versions).toEqual([]);
  });

  it("reads version visit rows with their remembered domain", () => {
    const visits = collectVisits([
      pref("visit:version:biz-1:3:mvm", "2026-09-20T10:00:00Z", '{"domain":"Sales"}'),
      pref("visit:version:biz-1:2:ecm", "2026-09-19T10:00:00Z", "{}"),
      pref("visit:version:biz-2:1:mvm", "2026-09-18T10:00:00Z", "1"),
    ]);
    expect(visits.businesses.size).toBe(0);
    expect(visits.versions).toEqual([
      { businessId: "biz-1", version: 3, scope: "mvm", visitedAt: "2026-09-20T10:00:00Z", domain: "Sales" },
      { businessId: "biz-1", version: 2, scope: "ecm", visitedAt: "2026-09-19T10:00:00Z" },
      { businessId: "biz-2", version: 1, scope: "mvm", visitedAt: "2026-09-18T10:00:00Z" },
    ]);
  });

  it("ignores malformed version keys", () => {
    const at = "2026-09-20T10:00:00Z";
    const visits = collectVisits([
      pref("visit:version:biz-1:abc:mvm", at),
      pref("visit:version:biz-1:03:mvm", at),
      pref("visit:version:biz-1:0:mvm", at),
      pref("visit:version:biz-1:3:xyz", at),
      pref("visit:version::3:mvm", at),
      pref("visit:version:biz-1:3", at),
      pref("visit:version:", at),
    ]);
    expect(visits.versions).toEqual([]);
  });

  it("ignores unrelated preference keys and a bare prefix", () => {
    const visits = collectVisits([
      pref("diagram.default_column_mode", "2026-09-20T10:00:00Z", "pk-fk"),
      pref("visit:business:", "2026-09-20T10:00:00Z"),
      pref("visit:run:r1", "2026-09-20T10:00:00Z"),
    ]);
    expect(visits.businesses.size).toBe(0);
  });

  it("round-trips businessVisitKey", () => {
    const visits = collectVisits([pref(businessVisitKey("x-1"), "2026-09-20T10:00:00Z")]);
    expect([...visits.businesses.keys()]).toEqual(["x-1"]);
  });
});

describe("versionVisitKey", () => {
  it("builds the natural key for a real version", () => {
    expect(versionVisitKey("biz-1", "3", "mvm")).toBe("visit:version:biz-1:3:mvm");
    expect(versionVisitKey("biz-1", 12, "ecm")).toBe("visit:version:biz-1:12:ecm");
  });

  it("returns null for a version or scope the reader would reject", () => {
    expect(versionVisitKey("biz-1", "abc", "foo")).toBeNull();
    expect(versionVisitKey("biz-1", "03", "mvm")).toBeNull();
    expect(versionVisitKey("biz-1", "0", "mvm")).toBeNull();
    expect(versionVisitKey("biz-1", "-1", "mvm")).toBeNull();
    expect(versionVisitKey("biz-1", "1.5", "mvm")).toBeNull();
    expect(versionVisitKey("biz-1", "3", "xyz")).toBeNull();
    expect(versionVisitKey("biz-1", "3", "")).toBeNull();
    expect(versionVisitKey("", "3", "mvm")).toBeNull();
  });

  it("rejects params that would shift the business id when parsed from the right", () => {
    expect(versionVisitKey("biz", "1:2", "mvm")).toBeNull();
  });

  it("round-trips through parseVersionVisitKey, including a business id with colons", () => {
    expect(parseVersionVisitKey(versionVisitKey("a:b", "7", "ecm")!)).toEqual({
      businessId: "a:b",
      version: 7,
      scope: "ecm",
    });
  });
});

describe("parseVersionVisitKey", () => {
  it("rejects a version beyond the safe integer range", () => {
    expect(parseVersionVisitKey("visit:version:biz-1:9007199254740993:mvm")).toBeNull();
    expect(parseVersionVisitKey(`visit:version:biz-1:1${"0".repeat(21)}:mvm`)).toBeNull();
    expect(versionVisitKey("biz-1", "9007199254740993", "mvm")).toBeNull();
    expect(parseVersionVisitKey("visit:version:biz-1:9007199254740991:mvm")).toMatchObject({
      version: 9007199254740991,
    });
  });

  it("rejects keys outside the version prefix", () => {
    expect(parseVersionVisitKey("visit:business:biz-1")).toBeNull();
    expect(parseVersionVisitKey("diagram.default_column_mode")).toBeNull();
  });
});

describe("version place value", () => {
  it("serializes the overview and a domain as stable JSON", () => {
    expect(versionPlaceValue()).toBe("{}");
    expect(versionPlaceValue("")).toBe("{}");
    expect(versionPlaceValue("Sales & Marketing")).toBe('{"domain":"Sales & Marketing"}');
  });

  it("parses a remembered domain", () => {
    expect(parseVersionPlace('{"domain":"Sales"}')).toEqual({ domain: "Sales" });
    expect(parseVersionPlace(versionPlaceValue("A \"quoted\" one"))).toEqual({
      domain: 'A "quoted" one',
    });
  });

  it.each([
    ["empty object", "{}"],
    ["empty domain", '{"domain":""}'],
    ["non-string domain", '{"domain":3}'],
    ["null domain", '{"domain":null}'],
    ["legacy value", "1"],
    ["invalid JSON", "{bad"],
    ["empty string", ""],
    ["array", '["Sales"]'],
    ["null", "null"],
    ["string", '"Sales"'],
  ])("treats %s as the overview", (_name, value) => {
    expect(parseVersionPlace(value)).toEqual({});
  });
});

describe("buildRecentItems", () => {
  const none = collectVisits([]);

  it("builds an industry item with its kind, label, key and template subtitle", () => {
    const [item] = buildRecentItems([biz("ind-1", { kind: "industry", name: "Retail Banking" })], none);
    expect(item).toMatchObject({
      key: "industry:ind-1",
      kind: "industry",
      title: "Retail Banking",
      subtitle: "template",
      businessId: "ind-1",
    });
    expect(RECENT_KIND_META[item.kind].label).toBe("Industry");
  });

  it("builds a business item with its model count subtitle", () => {
    const items = buildRecentItems(
      [biz("a", { model_count: 1 }), biz("b", { model_count: 3 }), biz("c")],
      none,
    );
    const subtitles = Object.fromEntries(items.map((i) => [i.businessId, i.subtitle]));
    expect(subtitles).toEqual({
      a: "1 model version",
      b: "3 model versions",
      c: "No models yet",
    });
    expect(RECENT_KIND_META.business.label).toBe("Business");
  });

  it("treats a row without kind as a business", () => {
    const row = biz("a");
    delete row.kind;
    expect(buildRecentItems([row], none)[0].kind).toBe("business");
  });

  it("ranks a visited industry ahead of a newer never-visited business", () => {
    const items = buildRecentItems(
      [
        biz("new-biz", { created_at: "2026-09-15T10:00:00Z" }),
        biz("ind-1", { kind: "industry", created_at: "2026-09-01T10:00:00Z" }),
      ],
      collectVisits([pref(businessVisitKey("ind-1"), "2026-09-20T10:00:00Z")]),
    );
    expect(items.map((i) => i.key)).toEqual(["industry:ind-1", "business:new-biz"]);
    expect(items[0].timestamp).toBe("2026-09-20T10:00:00Z");
  });

  it("caps the list at 8 by default and honours an explicit limit", () => {
    const rows = Array.from({ length: 12 }, (_, i) =>
      biz(`b${String(i).padStart(2, "0")}`, {
        created_at: `2026-09-${String(i + 1).padStart(2, "0")}T10:00:00Z`,
      }),
    );
    const items = buildRecentItems(rows, none);
    expect(items).toHaveLength(8);
    expect(items[0].businessId).toBe("b11");
    expect(buildRecentItems(rows, none, 3)).toHaveLength(3);
  });

  it("orders equal timestamps deterministically by key", () => {
    const same = "2026-09-10T10:00:00Z";
    const rows = [
      biz("z", { created_at: same }),
      biz("m", { kind: "industry", created_at: same }),
      biz("a", { created_at: same }),
    ];
    const expected = ["business:a", "business:z", "industry:m"];
    expect(buildRecentItems(rows, none).map((i) => i.key)).toEqual(expected);
    expect(buildRecentItems([...rows].reverse(), none).map((i) => i.key)).toEqual(expected);
  });

  it("sinks rows with an unparseable timestamp below valid ones, whatever the input order", () => {
    const rows = [
      biz("bad-b", { created_at: "not-a-date" }),
      biz("old", { created_at: "2026-09-01T10:00:00Z" }),
      biz("bad-a", { created_at: "" }),
      biz("new", { created_at: "2026-09-15T10:00:00Z" }),
    ];
    const expected = ["business:new", "business:old", "business:bad-a", "business:bad-b"];
    const perms = [
      [0, 1, 2, 3],
      [3, 2, 1, 0],
      [1, 3, 0, 2],
      [2, 0, 3, 1],
      [0, 3, 1, 2],
    ];
    for (const perm of perms) {
      const input = perm.map((i) => rows[i]);
      expect(buildRecentItems(input, none).map((i) => i.key)).toEqual(expected);
    }
  });

  it("puts an offset-less visit time and a Z created_at on one epoch", () => {
    const rows = [
      biz("never", { created_at: "2026-09-10T12:00:00Z" }),
      biz("visited", { created_at: "2026-09-01T10:00:00Z" }),
    ];
    const items = buildRecentItems(
      rows,
      collectVisits([pref(businessVisitKey("visited"), "2026-09-10T12:00:01")]),
    );
    expect(items.map((i) => i.businessId)).toEqual(["visited", "never"]);
    expect(items[0].timestamp).toBe("2026-09-10T12:00:01Z");

    const earlier = buildRecentItems(
      rows,
      collectVisits([pref(businessVisitKey("visited"), "2026-09-10T11:59:59")]),
    );
    expect(earlier.map((i) => i.businessId)).toEqual(["never", "visited"]);
  });
  describe("model versions", () => {
    const owned = (id: string, over: Partial<BusinessListOut> = {}) =>
      biz(id, { downloaded_scopes: ["ecm", "mvm"], created_at: "2026-09-01T10:00:00Z", ...over });
    const vpref = (key: string, at: string, value = "{}") => pref(key, at, value);

    it("builds a version item titled by the business, with an overview subtitle", () => {
      const [item] = buildRecentItems(
        [owned("biz-1", { name: "Retail Bank" })],
        collectVisits([vpref("visit:version:biz-1:3:mvm", "2026-09-20T10:00:00Z")]),
      );
      expect(item).toMatchObject({
        key: "model_version:biz-1:3:mvm",
        kind: "model_version",
        title: "Retail Bank",
        subtitle: "v3 MVM",
        businessId: "biz-1",
        version: 3,
        scope: "mvm",
        timestamp: "2026-09-20T10:00:00Z",
      });
      expect(item).not.toHaveProperty("domain");
      expect(RECENT_KIND_META.model_version.label).toBe("Model version");
    });

    it("appends the remembered domain after a space, middle dot, space", () => {
      const [item] = buildRecentItems(
        [owned("biz-1")],
        collectVisits([
          vpref("visit:version:biz-1:3:mvm", "2026-09-20T10:00:00Z", '{"domain":"Sales"}'),
        ]),
      );
      expect(item.subtitle).toBe("v3 MVM \u00b7 Sales");
      expect(item).toMatchObject({ kind: "model_version", domain: "Sales" });
    });

    it("never emits an item for a version that was not visited", () => {
      const items = buildRecentItems([owned("biz-1", { model_count: 4 })], none);
      expect(items.map((i) => i.kind)).toEqual(["business"]);
    });

    it("drops a version whose business is not listed", () => {
      const items = buildRecentItems(
        [owned("biz-1")],
        collectVisits([vpref("visit:version:gone:3:mvm", "2026-09-20T10:00:00Z")]),
      );
      expect(items.map((i) => i.key)).toEqual(["business:biz-1"]);
    });

    it("drops a version whose scope is not downloaded", () => {
      const items = buildRecentItems(
        [owned("biz-1", { downloaded_scopes: ["ecm"] }), owned("biz-2", { downloaded_scopes: undefined })],
        collectVisits([
          vpref("visit:version:biz-1:3:mvm", "2026-09-20T10:00:00Z"),
          vpref("visit:version:biz-2:1:ecm", "2026-09-20T10:00:00Z"),
          vpref("visit:version:biz-1:2:ecm", "2026-09-19T10:00:00Z"),
        ]),
      );
      expect(items.filter((i) => i.kind === "model_version").map((i) => i.key)).toEqual([
        "model_version:biz-1:2:ecm",
      ]);
    });

    it("interleaves version and business items by recency and shows each version of a business", () => {
      const items = buildRecentItems(
        [owned("biz-1", { created_at: "2026-09-05T10:00:00Z" }), owned("biz-2", { created_at: "2026-09-18T10:00:00Z" })],
        collectVisits([
          pref(businessVisitKey("biz-1"), "2026-09-17T10:00:00Z"),
          vpref("visit:version:biz-1:3:mvm", "2026-09-21T10:00:00Z"),
          vpref("visit:version:biz-1:2:mvm", "2026-09-16T10:00:00Z"),
        ]),
      );
      expect(items.map((i) => i.key)).toEqual([
        "model_version:biz-1:3:mvm",
        "business:biz-2",
        "business:biz-1",
        "model_version:biz-1:2:mvm",
      ]);
    });

    it("puts model_version first on a timestamp tie, then orders by key", () => {
      const same = "2026-09-20T10:00:00Z";
      const rows = [owned("a", { created_at: same }), owned("z", { created_at: same })];
      const visits = collectVisits([
        vpref("visit:version:z:1:mvm", same),
        vpref("visit:version:a:2:mvm", same),
      ]);
      const expected = [
        "model_version:a:2:mvm",
        "model_version:z:1:mvm",
        "business:a",
        "business:z",
      ];
      expect(buildRecentItems(rows, visits).map((i) => i.key)).toEqual(expected);
      expect(buildRecentItems([...rows].reverse(), collectVisits([
        vpref("visit:version:a:2:mvm", same),
        vpref("visit:version:z:1:mvm", same),
      ])).map((i) => i.key)).toEqual(expected);
    });

    it("applies the cap across businesses and versions together", () => {
      const rows = [owned("biz-1")];
      const prefs = Array.from({ length: 10 }, (_, i) =>
        vpref(`visit:version:biz-1:${i + 1}:mvm`, `2026-09-${String(i + 10).padStart(2, "0")}T10:00:00Z`),
      );
      const items = buildRecentItems(rows, collectVisits(prefs));
      expect(items).toHaveLength(8);
      expect(items[0].key).toBe("model_version:biz-1:10:mvm");
    });

    it("puts an offset-less version visit time on the same epoch as a Z timestamp", () => {
      const items = buildRecentItems(
        [owned("biz-1", { created_at: "2026-09-10T12:00:00Z" })],
        collectVisits([vpref("visit:version:biz-1:1:mvm", "2026-09-10T12:00:01")]),
      );
      expect(items[0].key).toBe("model_version:biz-1:1:mvm");
      expect(items[0].timestamp).toBe("2026-09-10T12:00:01Z");
    });
  });
});

describe("pruneVisits", () => {
  const FETCHED = Date.parse("2026-10-01T12:00:00Z");
  const OLD = "2026-09-01T10:00:00Z";
  const inGrace = new Date(FETCHED - PRUNE_GRACE_MS / 2).toISOString();
  const listed = [biz("biz-1", { downloaded_scopes: ["mvm"] })];

  function isoDaysAgo(days: number): string {
    return new Date(FETCHED - days * 86_400_000 - PRUNE_GRACE_MS * 2).toISOString();
  }

  it("returns nothing for healthy rows", () => {
    expect(
      pruneVisits(
        [
          pref("visit:business:biz-1", OLD),
          pref("visit:version:biz-1:3:mvm", OLD, "{}"),
          pref("diagram.default_column_mode", OLD, "hide"),
        ],
        listed,
        FETCHED,
      ),
    ).toEqual([]);
  });

  it("prunes business and version visits whose business is not listed", () => {
    expect(
      pruneVisits(
        [
          pref("visit:business:gone", OLD),
          pref("visit:version:gone:1:mvm", OLD),
          pref("visit:version:biz-1:3:mvm", OLD),
        ],
        listed,
        FETCHED,
      ),
    ).toEqual(["visit:business:gone", "visit:version:gone:1:mvm"]);
  });

  it("prunes a version visit whose scope is not downloaded or not reported", () => {
    const businesses = [
      biz("biz-1", { downloaded_scopes: ["mvm"] }),
      biz("biz-2"),
    ];
    expect(
      pruneVisits(
        [
          pref("visit:version:biz-1:2:ecm", OLD),
          pref("visit:version:biz-2:1:mvm", OLD),
          pref("visit:version:biz-1:3:mvm", OLD),
        ],
        businesses,
        FETCHED,
      ),
    ).toEqual(["visit:version:biz-1:2:ecm", "visit:version:biz-2:1:mvm"]);
  });

  it("prunes malformed version keys even inside the grace window", () => {
    expect(
      pruneVisits(
        [
          pref("visit:version:biz-1:abc:mvm", inGrace),
          pref("visit:version:biz-1:03:mvm", inGrace),
          pref("visit:version:biz-1:2:xyz", inGrace),
          pref("visit:version:biz-1", inGrace),
          pref("visit:version:", inGrace),
        ],
        listed,
        FETCHED,
      ),
    ).toEqual([
      "visit:version:biz-1:abc:mvm",
      "visit:version:biz-1:03:mvm",
      "visit:version:biz-1:2:xyz",
      "visit:version:biz-1",
      "visit:version:",
    ]);
  });

  it("never applies the missing-business or missing-scope rules to rows inside the grace window", () => {
    expect(
      pruneVisits(
        [
          pref("visit:business:new-biz", inGrace),
          pref("visit:version:new-biz:1:mvm", inGrace),
          pref("visit:version:biz-1:2:ecm", inGrace),
        ],
        listed,
        FETCHED,
      ),
    ).toEqual([]);
  });

  it("prunes a stale row just past the grace boundary and keeps one exactly on it", () => {
    const past = new Date(FETCHED - PRUNE_GRACE_MS - 1).toISOString();
    const edge = new Date(FETCHED - PRUNE_GRACE_MS).toISOString();
    expect(
      pruneVisits(
        [pref("visit:business:a", past), pref("visit:business:b", edge)],
        listed,
        FETCHED,
      ),
    ).toEqual(["visit:business:a"]);
  });

  it("treats an offset-less updated_at as UTC for the grace window", () => {
    const offsetless = new Date(FETCHED - PRUNE_GRACE_MS / 2).toISOString().replace("Z", "");
    const oldOffsetless = OLD.replace("Z", "");
    expect(
      pruneVisits(
        [
          pref("visit:business:fresh", offsetless),
          pref("visit:business:old", oldOffsetless),
        ],
        listed,
        FETCHED,
      ),
    ).toEqual(["visit:business:old"]);
  });

  it("deletes the oldest version visits beyond the newest 50", () => {
    const businesses = [biz("biz-1", { downloaded_scopes: ["mvm"] })];
    const prefs = Array.from({ length: 60 }, (_, i) =>
      pref(`visit:version:biz-1:${i + 1}:mvm`, isoDaysAgo(60 - i)),
    );
    expect(MAX_VERSION_VISITS).toBe(50);
    const result = pruneVisits([...prefs].reverse(), businesses, FETCHED);
    expect(new Set(result)).toEqual(
      new Set(Array.from({ length: 10 }, (_, i) => `visit:version:biz-1:${i + 1}:mvm`)),
    );
    expect(result).toHaveLength(10);
  });

  it("deletes the oldest business visits beyond the newest 50", () => {
    const ids = Array.from({ length: 60 }, (_, i) => `b${i}`);
    const businesses = ids.map((id) => biz(id));
    const prefs = ids.map((id, i) => pref(`visit:business:${id}`, isoDaysAgo(60 - i)));
    expect(MAX_BUSINESS_VISITS).toBe(50);
    const result = pruneVisits(prefs, businesses, FETCHED);
    expect(new Set(result)).toEqual(new Set(ids.slice(0, 10).map((id) => `visit:business:${id}`)));
  });

  it("keeps the version and business caps independent", () => {
    const ids = Array.from({ length: 50 }, (_, i) => `b${i}`);
    const businesses = ids.map((id) => biz(id, { downloaded_scopes: ["mvm"] }));
    const prefs = [
      ...ids.map((id, i) => pref(`visit:business:${id}`, isoDaysAgo(i))),
      ...ids.map((id, i) => pref(`visit:version:${id}:1:mvm`, isoDaysAgo(i))),
    ];
    expect(pruneVisits(prefs, businesses, FETCHED)).toEqual([]);
  });

  it("does not count stale rows against the newest 50", () => {
    const businesses = [biz("biz-1", { downloaded_scopes: ["mvm"] })];
    const prefs = [
      ...Array.from({ length: 50 }, (_, i) =>
        pref(`visit:version:biz-1:${i + 1}:mvm`, isoDaysAgo(100 - i)),
      ),
      pref("visit:version:gone:1:mvm", isoDaysAgo(1)),
    ];
    expect(pruneVisits(prefs, businesses, FETCHED)).toEqual(["visit:version:gone:1:mvm"]);
  });

  it("never returns non-visit keys or other visit sub-prefixes", () => {
    const result = pruneVisits(
      [
        pref("diagram.default_column_mode", OLD, "hide"),
        pref("visit:run:abc", OLD),
        pref("visit:", OLD),
        pref("visit:businessX", OLD),
        pref("visits:business:gone", OLD),
        pref("visit:business:gone", OLD),
      ],
      [],
      FETCHED,
    );
    expect(result).toEqual(["visit:business:gone"]);
  });

  it("prunes a business visit key with an empty id even inside the grace window", () => {
    expect(
      pruneVisits(
        [pref("visit:business:", inGrace), pref("visit:business:biz-1", OLD)],
        listed,
        FETCHED,
      ),
    ).toEqual(["visit:business:"]);
  });

  it("caps at 20 keys with stale rows before excess rows", () => {
    const stale = Array.from({ length: 15 }, (_, i) => pref(`visit:business:gone${i}`, OLD));
    const live = Array.from({ length: 60 }, (_, i) =>
      pref(`visit:business:b${i}`, isoDaysAgo(60 - i)),
    );
    const businesses = live.map((_, i) => biz(`b${i}`));
    const result = pruneVisits([...live, ...stale], businesses, FETCHED);
    expect(MAX_PRUNE_PER_LOAD).toBe(20);
    expect(result).toHaveLength(20);
    expect(result.slice(0, 15)).toEqual(stale.map((p) => p.key));
    expect(result.slice(15)).toEqual([
      "visit:business:b0",
      "visit:business:b1",
      "visit:business:b2",
      "visit:business:b3",
      "visit:business:b4",
    ]);
  });
});
