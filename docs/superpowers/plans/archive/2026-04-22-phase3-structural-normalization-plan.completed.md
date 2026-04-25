> Completed on 2026-04-24 after repo audit confirmed the phase-3 slice landed.
> Verification used during closeout: `flutter test test/architecture/phase3_workflow_ownership_guard_test.dart --reporter compact`, `flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact`, `flutter test test/architecture/shared_boundary_guard_test.dart --reporter compact`, and `flutter analyze`.
> The next active planning surface is `docs/superpowers/specs/2026-04-24-provider-bootstrap-ownership-normalization-design.md` plus `docs/superpowers/plans/2026-04-24-provider-bootstrap-ownership-normalization-plan.md`.

# Phase 3 Structural Normalization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

## Goal

Finish the next meaningful architecture slice after boundary cleanup and route-entry rollout:

- retire the remaining production imports of transitional `presentation/pages/*_page_commands.dart` files where a stable `application/` home now exists or should exist
- migrate the high-churn compatibility imports from `lib/shared/**` to their established `lib/core/**` and `lib/ui/**` homes
- tighten architecture guards so phase-3 normalization stops regressing once the migrations land

This plan intentionally supersedes the narrow favorites-only plan. The codebase now has broader phase-3 rules, active `core/` and `ui/` pilot homes, and only a few concentrated normalization seams left.

## Architecture

Phase 1 and Phase 2 are effectively established already:

- `lib/shared/**` no longer imports feature packages
- `lib/app/router/app_routes.dart` now uses feature `route_entry.dart` seams
- dynamic detail and notification chat already have approved `application/` homes
- session refresh and responsive helpers already have pilot `core/` and `ui/` homes with compatibility exports

The remaining work is Phase 3 normalization:

1. complete workflow-home ownership for the remaining transitional features
2. migrate real production imports away from compatibility paths
3. add guards only after ownership and import direction are actually clean

## Tech Stack

Flutter, Dart 3.10, hooks_riverpod / flutter_riverpod, go_router, build_runner, flutter_test

---

## File Structure Map

### Architecture docs and plan artifacts

- Modify: `docs/architecture/shared-boundary-rules.md`
- Modify: `docs/architecture/phase2-route-and-orchestration-rules.md`
- Modify: `docs/architecture/phase3-structural-normalization-rules.md`
- Modify: `test/architecture/phase3_workflow_ownership_guard_test.dart`
- Create: `test/architecture/phase3_legacy_import_paths_test.dart`

### Workflow ownership targets

- Modify: `lib/features/favorites/application/favorite_folder_commands.dart`
- Modify: `lib/features/favorites/presentation/pages/favorites_page.dart`
- Modify: `lib/features/favorites/presentation/pages/favorite_detail_page.dart`
- Delete: `lib/features/favorites/presentation/pages/favorites_page_commands.dart`
- Delete: `lib/features/favorites/presentation/pages/favorite_detail_page_commands.dart`
- Create: `lib/features/video/application/comment_reply_commands.dart`
- Modify: `lib/features/video/presentation/pages/comment_reply_page.dart`
- Delete: `lib/features/video/presentation/pages/comment_reply_page_commands.dart`

### Workflow tests

- Modify: `test/features/favorites/application/favorite_folder_commands_test.dart`
- Modify: `test/features/favorites/presentation/pages/favorites_workflow_wiring_test.dart`
- Modify: `test/features/favorites/presentation/pages/favorites_page_commands_test.dart`
- Modify: `test/features/favorites/presentation/pages/favorite_detail_page_commands_test.dart`
- Create: `test/features/video/application/comment_reply_commands_test.dart`
- Modify: `test/features/video/presentation/pages/comment_reply_page_commands_test.dart`

### Compatibility-path migration targets

- Modify: `lib/app/shell/main_shell.dart`
- Modify: `lib/features/dynamic/presentation/pages/dynamic_page.dart`
- Modify: `lib/features/dynamic/presentation/widgets/dynamic_list_view.dart`
- Modify: `lib/features/profile/presentation/widgets/profile_action_grid.dart`
- Modify: `lib/features/profile/presentation/widgets/profile_menu.dart`
- Modify: `lib/features/profile/presentation/widgets/profile_stats.dart`
- Modify: `lib/features/video/presentation/widgets/info/video_info_view.dart`
- Modify: `lib/features/video/**` files that still import `package:culcul/shared/errors/app_error.dart` or `package:culcul/shared/result/result.dart`
- Modify: `lib/features/notification/**` files that still import `package:culcul/shared/errors/app_error.dart` or `package:culcul/shared/result/result.dart`
- Modify: `lib/features/dynamic/**` files that still import `package:culcul/shared/errors/app_error.dart` or `package:culcul/shared/result/result.dart`
- Modify: `lib/features/profile/**` files that still import `package:culcul/shared/errors/app_error.dart` or `package:culcul/shared/result/result.dart`
- Modify matching test files under `test/features/**`

### Compatibility exports that should only remain if imports still exist

