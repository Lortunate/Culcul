# Phase 11: Architecture Truth Reconciliation & Semantic Seam Convergence

**Status:** ACTIVE
**Date:** 2026-05-11
**Goal:** Re-establish one truthful architecture baseline for Culcul, then finish the semantic seam cleanup that Phase 10 only landed structurally so the repo becomes easier to read, easier to evolve, and harder to regress.

## Why a New Phase

Phase 10 did not fail. It landed meaningful structural work:

- `feature_scope.dart` facade entrypoints now exist across the repo
- `dynamic` already has `application/` and `data/article_parsing/`
- `video/presentation/` is already split into `detail/`, `player/`, `comments/`, and `overlays/`
- `flutter test test/architecture/phase10_* --reporter compact` is green

But Phase 10 also did not end with a truthful or semantically complete baseline:

- `CLAUDE.md` still treated Phase 10 as active while `docs/architecture/architecture-guide.md` described it as already archived and completed
- `dynamic.dart` and `video.dart` still selectively re-export `presentation/**` symbols
- `home` still routes presentation straight to `data/home_feed_data_source.dart`
- `notification` has a facade, but it still exposes a public repository field and a large repository-shaped method surface
- the current Phase 10 guards are too syntactic to prove that public seams are actually deliberate and minimal

The active problem has therefore changed shape. Culcul no longer needs another broad legality phase. It needs a truth-reconciliation and semantic-convergence phase.

---

## Current Structural Problems

### P0: source-of-truth drift

Architecture truth currently lives in too many places with conflicting claims:

- `CLAUDE.md`
- `docs/architecture/architecture-guide.md`
- the active root spec/plan pair
- the actual checked-in guard tests and feature seams

This is more than documentation polish. When these sources disagree, every later refactor inherits the wrong constraints.

### P1: seam shape is ahead of seam semantics

Many features now have the right files:

- `<feature>.dart`
- `feature_scope.dart`
- `route_entry.dart`
- `application/`

But those files do not yet mean the same thing everywhere.

Observed drift:

- some facades are real capability seams
- some facades are placeholders
- some facades still forward repository methods nearly 1:1
- some feature barrels still export presentation internals selectively with `show`

The repo now has shape consistency without semantic consistency.

### P2: `home` is still composition-through-data, not composition-through-capability

`home` is the clearest example of incomplete Phase 10 convergence.

Observed problems:

- `home/application/home_facade.dart` is effectively a holder with no real capability contract
- presentation view models still import `data/home_feed_data_source.dart`
- the external seam exists, but the active code path bypasses it

That means `home` still behaves like a partially normalized feature rather than a fully converged composition surface.

### P3: `notification` still exposes a repository-shaped public seam

`notification` is structurally closer to the target than `home`, but the seam still teaches outside readers too much about internal assembly.

Observed problems:

- `NotificationFacade` exposes a public `repository`
- many public methods are repository-shaped pass-throughs rather than capability-shaped operations
- application wiring still imports `data/notification_repository_impl.dart` directly to obtain providers

The feature is technically behind a facade, but the facade is not yet a stable, minimal contract.

### P4: `dynamic` and `video` are only partially converged

Both features already have better directory shapes than they had before Phase 10, but the public API cleanup stopped early.

Observed problems:

- `dynamic.dart` still exports `presentation/view_models/user_dynamic_view_model.dart`
- `dynamic.dart` still exports `presentation/widgets/dynamic_post_card.dart`
- `video.dart` still exports `presentation/overlays/video_actions_bottom_sheet.dart`
- `DynamicFacade` and `VideoFacade` are still mostly repository holders rather than capability contracts
- some application/presentation files still reference repository providers that `feature_scope.dart` no longer exports, which means the seam story and the actual call sites have drifted apart
- domain/data ownership is still muddy in both features because DTO-shaped response models still live under `domain/entities/**` while `data/dtos/**` sometimes only re-export the same types back
- current tests do not catch these selective `show` exports because they only look for the coarsest export forms

The repo is close enough that the next phase should not reopen the whole structure. It should finish the semantic cleanup.

### P5: guard coverage is still too weak for the new failure mode

Phase 9 and Phase 10 guards proved the repo is no longer wildly violating boundaries. They do not yet prove that the public APIs are intentional.

New failure modes that need first-class protection:

- a feature barrel selectively re-exporting `presentation/**`
- a facade exposing repositories or data-implementation details
- presentation reaching into data after a facade exists
- application/provider wiring reaching into `data/*_impl.dart` when a domain/provider port should exist instead

---

## Target Architecture

### 1. Keep the top-level shape stable

The repo does not need new top-level buckets. The stable shape remains:

- `app/`
- `core/`
- `features/`
- `ui/`

