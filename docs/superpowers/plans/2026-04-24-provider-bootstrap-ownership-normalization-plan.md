# Provider And Bootstrap Ownership Normalization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

## Goal

Finish the next focused architecture slice after phase-3 normalization:

- move bootstrap-supplied provider declarations out of `lib/shared/providers/**` and into explicit `lib/core/bootstrap/providers/**` homes
- delete the already-dead `shared` session compatibility shims
- tighten docs and architecture tests so the retired `shared` provider paths do not come back

## Architecture

The current codebase already proves the earlier `shared -> core/ui` pilots work:

- `sessionRefreshActionProvider` and `SessionCookieRefresher` already live under `lib/core/session/**`
- `responsive` and `result/error` legacy imports are blocked in production by phase-3 architecture tests
- `AppBootstrap` already centralizes runtime dependency construction

The remaining issue is ownership drift:

1. bootstrap-owned provider contracts still live in `lib/shared/providers/**`
2. `main.dart` still imports those `shared` providers for startup overrides
3. dead `shared` session shims still exist even though import scans show zero usage

## Tech Stack

Flutter, Dart 3.10, hooks_riverpod / flutter_riverpod, riverpod_annotation, build_runner, flutter_test

---

## File Structure Map

### Plan and architecture docs

- Modify: `docs/architecture/shared-boundary-rules.md`
- Modify: `docs/architecture/phase3-structural-normalization-rules.md`
- Modify: `test/architecture/phase3_legacy_import_paths_test.dart`
- Create: `test/architecture/provider_bootstrap_ownership_guard_test.dart`

### Bootstrap/provider ownership targets

- Modify: `lib/app/bootstrap/app_bootstrap.dart`
- Modify: `lib/main.dart`
- Create: `lib/core/bootstrap/providers/cache_store_provider.dart`
- Create: `lib/core/bootstrap/providers/cookie_jar_provider.dart`
- Create: `lib/core/bootstrap/providers/storage_box_providers.dart`
- Delete or convert after migration:
  - `lib/shared/providers/cache_store_provider.dart`
  - `lib/shared/providers/cookie_jar_provider.dart`
  - `lib/shared/providers/storage_provider.dart`

### Consumers expected to migrate

- Modify: `lib/shared/network/dio_client.dart`
- Modify: `lib/shared/network/interceptors/csrf_interceptor.dart`
- Modify: `lib/features/dynamic/data/dynamic_repository_impl.dart`
- Modify: `lib/features/home/presentation/view_models/home_feed_paging_mixin.dart`
- Modify: `lib/features/profile/presentation/view_models/user_space_videos_view_model.dart`
- Modify: `lib/features/search/presentation/view_models/search_view_model.dart`
- Modify: `lib/features/search/presentation/view_models/search_history_view_model.dart`
- Modify: `lib/features/auth/data/auth_repository_impl.dart`
- Modify: `lib/features/settings/data/settings_repository_impl.dart`
- Modify: `lib/features/settings/feature_scope.dart`
- Modify matching tests under `test/features/**`

### Dead compatibility shims to remove

- Delete: `lib/shared/providers/session_refresh_provider.dart`
- Delete: `lib/shared/session/session_cookie_refresher.dart`

---

## Implementation Tasks

### Task 0: Prepare the worktree and baseline

- [ ] Use the existing ignored `.worktrees/` directory. Verify with `git check-ignore -v .worktrees`.
- [ ] Create a dedicated worktree and branch, for example:
  `git worktree add .worktrees/provider-bootstrap-ownership -b refactor/provider-bootstrap-ownership`
- [ ] In the worktree, run:
  `flutter pub get`
- [ ] Regenerate generated files before edits:
  `dart run build_runner build --delete-conflicting-outputs`
- [ ] Record the starting state with:
  - `rg -n "package:culcul/shared/providers/(cache_store_provider|cookie_jar_provider|storage_provider).dart|package:culcul/shared/session/session_cookie_refresher.dart|package:culcul/shared/providers/session_refresh_provider.dart" lib test`
  - `flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact`
  - `flutter analyze`

### Task 1: Introduce stable `core/bootstrap` provider homes

- [ ] Add `lib/core/bootstrap/providers/cache_store_provider.dart`.
- [ ] Add `lib/core/bootstrap/providers/cookie_jar_provider.dart`.
- [ ] Add `lib/core/bootstrap/providers/storage_box_providers.dart`.
- [ ] Move provider declarations and `StorageKeys` ownership out of `lib/shared/providers/**` into those new files without redesigning the provider APIs unless a rename is necessary for clarity.
- [ ] Regenerate codegen after the move:
  `dart run build_runner build --delete-conflicting-outputs`

