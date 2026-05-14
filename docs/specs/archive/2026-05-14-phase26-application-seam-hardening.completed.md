# Phase 26 Application Seam Hardening Spec

## Status

Active on 2026-05-14.

Supersedes:

- `docs/specs/archive/2026-05-14-phase25-architecture-surface-reduction.completed.md`

## Context

Phase 25 reduced broad feature public surfaces, moved DTO-shaped domain types into data DTO folders, split source/generated guard counts, removed router-owned route-input aliases, and audited dependency ownership. It intentionally left a few cross-feature runtime seams because they were real composition points.

The remaining risk is not broad public surface count. It is seam shape:

- `profile/feature_scope.dart` still exports `profileCacheRepositoryProvider`, a data-layer provider, only so auth logout can clear profile cache.
- `search/feature_scope.dart` defines `searchDefaultHintProvider` directly instead of exporting a source-owned application seam.
- `video/feature_scope.dart` defines `VideoActionSheetCallback` and `showVideoActionsBottomSheet` directly instead of exporting a source-owned presentation seam.
- Architecture guards do not yet reject executable declarations inside `feature_scope.dart`.

Phase 26 hardens the remaining composition seams without changing user-facing behavior.

## Goals

1. Remove the last data-layer provider export from feature scopes.
2. Move executable `feature_scope.dart` declarations into owning source files.
3. Add architecture guard coverage so future `feature_scope.dart` files remain export-only composition seams.
4. Keep cross-feature composition imports explicit and narrow.
5. Preserve behavior for logout cache clearing, search default hints, home live/dynamic/search composition, and video action sheets.

## Non-Goals

- No UI redesign.
- No routing rewrite.
- No new state-management framework.
- No dependency changes unless compile requires it.
- No removal of real cross-feature runtime seams that still have proven consumers.

## Target Architecture

`feature_scope.dart` may expose only narrow runtime composition symbols needed outside the feature. It must not define new classes, typedefs, providers, or functions. It must not export `data/**` by default. If another feature needs data-layer work, the owning feature must provide an application-layer command or port.

Approved remaining seams after Phase 26 should be source-owned:

- Auth session providers from `auth/application`.
- Profile lookup/cache invalidation commands from `profile/application`.
- Dynamic profile-tab composition from `dynamic/presentation` until a product API is justified.
- Live recommendation provider from `live/presentation`.
- Search port/default hint from `search/application`.
- To-view watch-later port from `to_view/application`.
- Video action sheet entry from `video/presentation`.

## Success Criteria

- Auth logout no longer imports `profile/feature_scope.dart` or reads `profileCacheRepositoryProvider`.
- `profile/feature_scope.dart` no longer exports `profile/data/**`.
- `search/feature_scope.dart` has no direct provider alias declaration.
- `video/feature_scope.dart` has no typedef/function declaration.
- Architecture guards fail if a `feature_scope.dart` file declares executable symbols.
- Architecture guards, analyzer, code generation, and focused tests pass.

## Verification

- Run GitNexus impact analysis before editing any function, class, or method.
- Run:
  - `dart run build_runner build --delete-conflicting-outputs`
  - `bash tool/architecture/run_architecture_guards.sh`
  - `flutter analyze --no-fatal-infos --no-fatal-warnings`
  - focused auth/profile/search/video/home tests or analyzer slices for touched areas
  - `gitnexus_detect_changes(scope: "all")` before commit