- Modify or delete later in the slice:
  - `lib/shared/errors/app_error.dart`
  - `lib/shared/errors/exceptions.dart`
  - `lib/shared/result/result.dart`
  - `lib/shared/responsive/responsive.dart`
  - `lib/shared/responsive/app_breakpoints.dart`
  - `lib/shared/responsive/app_responsive.dart`
  - `lib/shared/responsive/responsive_container.dart`

---

## Implementation Tasks

### Task 0: Prepare the isolated phase-3 worktree and capture a clean baseline

- [ ] Use the existing ignored `.worktrees/` directory. Verify with `git check-ignore -v .worktrees`.
- [ ] Create a dedicated branch and worktree, for example:
  `git worktree add .worktrees/phase3-normalization -b refactor/phase3-normalization`
- [ ] In the worktree, run:
  `flutter pub get`
- [ ] Regenerate artifacts before refactoring:
  `dart run build_runner build --delete-conflicting-outputs`
- [ ] Regenerate i18n if needed:
  `dart run slang`
- [ ] Record the starting baseline with:
  `flutter test test/architecture/shared_boundary_guard_test.dart`
  `flutter test test/architecture/auth_video_architecture_guard_test.dart`
  `flutter test test/architecture/phase3_workflow_ownership_guard_test.dart`
  `flutter analyze`
- [ ] If baseline failures appear outside known generated-artifact problems, stop and record them before changing workflow ownership.

### Task 1: Finish favorites workflow ownership so production no longer imports page-command adapters

- [ ] Re-read:
  `lib/features/favorites/application/favorite_folder_commands.dart`,
  `lib/features/favorites/presentation/pages/favorites_page.dart`,
  `lib/features/favorites/presentation/pages/favorite_detail_page.dart`,
  and the existing favorites tests.
- [ ] Keep durable folder mutations in `FavoriteFolderCommandWorkflow`; do not move them back into presentation.
- [ ] Replace the public `FavoritesPageCommands` and `FavoriteDetailPageCommands` classes with page-local closures or file-private helpers inside the page files. The page may still present dialogs, invalidate local state, navigate, and show error UI, but it should call `FavoriteFolderCommandWorkflow` directly for durable mutations.
- [ ] Delete:
  `lib/features/favorites/presentation/pages/favorites_page_commands.dart`
  and
  `lib/features/favorites/presentation/pages/favorite_detail_page_commands.dart`
  once no production import needs them.
- [ ] Rewrite the favorites presentation tests so they prove page wiring and UI reactions instead of preserving the legacy adapter classes.
- [ ] Expand `test/features/favorites/application/favorite_folder_commands_test.dart` if any mutation paths are still only covered indirectly.

### Task 2: Introduce a real application home for video comment-reply workflow

- [ ] Create `lib/features/video/application/comment_reply_commands.dart` as the long-term workflow home for reply submission and guarded reply-pagination triggers.
- [ ] Move controller-facing orchestration from `presentation/pages/comment_reply_page_commands.dart` into the new application file.
- [ ] Keep page-only concerns in `comment_reply_page.dart`: sheet presentation, `BuildContext`, and route-local wiring.
- [ ] Update `comment_reply_page.dart` so production imports the new application file, not the legacy presentation helper.
- [ ] Delete `lib/features/video/presentation/pages/comment_reply_page_commands.dart` after the page and tests no longer need it.
- [ ] Add `test/features/video/application/comment_reply_commands_test.dart` for the new application workflow and convert the legacy presentation test into a page-wiring or widget-level test that proves the UI seam only.

### Task 3: Tighten the phase-3 workflow guard after ownership is actually clean

- [ ] Update `docs/architecture/phase3-structural-normalization-rules.md` so the approved homes list includes:
  - `lib/features/favorites/application/favorite_folder_commands.dart`
  - `lib/features/video/application/comment_reply_commands.dart`
- [ ] Keep `lib/features/live/application/live_room_page_commands.dart` documented as an accepted application home if the current branch still uses it directly from pages, but do not invent a legacy-path guard entry unless there is a real presentation path worth blocking.
- [ ] Refactor `test/architecture/phase3_workflow_ownership_guard_test.dart` so one approved home can block multiple legacy presentation paths. Favorites needs both former page-command files; video needs the former comment-reply page-command file.
- [ ] Extend `docs/architecture/phase2-route-and-orchestration-rules.md` and `docs/architecture/shared-boundary-rules.md` so they point at the new phase-3 ownership state rather than the now-retired favorites transitional adapter note.
- [ ] Run:
  `flutter test test/architecture/phase3_workflow_ownership_guard_test.dart`
  and confirm production imports no longer point at the deleted legacy paths.

### Task 4: Migrate responsive imports from compatibility paths to `lib/ui/**`