### Task 2: Migrate production and test imports to the new provider homes

- [ ] Update `lib/main.dart` to import the new `core/bootstrap` provider files.
- [ ] Update runtime infra consumers:
  - `lib/shared/network/dio_client.dart`
  - `lib/shared/network/interceptors/csrf_interceptor.dart`
  - `lib/features/dynamic/data/dynamic_repository_impl.dart`
- [ ] Update feature and repository consumers:
  - `lib/features/home/presentation/view_models/home_feed_paging_mixin.dart`
  - `lib/features/profile/presentation/view_models/user_space_videos_view_model.dart`
  - `lib/features/search/presentation/view_models/search_view_model.dart`
  - `lib/features/search/presentation/view_models/search_history_view_model.dart`
  - `lib/features/auth/data/auth_repository_impl.dart`
  - `lib/features/settings/data/settings_repository_impl.dart`
  - `lib/features/settings/feature_scope.dart`
- [ ] Update matching tests in the same slice so they do not preserve the retired `shared/providers` imports.
- [ ] Run the import scan again and confirm the only remaining references, if any, are intentional compatibility stubs you still plan to remove in this branch.

### Task 3: Delete dead session compatibility shims

- [ ] Reconfirm zero imports for:
  - `package:culcul/shared/providers/session_refresh_provider.dart`
  - `package:culcul/shared/session/session_cookie_refresher.dart`
- [ ] Delete:
  - `lib/shared/providers/session_refresh_provider.dart`
  - `lib/shared/session/session_cookie_refresher.dart`
- [ ] If any unexpected import appears during the scan, stop and document it rather than silently reintroducing aliases.

### Task 4: Tighten architecture guards and docs after the migration is real

- [ ] Create `test/architecture/provider_bootstrap_ownership_guard_test.dart`.
- [ ] Make the new guard fail on production imports of:
  - `package:culcul/shared/providers/cache_store_provider.dart`
  - `package:culcul/shared/providers/cookie_jar_provider.dart`
  - `package:culcul/shared/providers/storage_provider.dart`
  - `package:culcul/shared/providers/session_refresh_provider.dart`
  - `package:culcul/shared/session/session_cookie_refresher.dart`
- [ ] Update `test/architecture/phase3_legacy_import_paths_test.dart` only if keeping the provider rule there is clearly simpler than a separate guard. Do not duplicate the same assertion in two places.
- [ ] Update `docs/architecture/shared-boundary-rules.md` and `docs/architecture/phase3-structural-normalization-rules.md` so they document `core/bootstrap` provider ownership and the removal of the old session aliases.

### Task 5: Validate the slice end to end

- [ ] Run focused tests for touched consumers, at minimum:
  - `flutter test test/architecture/provider_bootstrap_ownership_guard_test.dart --reporter compact`
  - `flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact`
  - relevant consumer tests touched in `test/features/**`
- [ ] Run:
  `flutter analyze`
- [ ] Run:
  `git diff --stat`
  and confirm the branch stays inside provider ownership, dead-shim cleanup, and architecture doc/test updates.

## Commit Strategy

- Commit 1: add `core/bootstrap` provider homes and regenerate codegen
- Commit 2: migrate production and test imports
- Commit 3: delete dead session shims and add provider ownership guard/docs

## Risks To Watch

- storage-box provider moves touch auth, settings, and search in one slice; keep API-compatible names unless a rename is unavoidable
- `dio_client.dart` and `csrf_interceptor.dart` sit on shared infra paths, so import changes there should stay mechanical and not reopen earlier network-boundary refactors
- avoid turning this slice into a full bootstrap redesign; moving ownership is enough

## Out Of Scope

- feature-local workflow refactors
- router changes
- theme or responsive cleanup
- deleting `lib/shared/**` wholesale
- reorganizing unrelated barrels or DTO/entity files

## Done Criteria

- production code no longer imports the retired `shared/providers` bootstrap contracts
- dead session compatibility shims are removed
- architecture docs describe the new ownership correctly
- the provider ownership guard passes
- `flutter analyze` passes

## Handoff Notes

If this plan lands cleanly, the next follow-up can reassess whether any remaining `shared/providers/**` files still belong in `shared`, especially `wbi_provider`, or whether that should become a separate infra-ownership slice.
