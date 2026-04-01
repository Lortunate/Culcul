# Bilibili API Documentation Lookup Rules (socialsisteryi/bilibili-api-collect)

Last updated: 2026-04-01

## 1. Canonical Source and Retrieval Order
- Primary source: Context7 with `/socialsisteryi/bilibili-api-collect`.
- Required sequence:
  1. `resolve_library_id` (confirm exact library)
  2. `query_docs` (target endpoint-specific docs)
- If Context7 fails, use a clearly labeled fallback:
  1. GitHub source file in the same repo
  2. General web search (last resort)

## 2. Query Strategy (Narrow to Broad)
- Start with exact endpoint path (example: `/x/player/wbi/v2`).
- Then query parameter constraints (`aid`, `bvid`, `cid`, `w_rid`, `wts`).
- Then query error semantics (`code`, `message`, `ttl`, known errors like `-400`).
- For auth/signature endpoints, explicitly query required headers and signature fields.

## 3. Context7 Usage Discipline
- Prefer one question per query to keep evidence precise.
- Use at most 3 Context7 calls per user request unless explicitly necessary.
- If multiple docs match, prioritize the endpoint page under `docs/video/*`, `docs/user/*`, etc.

## 4. Parameter Validation Rules (Implementation Contract)
- Never send placeholder values for required parameters (`0`, empty string, null-equivalent).
- For either-or parameters (for example `aid` or `bvid`):
  - ensure at least one is present
  - enforce mutual exclusivity if docs specify exclusivity
- If required params are not ready yet, short-circuit locally instead of issuing the request.

## 5. Evidence Logging Format (for PRs / change notes)
For each API-related fix, record:
- Endpoint: exact path
- Constraints: required params / mutually exclusive params
- Error basis: code and meaning
- Source: exact docs file URL
- Local policy: what guard/check was added in code

Example format:
- `Endpoint`: `/x/player/wbi/v2`
- `Constraints`: `cid` required; `aid`/`bvid` choose one
- `Error`: `-400` = request error
- `Source`: `docs/video/player.md`
- `Code policy`: skip request when `aid <= 0` or `cid <= 0`

## 6. Fact vs Inference Labeling
- Facts: direct statements from docs.
- Inferences: local implementation decisions made from those facts.
- Do not present implementation strategy as if it were a quoted doc rule.

## 7. Safety Checklist Before Shipping
- Endpoint path matches exactly.
- Parameter names match docs exactly.
- Required parameters validated before request.
- Either-or parameter logic covered.
- Error handling path tested for invalid inputs.
- Source link included in change summary.

## 8. This Incident Baseline (2026-04-01)
- Endpoint: `/x/player/wbi/v2`
- Doc facts used: `cid` is required; `aid` and `bvid` are alternatives; invalid requests may return `code = -400`.
- Applied local rule: do not call `fetchPlayerInfo` when `aid <= 0` or `cid <= 0`.