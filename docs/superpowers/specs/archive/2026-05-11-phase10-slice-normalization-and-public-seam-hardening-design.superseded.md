> **Superseded on 2026-05-11 after partial landing:** This archive is preserved as transitional planning context. Phase 10 did land important structural moves such as `feature_scope.dart` facade entrypoints, `phase10_*` architecture guards, and major `dynamic` / `video` directory normalization. It is archived as superseded rather than completed because the repo truth drifted: the docs disagreed about status, some facades remained placeholder or repository-shaped, and the guard semantics were too narrow to prove the claimed public-seam hardening.
>
> **Replaced by spec:** `docs/superpowers/specs/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams-design.md`
> **Replaced by plan:** `docs/superpowers/plans/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams.md`

# Phase 10: Slice Normalization & Public Seam Hardening

**Status:** SUPERSEDED (historical archive)
**Date:** 2026-05-11
**Goal:** Finish the post-Phase-9 architecture cleanup by normalizing the highest-debt feature slices and tightening feature public seams so Culcul becomes easier to read, easier to change, and less likely to leak implementation details across modules.

## Why a New Phase

Phase 9 changed the repo-wide truth successfully enough that it should no longer be the active planning baseline:

- `flutter test test/architecture/phase9_* --reporter compact` is green
- `lib/core/**` no longer imports `features/**`
- direct cross-feature `presentation/**` imports are gone
- shared feed cards, comment UI, emoji text, and user-tag style reuse now have explicit shared homes
- runtime ownership, DTO leakage, and protobuf leakage all have checked-in architecture guards

What remains is not another repo-wide rebaseline. The remaining debt is localized and structural:

- `notification` is still difficult to follow because the main workflow is hidden behind a large data collaborator cluster and a thin facade
- `dynamic` still mixes domain contracts with upload / parsing / article conversion concerns
- `video` still concentrates too much presentation and view-model logic under one giant feature surface
- `home` still acts as a composition hub with implementation-shaped dependencies
- feature public seams are legal but still too wide, because some barrels and `feature_scope.dart` files expose presentation or raw data-provider details

Phase 10 exists to attack those localized hotspots without reopening the repo-wide boundary question that Phase 9 already settled.

---

## Current Structural Problems

### P0: `notification` still behaves like a hidden god slice

The worst remaining maintainability hotspot is `lib/features/notification/`.

Observed problems:

- `application/` exists but is still too thin relative to the amount of real workflow logic in the feature
- the main repository implementation is spread across many `notification_repository_impl.*.dart` files, which reduces file size but not responsibility count
- `feature_scope.dart` is still closer to a provider passthrough than a deliberate external facade
- the feature has multiple responsibilities mixed together: feed sync, unread/session lifecycle sync, private chat send flow, local read state, and image upload support

The result is a slice that is technically split, but still hard to read because the operational model is not obvious from the directory layout.

### P1: `dynamic` mixes domain, parsing, and upload concerns

`lib/features/dynamic/` is large enough that “feature-level organization” is no longer a useful description.

Observed problems:

- `domain/` contains parser / tokenizer / mapper style files that read more like support infrastructure than business-domain contracts
- domain-facing repository seams still reflect upload mechanics too directly
- article parsing, feed reading, comment-target derivation, and publish/upload concerns live too close together
- the feature API is still broader than it needs to be for external consumers

The result is a feature that looks layered on paper but still asks readers to understand too many unrelated concerns at once.

### P2: `video` presentation is too concentrated

`lib/features/video/presentation/` is no longer a single coherent presentation slice. It is several sub-features sharing one roof:

- detail page orchestration
- player state and controls
- comments and reply flows
- overlays / danmaku / interaction layers
- settings and secondary action sheets

The repo no longer has the Phase 9 boundary problem of cross-feature presentation reuse, but `video` still has a local readability problem because the presentation surface is too dense and too central.

### P3: `home` and feature seams are still implementation-shaped

Phase 9 got the repo onto legal seams. It did not finish making those seams clean.

Observed problems:

- `home` is still a composition feature wired directly to several external feature surfaces
- some feature barrels still export presentation-heavy symbols rather than intentionally small external contracts
- some `feature_scope.dart` files still expose raw repository providers or low-level provider details

The result is improved legality but weak encapsulation: external consumers can depend on the right feature, but still learn too much about that feature's internal structure.

### P4: guard coverage is still narrower than the new debt shape

Phase 9 guard tests check the most important boundary failures, but they do not yet protect the next class of regressions:

- a barrel re-exporting `presentation/**` can still be technically legal while remaining too implementation-shaped
- a `feature_scope.dart` can still leak raw data providers instead of a deliberate facade
- a slice can remain internally hard to read even after passing repo-wide boundary rules

That means the docs and tests need one more turn: not to reopen broad architecture purity, but to encode the narrower public-seam expectations that now matter most.

---

## Target Architecture

### 1. Normalize hot slices by capability, not by file-count reduction alone

The goal is not “make fewer files.” The goal is “make the operational model obvious.”

Target direction:

- `notification` should read like a feature with explicit application workflows, stable facades, and infrastructure helpers behind them
- `dynamic` should separate feed/read models, publish/upload workflows, and article parsing support
- `video` should expose clearer presentation subdomains such as `detail/`, `player/`, `comments/`, and `overlays/`

If a split only creates more `part` files or more `*_helpers.dart` files without clarifying responsibility, it does not count as progress.

### 2. Treat `feature_scope.dart` as a facade, not a provider dump

`feature_scope.dart` should be the runtime/composition seam for other modules.

Rules:

- it may expose small facade providers or capability providers
- it should not expose raw `data/` repository providers as the main external contract
- it should not teach external consumers how the feature is internally assembled

The seam must tell outside readers what the feature offers, not how the feature is implemented.

### 3. Treat `<feature>.dart` as a deliberate public API

Feature barrels are now allowed seams. Phase 10 makes them intentional seams.

Rules:

- avoid exporting `presentation/**` broadly just because those files are convenient
- prefer exporting route entrypoints, facade types, public widgets that are truly intended for reuse, and small capability contracts
- keep data-layer implementation details and incidental view-model helpers out of the public barrel unless they are truly part of the contract

### 4. Keep `home` as a composition feature with thinner contracts

`home` is allowed to compose other features. The issue is not that it composes; the issue is how directly it composes implementation details.

Target direction:

- `home` depends on small public contracts from `search`, `live`, `video`, and `auth`
- navigation flows route through route seams or facade-level actions
- `home` remains a composition surface, not an unofficial app/runtime layer

### 5. Expand architecture guards to match the narrower Phase 10 contract

Phase 10 should add protection for:

- barrels that leak `presentation/**` as default public API
- `feature_scope.dart` files that expose raw data providers instead of feature-owned facades
- targeted slice rules for `notification`, `dynamic`, and `video` where the repo has already identified stable boundaries

These guards should stay focused and cheap to understand. They are there to protect the new public-seam rules, not to create abstract purity theater.

---

## Success Criteria

1. `notification` exposes a clear application/service facade and no longer reads like one repository cluster hidden behind thin wrappers.
2. `dynamic` no longer mixes domain-facing contracts with upload / parsing support in the same unclear layer boundaries.
3. `video/presentation/` is decomposed into clearer subdomains, so readers can navigate by responsibility rather than by filename memory.
4. `home` consumes narrower public contracts instead of implementation-shaped exports.
5. Feature barrels and `feature_scope.dart` surfaces are intentionally small and no longer default to exporting presentation or raw data-provider details.
6. New architecture guards exist for barrel leakage / facade leakage where the repo now depends on those rules.
7. Before this spec was superseded, the intended baseline convergence target was that `CLAUDE.md`, `docs/architecture/architecture-guide.md`, and the active spec/plan would all point to the same Phase 10 baseline.
8. Phase 9 is archived as substantially complete, with the remaining localized debt explicitly carried into Phase 10.

---

## Non-Goals

- Reopening the Phase 9 repo-wide boundary rebaseline
- Another large move of shared UI back and forth across `ui/` and features
- Rewriting every feature for symmetry
- A wholesale UI redesign
- Generated-file churn beyond normal codegen needs
- Solving unrelated product behavior bugs unless they block the architecture slice being cleaned up

---

## Migration Strategy

1. Archive Phase 9 honestly: broad boundary work is substantially complete, remaining localized debt moved forward.
2. Harden documentation and guard expectations first so implementation is measured against the right contract.
3. Normalize `notification` first because it is the least readable high-churn slice.
4. Normalize `dynamic` second because its domain/upload/parser mixing is the next largest structural risk.
5. Decompose `video` presentation third, after the seam expectations are clearer.
6. Tighten `home` and the remaining feature public seams after the hot slices expose cleaner contracts.
7. Refresh the architecture guide again after implementation so it describes the real post-Phase-10 structure rather than the transition intent.