Phase 11 is about making those buckets truthful and predictable, not inventing a new layout.

### 2. Treat feature root seams as contracts with strict semantics

Root files should mean the same thing in every feature:

- `route_entry.dart`: router-only adapter
- `feature_scope.dart`: runtime/composition capability seam
- `<feature>.dart`: deliberate public API only

Rules:

- `<feature>.dart` must not export from `presentation/**` or `data/**`, even selectively with `show`/`hide`
- if a widget truly needs cross-feature reuse, promote it to `ui/compositions/**` or another explicitly shared public surface
- `feature_scope.dart` may re-export facade providers, capability providers, or feature-owned public contracts, but not repositories

### 3. Make facades capability-oriented

Facades are not shape markers. They are the feature's public operational contract.

Rules:

- no public repository fields on facades
- prefer capability methods such as `refreshUnreadAndFeed`, `openPrivateChat`, `loadHomeFeed`, `openVideoActions`, `publishDynamic`
- avoid 1:1 repository forwarding unless the repository interface is itself the intended public contract
- if a feature needs multiple outward capabilities, split them into small explicit facades rather than one giant wrapper

### 4. Use capability subtrees instead of helper shards

When a feature is large, split by capability that a human can name, not by implementation fragments.

Preferred examples:

- `notification/application/chat/`, `notification/application/feed/`
- `home/presentation/recommend/`, `home/presentation/popular/`, `home/presentation/live/`, `home/presentation/weekly/`
- `dynamic/presentation/feed/`, `dynamic/presentation/detail/`, `dynamic/presentation/publish/`
- `video/presentation/detail/`, `video/presentation/player/`, `video/presentation/comments/`, `video/presentation/overlays/`

Anti-pattern:

- proliferating `*.helpers.dart`, `*.types.dart`, or `repository_impl.*.dart` files without clarifying the operational model

### 5. Keep application wiring off concrete implementation paths

Phase 11 should reduce imports from application/public seam files into `data/*_impl.dart`.

Target direction:

- provider composition still happens in the feature
- but public seam files depend on provider ports, domain repositories, or dedicated composition providers
- implementation details stay in `data/` or internal composition files

### 6. Use tests to encode semantic expectations

Architecture tests must protect meaning, not only syntax.

Examples:

- scan all feature barrels for any export path containing `/presentation/` or `/data/`
- scan facade files for public repository fields
- scan presentation view models for direct imports of local `data/` when a facade exists
- scan application seam files for direct imports of `*_repository_impl.dart`

---

## Success Criteria

1. `CLAUDE.md`, `docs/architecture/architecture-guide.md`, and the active spec/plan all point to the same Phase 11 baseline.
2. The former Phase 10 root spec/plan are archived as `superseded`, with an honest note about partial landing and why the repo moved on.
3. No feature barrel exports any file under `presentation/**` or `data/**`, including selective `show` / `hide` exports.
4. `home` no longer lets presentation depend directly on `data/home_feed_data_source.dart`; outward usage flows through a real home capability seam.
5. `notification` no longer exposes a public repository field and no longer behaves like a repository-shaped pass-through facade.
6. `dynamic` and `video` keep their Phase 10 structural gains, but their public APIs stop leaking presentation internals and their facade/provider seams analyze cleanly.
7. DTO/data-model ownership is clarified enough that domain-facing contracts no longer read like mirrored transport models.
8. Architecture guards exist for semantic public-API leaks, facade leaks, and direct presentation-to-data shortcuts where a feature seam should exist.
9. The architecture guide documents the stable meaning of `route_entry.dart`, `feature_scope.dart`, and `<feature>.dart` without overstating what the code has not yet earned.

---

## Non-Goals

- Another repo-wide boundary rebaseline
- Reintroducing `lib/shared/`
- Reorganizing `app/`, `core/`, `features/`, and `ui/` into new top-level buckets
- Broad generated-file churn
- Rewriting every feature for symmetry
- UI redesign work unrelated to architecture seams

---

## Migration Strategy

1. Archive Phase 10 honestly as superseded-after-partial-landing.
2. Establish one truthful active baseline in `CLAUDE.md`, `architecture-guide.md`, and the new Phase 11 spec/plan.
3. Tighten architecture guards so they catch semantic seam leaks, not only coarse string matches.
4. Convert `home` and `notification` into real capability facades because they are the clearest seam-quality gaps.
5. Finish the public-API cleanup for `dynamic` and `video` without throwing away their existing directory normalization.
6. Sweep remaining feature barrels, `feature_scope.dart` files, and application seam imports so the rules are repo-wide, not four-feature exceptions.
7. Refresh the architecture guide after implementation so it describes verified truth rather than aspirational prose.
