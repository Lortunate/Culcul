# Phase 8: Architecture Rebaseline & Boundary Cleanup

**Status:** COMPLETED
**Date:** 2026-05-08
**Goal:** Rebaseline the architecture docs after early Phase 8 landings, remove the remaining `core -> features` leaks, and collapse direct cross-feature presentation coupling so the codebase becomes easier to read and safer to evolve.

## Context

The first 2026-05-08 Phase 8 draft is already stale relative to the code. Several items from that draft have already landed:

- `core/session/` is already consolidated into 5 files
- `app/router/routes/` is already renamed to `app_content_routes.dart`, `app_social_routes.dart`, and `app_notification_routes.dart`
- `app/bootstrap/provider_overrides.dart` is already slimmed down to bootstrap wiring plus feature-scope overrides

The active documentation still describes those items as pending, so the repo currently has **documentation drift** as well as **architecture drift**.

Fresh audit snapshot:

- `lib/core/session/relation_providers.dart` imports `features/profile/domain/...`
- `lib/core/session/search_providers.dart` imports `features/search/domain/...`
- 30 direct cross-feature imports remain in `lib/features/**`
- 26 of those 30 imports are presentation-widget reuse
- 22 of those 30 imports target `features/video/**`
- `lib/app/app.dart` still imports `features/settings/presentation/view_models/settings_view_model.dart`
- `features/notification/` has no `application/` directory, but still contains command workflow code in `presentation/`
- `features/dynamic/domain/repositories/dynamic_repository.dart` imports `dart:io` and exposes `File` in a domain contract
- `docs/architecture/architecture-guide.md` still claims notification is FULL and that only 6 cross-feature imports remain

## Design Decisions

### 1. Docs must describe current truth, not intended truth

The active guide/spec/plan set must match the repository as it exists today. Historical intent belongs in `archive/`, not in the live architecture surface.

### 2. `core/` owns cross-feature contracts

If a provider in `core/session/` is meant to be consumed across features, its public contract cannot live under `features/**`. `core/` may depend on shared contracts, but never on a feature-owned repository interface.

### 3. Reused presentation primitives move to `ui/`

If a widget is imported by multiple features and contains no feature-specific workflow, it belongs in `ui/widgets/**`, not in one feature's `presentation/widgets/**`.

### 4. File-system types stop before the domain boundary

`dart:io` types such as `File` may exist in presentation or data implementation code, but not in domain repository interfaces. Domain contracts should expose app-level value objects or upload payload abstractions.

### 5. Feature workflows live in `application/`

Command orchestration such as chat send flows, post-send hooks, branching, and state cleanup should live in `application/`, not in `presentation/`.

### 6. `app/` may depend on features, but only through public seams

`app/` is allowed to compose features, but it should not reach into `features/**/presentation/**` internals for app-global behavior. Those dependencies should flow through a public feature seam or a core-owned contract.

## Problem Analysis

### P0: Documentation Drift

Current live docs overstate the cleanliness of the codebase:

- live Phase 8 docs list already-landed refactors as pending
- the architecture guide still marks `notification` as FULL even though it lacks `application/`
- the Phase 7 section points to root spec/plan paths even though those files are already archived

This makes the repo harder to navigate because the reader cannot trust the active documents.

### P1: Core Dependency Direction Violations

`core/` currently imports feature-owned interfaces:

- `lib/core/session/relation_providers.dart` -> `features/profile/domain/repositories/relation_repository.dart`
- `lib/core/session/search_providers.dart` -> `features/search/domain/repositories/search_repository.dart`

This breaks the main architecture rule:

```text
core/ must not import from features/
```

These contracts need to move to `core/contracts/` or another core-owned seam, with feature implementations wired in via bootstrap overrides.

### P2: Cross-Feature Presentation Coupling

The remaining cross-feature imports are not edge cases. They are mostly direct presentation reuse:

- 22 imports target `features/video/**`
- 26 imports are widget-level imports
- the remaining 4 imports are view-model/page seams that still bypass a proper shared or router-facing abstraction

The biggest current clusters are:

- list cards / skeletons / thumbnails imported from `video`
- comment widgets imported from `video`
- emoji and user-tag widgets imported from `dynamic` and `profile`
- search/profile/home widgets directly importing other features' pages or view models

The same boundary weakness also shows up at the app layer:

- `lib/app/app.dart` imports `features/settings/presentation/view_models/settings_view_model.dart`

That import is not cross-feature, but it is still an app-to-feature-internal dependency that weakens the public-surface rule.

This is the biggest readability and maintenance problem still visible in the tree.

### P3: Workflow and Platform Boundary Leaks

Two concrete leaks remain:

1. `features/dynamic/domain/repositories/dynamic_repository.dart` imports `dart:io` and exposes `List<File>` in a domain-facing upload API
2. `features/notification/presentation/chat_page_commands.dart` contains command workflow logic that should live under `application/`

These leaks make feature boundaries harder to reason about and spread platform-specific details into higher-level code.

### P4: Notification Slice Still Incomplete

`features/notification/` is the only feature that still fails the documented structure shape:

- no `application/` directory
- command workflow still under `presentation/`
- parser/helper naming under `presentation/widgets/` is muddy

Notification does not need a full redesign, but it does need a clean application seam and clearer placement rules.

## Success Criteria

1. Active `spec`, `plan`, and `architecture-guide` describe the same current-state snapshot.
2. `core/` has zero imports from `features/**`.
3. `app/**` imports feature public seams only, not `features/**/presentation/**` internals.
4. Direct cross-feature imports of `presentation/widgets/**`, `presentation/pages/**`, and `presentation/view_models/**` are eliminated or reduced to a short documented exception list.
5. Shared presentation primitives reused across features live under `ui/widgets/**`.
6. `features/notification/` has an explicit `application/` layer for chat command workflow.
7. `features/dynamic/domain/**` has zero `dart:io` imports and no domain repository method takes `File`.
8. Architecture guard tests fail on new `core -> features` imports and new cross-feature presentation imports.
9. `flutter analyze` and architecture-focused tests pass after the refactor.

## Non-Goals

- Replacing Riverpod with another state-management approach
- Preserving old import paths for compatibility shims
- Refactoring generated files (`.g.dart`, `.freezed.dart`)
- Redesigning feature behavior or product scope
- Reworking every large file in `video/`, `dynamic/`, or `notification/` in one pass unless it directly serves the boundary cleanup
