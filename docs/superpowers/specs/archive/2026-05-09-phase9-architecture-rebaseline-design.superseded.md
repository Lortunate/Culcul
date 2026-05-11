# Phase 9: Architecture Rebaseline & Ownership Realignment

> **Archived on 2026-05-11 as substantially complete:** This archive is preserved as historical transition context. Treat Phase 9 as the repo-wide boundary rebaseline that largely landed. For the current active baseline, use `docs/superpowers/specs/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams-design.md` and `docs/superpowers/plans/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams.md`. Phase 10 remains archived as the partial-landing bridge between those two phases.

**Status:** SUPERSEDED
**Historical bridge archive:** `docs/superpowers/specs/archive/2026-05-11-phase10-slice-normalization-and-public-seam-hardening-design.superseded.md`
**Current active spec:** `docs/superpowers/specs/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams-design.md`
**Current active plan:** `docs/superpowers/plans/2026-05-11-phase11-architecture-truth-reconciliation-and-semantic-seams.md`
**Date:** 2026-05-09
**Goal:** Rebuild Culcul's app/runtime ownership, shared presentation surface, and feature public seams so the current codebase becomes easier to read, safer to refactor, and less dependent on hidden cross-feature internals.

## Archive Note

Phase 9 is archived as substantially complete rather than literally complete. The repo-wide boundary goals that justified the rebaseline are now enforced in code and architecture tests:

- `core/**` no longer imports `features/**`
- cross-feature `presentation/**` imports are removed
- shared feed cards / comment / text / user compositions have explicit shared homes
- runtime ownership and DTO / protobuf leak guards are checked in `test/architecture/phase9_*`

What remained after verification was no longer broad boundary repair. The remaining debt had narrowed to slice-local readability and public-seam hardening work in `notification`, `dynamic`, `video`, and `home`, so that follow-up work moved into the narrower active Phase 10 baseline.

## Why a New Phase

The previous active Phase 8 documents are no longer an accurate planning baseline. They were archived as superseded on 2026-05-09 because current code already includes several Phase 8 moves:

- `core/session/` is already consolidated into grouped files
- route part files are already renamed to `app_content_routes.dart`, `app_social_routes.dart`, and `app_notification_routes.dart`
- `provider_overrides.dart` is already thin
- `ProviderScope` override wiring is already rooted in `main.dart`
- many video widgets already moved out of `ui/`

What remains is a different class of debt: ownership drift. Several areas now compile cleanly but still encode the wrong boundaries, making future changes expensive and surprising.

---

## Current Structural Problems

### P0: Runtime and Port Ownership Drift

`core/session/` still imports feature-owned repository interfaces:

- `lib/core/session/relation_providers.dart` imports profile repository types
- `lib/core/session/search_providers.dart` imports search repository types

This contradicts the documented rule that `core/` must not depend on `features/`.

Boot/runtime ownership is also fragmented:

- `main.dart` owns root composition and special-cases auth refresh wiring
- `app/bootstrap/provider_overrides.dart` owns storage/bootstrap overrides
- multiple `feature_scope.dart` files own cross-feature runtime ports
- several bootstrap/session providers remain `UnimplementedError` stubs
- `AppBootstrap.initialize()` returns raw `Box<dynamic>` storage dependencies
- `core/session/session_lifecycle_providers.dart` still exposes UI-facing actions such as login-dialog presentation

The result is a runtime graph that only works if many files stay in sync by convention.

### P1: Shared Presentation Is Trapped Inside Features

The dominant cross-feature coupling is no longer domain logic. It is presentation reuse through other features' internal widgets and pages.

Observed current state:

- about 30 direct cross-feature imports under `lib/features/**`
- all of them target another feature's `presentation/**`
- 22 of the 30 imports target `video/presentation/**`, and 5 target `dynamic/presentation/**`
- `comment_item.dart` in `video` depends on `dynamic` emoji rendering and `profile` user tags

This means shared UI is real, but it has no legitimate shared home.

### P2: Feature Public Seams Are Too Weak

Several features are consumed through internal presentation files instead of explicit public APIs:

- `home/presentation/pages/home_page.dart` reads `defaultSearchProvider.future` from `search`
- `home/presentation/widgets/live_view.dart` watches `liveRecommendProvider` from `live`
- `search/presentation/widgets/items/search_topic_item.dart` constructs `TopicDetailPage` from `dynamic`
- `profile/presentation/widgets/user_dynamic_tab.dart` consumes `userDynamicProvider` and `DynamicPostCard` from `dynamic`
- several `feature_scope.dart` files still expose raw repository/data providers instead of deliberate facades

Today, `route_entry.dart` is not enough. Each feature also needs a stable runtime/composition seam for external consumers.

### P3: Notification Slice Still Breaks Layering

`notification` is the least maintainable feature:

- no real `application/` layer despite real workflow code
- chat workflow helpers live under `presentation/`
- `chat_page_commands.dart`, `chat_view_model.dart`, and `chat_input.dart` still use `dart:io`
- several domain entities import DTOs from `data/dtos`
- `feature_scope.dart` exports the concrete `notificationRepositoryProvider` instead of a feature-owned facade
- `notification_repository_impl*.dart` is a collaborator cluster without a clean public composition model

