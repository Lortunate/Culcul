# Phase 26 Application Seam Hardening Plan

Spec: `docs/specs/phase26-application-seam-hardening.md`

## Ground Rules

- Execute one task at a time.
- Run GitNexus impact analysis before editing functions, classes, methods, or provider symbols.
- Keep changes behavior-preserving.
- Prefer application-layer commands/ports over exporting data repositories.
- Do not add compatibility shims for old imports.

## Phase Map

- Task 1: Planning rollover and archive hygiene.
- Task 2: Profile cache invalidation application seam.
- Task 3: Search default hint source-owned seam.
- Task 4: Video action sheet source-owned seam.
- Task 5: Feature scope declaration guard.
- Task 6: Final verification and commit split.

## Task 1: Planning Rollover And Archive Hygiene

- [x] Archive Phase 25 active spec as completed.
- [x] Archive Phase 25 active plan as completed.
- [x] Create active Phase 26 spec.
- [x] Create active Phase 26 plan.
- [x] Update `CLAUDE.md` active pointers.
- [x] Update `docs/architecture/architecture-guide.md` active phase and seam rules.
- [x] Verify no stale Phase 25 active references remain outside archive history.

Verification:

- `git status --short`
- grep active docs for stale Phase 25 active pointers outside archive files

## Task 2: Profile Cache Invalidation Application Seam

Files:

- Create: `lib/features/profile/application/profile_cache_commands.dart`
- Modify: `lib/features/profile/feature_scope.dart`
- Modify: `lib/features/auth/presentation/view_models/auth_view_model.dart`

- [ ] Impact analysis targets before editing:
  - `profileCacheRepositoryProvider`
  - `Auth.logout`
  - `profile/feature_scope.dart`
- [x] Add a profile-owned application command provider for full profile-cache invalidation.
- [x] Update auth logout to use the application command instead of the profile data repository provider.
- [x] Remove `profileCacheRepositoryProvider` from `profile/feature_scope.dart`.
- [x] Run code generation if a generated provider is added.

Task 2 result:

- Added `clearProfileCacheProvider` in `profile/application/profile_cache_commands.dart`.
- Auth logout now calls the profile-owned application command instead of reading the profile data repository provider.
- `profile/feature_scope.dart` exports only profile application seams.

Verification:

- focused auth/profile tests or analyzer slice
- `dart run build_runner build --delete-conflicting-outputs`
- `bash tool/architecture/run_architecture_guards.sh`

## Task 3: Search Default Hint Source-Owned Seam

Files:

- Create: `lib/features/search/application/search_default_hint_provider.dart`
- Modify: `lib/features/search/feature_scope.dart`

- [ ] Impact analysis targets before editing:
  - `searchDefaultHintProvider`
  - `search/feature_scope.dart`
- [x] Move the provider alias out of `feature_scope.dart` and into search application code.
- [x] Keep `feature_scope.dart` as export-only composition seam.

Task 3 result:

- Added `search/application/search_default_hint_provider.dart`.
- `search/feature_scope.dart` now only exports search application seams.

Verification:

- analyzer slice for search/home/dynamic consumers
- architecture guard after Task 5

## Task 4: Video Action Sheet Source-Owned Seam

Files:

- Create: `lib/features/video/presentation/overlays/video_action_sheet_entry.dart`
- Modify: `lib/features/video/feature_scope.dart`

- [ ] Impact analysis targets before editing:
  - `showVideoActionsBottomSheet`
  - `video/feature_scope.dart`
- [x] Move `VideoActionSheetCallback` and `showVideoActionsBottomSheet` into the owning video presentation source file.
- [x] Keep `feature_scope.dart` as export-only composition seam.

Task 4 result:

- Added `video/presentation/overlays/video_action_sheet_entry.dart`.
- `video/feature_scope.dart` now only exports the video action-sheet entry symbol.

Verification:

- analyzer slice for video/home consumers
- focused video/home tests where available

## Task 5: Feature Scope Declaration Guard

Files:

- Modify: `test/architecture/architecture_boundary_guard_test.dart`
- Modify: `test/architecture/architecture_guard_utils.dart` if helper support is needed
- Modify: `tool/architecture/run_architecture_guards.sh` only if output needs adjustment

- [ ] Impact analysis target before editing architecture guard files.
- [x] Add a guard that fails when `feature_scope.dart` declares classes, enums, typedefs, providers, functions, or top-level variables.
- [x] Allow imports and exports only, with existing approved non-`feature_scope.dart` barrels unchanged.
- [x] Ensure the guard catches `data/**` exports from feature scopes unless explicitly justified in the plan.

Task 5 result:

- Added an architecture guard that keeps `feature_scope.dart` files import/export-only.
- The guard also rejects feature-scope imports/exports that resolve to feature `data/**` paths.

Verification:

- `flutter test test/architecture/architecture_boundary_guard_test.dart --reporter compact`
- `bash tool/architecture/run_architecture_guards.sh`

## Task 6: Final Verification And Commit Split

- [x] Run:
  - `dart run build_runner build --delete-conflicting-outputs`
  - `bash tool/architecture/run_architecture_guards.sh`
  - `flutter analyze --no-fatal-infos --no-fatal-warnings`
  - focused tests from each task
- [x] Run `gitnexus_detect_changes(scope: "all")`.
- [x] Split commits by coherent boundary:
  - docs/planning
  - application seam cleanup
  - architecture guard
- [x] Leave unrelated user changes unstaged.

Task 6 verification result:

- `dart run build_runner build --delete-conflicting-outputs`: passed.
- `bash tool/architecture/run_architecture_guards.sh`: passed with source/generated/total counts `646/228/874`.
- `flutter analyze --no-fatal-infos --no-fatal-warnings`: exit 0 with existing info-only lint noise.
- Focused architecture/profile/video tests: passed.
- `gitnexus_detect_changes(scope: "all")`: low risk, 0 affected processes.

## Self-Review Checklist

- [x] No stale active Phase 25 pointers outside archive history.
- [x] No data-layer provider exported through `feature_scope.dart`.
- [x] No executable declarations inside `feature_scope.dart`.
- [x] Tests/guards run and results recorded.