- [ ] Replace every production import of `package:culcul/shared/responsive/responsive.dart` with the narrowest `lib/ui/responsive/**` import that matches the actual usage.
- [ ] Start with the known production hotspots:
  - `lib/app/shell/main_shell.dart`
  - `lib/features/dynamic/presentation/pages/dynamic_page.dart`
  - `lib/features/dynamic/presentation/widgets/dynamic_list_view.dart`
  - `lib/features/profile/presentation/widgets/profile_action_grid.dart`
  - `lib/features/profile/presentation/widgets/profile_menu.dart`
  - `lib/features/profile/presentation/widgets/profile_stats.dart`
  - `lib/features/video/presentation/widgets/info/video_info_view.dart`
- [ ] Update the related tests, including `test/features/home/home_layout_spec_test.dart`, so they import `lib/ui/responsive/**` directly too.
- [ ] Create `test/architecture/phase3_legacy_import_paths_test.dart` and make it fail on new `lib/**` imports of:
  - `package:culcul/shared/responsive/responsive.dart`
  - `package:culcul/shared/responsive/app_breakpoints.dart`
  - `package:culcul/shared/responsive/app_responsive.dart`
  - `package:culcul/shared/responsive/responsive_container.dart`
- [ ] Leave the legacy `lib/shared/responsive/**` files as compatibility exports only until both production and tests are migrated.

### Task 5: Migrate result/error imports from compatibility paths to `lib/core/**`

- [ ] Use `rg -l "package:culcul/shared/errors/app_error.dart|package:culcul/shared/errors/exceptions.dart|package:culcul/shared/result/result.dart" lib test` to capture the exact working set before editing.
- [ ] Migrate the highest-churn production areas first:
  - `lib/features/video/**`
  - `lib/features/notification/**`
  - `lib/features/dynamic/**`
  - `lib/features/profile/**`
- [ ] Update each touched file to import:
  - `package:culcul/core/errors/app_error.dart`
  - `package:culcul/core/errors/exceptions.dart`
  - `package:culcul/core/result/result.dart`
  as appropriate.
- [ ] Migrate the matching tests in the same slice so new coverage does not reintroduce the legacy shared imports.
- [ ] Extend `test/architecture/phase3_legacy_import_paths_test.dart` so new production imports of the legacy error/result paths fail once the working set is zero in `lib/**`.
- [ ] Only remove the compatibility exports in `lib/shared/errors/**` and `lib/shared/result/result.dart` after both production code and tests no longer depend on them.

### Task 6: Validate and land the normalization slice in reviewable commits

- [ ] Run focused tests after each task:
  - `flutter test test/features/favorites/application/favorite_folder_commands_test.dart`
  - `flutter test test/features/favorites/presentation/pages/favorites_workflow_wiring_test.dart`
  - `flutter test test/features/video/application/comment_reply_commands_test.dart`
  - `flutter test test/architecture/phase3_workflow_ownership_guard_test.dart`
  - `flutter test test/architecture/phase3_legacy_import_paths_test.dart`
- [ ] Run full architecture checks before the final commit:
  `flutter test test/architecture`
- [ ] Run:
  `flutter analyze`
- [ ] Run:
  `git diff --stat`
  and confirm the slice stays inside workflow ownership, compatibility-path migration, and architecture docs/tests.
- [ ] If any step forces a new stable home for `shared/providers/*`, stop and write a follow-up plan instead of improvising a provider-tree redesign inside this slice.

## Commit Strategy

- Commit 1: favorites transition completed and legacy favorites page-command files removed
- Commit 2: video comment-reply workflow moved to `application/` and legacy presentation helper removed
- Commit 3: phase-3 docs and workflow guard tightened for the new approved homes
- Commit 4: responsive import migration plus legacy-path architecture guard
- Commit 5: error/result import migration plus compatibility-export cleanup if the working set reaches zero

## Risks To Watch

- favorites pages already mix UI invalidation with workflow calls; removing the adapter classes should not accidentally move UI-only concerns into `application/`
- video comment reply currently couples pagination gating and sheet presentation; the new application home must keep `BuildContext` and sheet UI out of the workflow layer
- compatibility-path migration is mechanically simple but wide; do it in bounded batches so unrelated formatting churn does not hide architectural mistakes
- do not fold `shared/providers/*` redesign into this plan unless a concrete stable home is defined first

## Out Of Scope

- full router redesign
- deleting `lib/shared/**` wholesale
- moving every provider under `shared/providers/**` in the same slice
- theme-token redesign or visual refactors
- feature-local cleanups not directly tied to workflow ownership or established compatibility homes

## Done Criteria

- no production code imports favorites or video `presentation/pages/*_page_commands.dart` files
- `docs/architecture/phase3-structural-normalization-rules.md` and the guard agree on the approved workflow homes
- production imports of legacy responsive paths are gone
- production imports of legacy shared error/result paths are gone
- compatibility exports are either deleted or clearly retained only for still-migrating tests
- `flutter test test/architecture`
  and
  `flutter analyze`
  pass

## Handoff Notes

If this plan lands cleanly, the next follow-up should be a separate provider-home plan for the remaining `lib/shared/providers/**` files (`cache_store_provider`, `cookie_jar_provider`, `storage_provider`, `wbi_provider`) rather than widening this normalization slice further.