### P4: Data Boundary Leaks Still Exist

Boundary leakage is broader than one repository contract:

- `features/video/domain/repositories/danmaku_repository.dart` exposes protobuf response types directly
- `notification/domain/entities/**` aliases DTOs from `data/dtos/**`
- several `video`, `live`, and `dynamic` domain files still behave as DTO re-exports instead of feature-owned domain models
- `AppDependencies` exposes raw storage boxes rather than typed stores

These may be pragmatic today, but they make domain contracts and boot contracts harder to understand, test, and evolve.

---

## Target Architecture

### 1. Split Runtime Composition from Feature Implementation

Add an explicit runtime layer under `app/`:

```text
lib/app/
├── runtime/
│   ├── bootstrap_coordinator.dart
│   ├── app_runtime.dart
│   ├── root_overrides.dart
│   └── stores/
│       ├── session_store.dart
│       ├── settings_store.dart
│       └── search_history_store.dart
```

Rules:

- `main.dart` only starts the coordinator and mounts one root `ProviderScope`
- `app/runtime/root_overrides.dart` is the single manifest of root overrides
- feature scopes may provide helper lists, but root composition must stay centralized
- `AppRuntime` replaces loose raw bootstrap fields

### 2. Make `core/session` Feature-Neutral Again

Refactor current session/runtime ports so `core/` depends only on `core/**`.

Target direction:

```text
lib/core/
├── contracts/
│   ├── relation_port.dart
│   ├── search_port.dart
│   ├── watch_later_port.dart
│   └── session_refresh_port.dart
└── session/
    ├── user_providers.dart
    ├── relation_providers.dart
    ├── search_providers.dart
    └── session_lifecycle_providers.dart
```

Rules:

- `core/session/**` may not import from `features/**`
- UI-facing actions such as login-dialog presentation do not live in `core/session`
- runtime stubs should fail early during boot verification, not lazily during random request flow

### 3. Create a Legitimate Shared Presentation Surface

Do not pretend all shared widgets are generic primitives. Culcul has a second category: reusable product compositions.

Target direction:

```text
lib/ui/
├── theme/
├── responsive/
├── widgets/       # low-level reusable primitives
└── compositions/  # app-specific reusable presentation building blocks
    ├── auth/
    ├── comments/
    ├── feed_cards/
    ├── text/
    └── users/
```

Examples of candidates for `ui/compositions/`:

- video cards, list cards, thumbnails, and related skeletons
- shared comment item/sheet rendering
- Bilibili emoji text rendering
- reusable user tags/badges
- cross-feature guest/login-required empty states

This keeps feature folders focused on feature-owned screens, state, and workflows.

### 4. Strengthen Feature Public APIs

Every externally consumed feature should expose only explicit public seams:

- `route_entry.dart` for navigation
- `feature_scope.dart` for runtime/provider facades
- `<feature>.dart` barrel for approved public exports

Rules:

- no external imports into another feature's `presentation/**`
- no external imports into another feature's `data/**`
- composition features like `home` may consume shared `ui/compositions/**` plus approved feature facades only

### 5. Normalize Vertical Slices Before More Mechanical Cleanup

For features with architectural debt, normalize the slice before doing more file churn:

- `notification`: create a real `application/` layer and move DTO-to-domain mapping back into `data/`
- `home`: keep it as a composition feature, not a hidden second runtime layer
- `search` and `live`: expose narrow public facades instead of presentation providers
- `dynamic` and `video`: stop treating feature presentation folders as a shared component library

---

## Success Criteria

1. `core/**` has zero imports from `features/**`.
2. `lib/features/**` has zero cross-feature imports into another feature's `presentation/**`.
3. Runtime override ownership is declared in one root manifest.
4. `AppBootstrap` no longer returns raw `Box<dynamic>` dependencies directly to the app layer.
5. Shared cross-feature product UI lives under an explicit shared surface, not inside feature internals.
6. `notification` has a real `application/` layer and its domain entities no longer import DTOs.
7. Search/home/live/profile/dynamic consumers rely on explicit feature seams instead of internal pages/providers.
8. The Phase 8 archive docs are clearly marked `SUPERSEDED`, and the active architecture guide, `CLAUDE.md`, spec, and plan all point to the same Phase 9 baseline.
9. `video`, `live`, `dynamic`, and `notification` no longer expose DTO/protobuf types as their effective domain model.

---

## Non-Goals

- Replacing Riverpod with another state management system
- Rewriting all UI visuals
- Reorganizing every feature purely for symmetry
- Touching generated files except when required by normal codegen
- Solving unrelated performance work already covered by earlier phases

---

## Migration Strategy

1. Rebaseline docs first so implementation follows the real current repo, not stale phase8 assumptions.
2. Fix root ownership and shared surfaces before large feature-local cleanup.
3. Move shared presentation out of features before tightening cross-feature import rules.
4. Normalize `notification` after the shared-surface decision is in place.
5. Only then do the remaining domain-purity and barrel/public-API cleanup.
