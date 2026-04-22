# Favorites Workflow Normalization Implementation Plan
> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

## Goal

Normalize the remaining `favorites` workflow ownership so durable mutations live under `lib/features/favorites/application/`, while `presentation/pages/*_page_commands.dart` stays a thin UI seam for dialogs, page invalidation, and navigation only.

This plan intentionally replaces the archived broad cleanup plan with one narrow execution slice. It aligns with:

- `docs/architecture/phase2-route-and-orchestration-rules.md`
- `docs/architecture/phase3-structural-normalization-rules.md`
- `test/architecture/phase3_workflow_ownership_guard_test.dart`

## Scope

In scope:

- tighten ownership around `favorite_folder_commands.dart`
- reduce durable mutation logic in `favorites_page_commands.dart`
- reduce durable mutation logic in `favorite_detail_page_commands.dart`
- add or update tests that prove the ownership split
- update phase-3 docs/guards only if the migration is complete enough to enforce

Out of scope:

- migrating `video` reply-sheet workflows
- expanding the approved application-home list for unrelated features
- large `shared -> core/ui` moves
- route graph redesign

## File Structure Map

### Primary production files

- `lib/features/favorites/application/favorite_folder_commands.dart`
- `lib/features/favorites/presentation/pages/favorites_page_commands.dart`
- `lib/features/favorites/presentation/pages/favorite_detail_page_commands.dart`
- `lib/features/favorites/presentation/pages/favorites_page.dart`
- `lib/features/favorites/presentation/pages/favorite_detail_page.dart`
- `lib/features/favorites/presentation/widgets/fav_folder_dialog.dart`

### Test and guard files

- `test/features/favorites/application/favorite_folder_commands_test.dart`
- `test/features/favorites/presentation/pages/favorites_page_commands_test.dart`
- `test/features/favorites/presentation/pages/favorite_detail_page_commands_test.dart`
- `test/architecture/phase3_workflow_ownership_guard_test.dart`

### Architecture docs

- `docs/architecture/phase2-route-and-orchestration-rules.md`
- `docs/architecture/phase3-structural-normalization-rules.md`

## Implementation Tasks

### Task 1: Establish the current ownership boundary before moving code

- [ ] Read `favorite_folder_commands.dart`, `favorites_page_commands.dart`, and `favorite_detail_page_commands.dart` side by side.
- [ ] Make a short responsibility table in the worklog or commit message draft with three buckets:
  `durable mutation`, `UI adapter`, and `mixed/unclear`.
- [ ] Identify every method in the two page-command files that currently performs repository coordination, branching, or mutation sequencing.
- [ ] Verify whether those methods are called directly from pages, toolbars, or dialogs so the later extraction does not silently break call sites.

### Task 2: Move durable folder workflows into `application/`

- [ ] Expand `lib/features/favorites/application/favorite_folder_commands.dart` so it owns every non-UI folder workflow that is still implemented in presentation command files.
- [ ] Keep the application API shaped around explicit workflow methods rather than page-specific naming. Prefer names that describe the mutation, for example create/rename/delete/move/toggle/set-default style operations if those are the actual responsibilities.
- [ ] If presentation-layer methods currently mix UI concerns with mutation work, split them so the application layer returns enough structured results for the page layer to decide how to show dialogs, snackbars, or refresh behavior.
- [ ] Do not move widget-only behavior into `application/`. Dialog launching, `BuildContext` usage, route popping, and presentation copy selection stay outside.

### Task 3: Shrink `favorites_page_commands.dart` into a UI adapter

- [ ] Refactor `lib/features/favorites/presentation/pages/favorites_page_commands.dart` so it delegates durable mutations to `favorite_folder_commands.dart`.
- [ ] Keep only presentation concerns in this file:
  dialog orchestration, invalidating page state, forwarding user selections, and navigation glue.
- [ ] Remove any direct repository writes, mutation branching, or long command sequencing that can live in the application layer.
- [ ] Update `favorites_page.dart` call sites only as much as needed to reflect the slimmer adapter API.

### Task 4: Shrink `favorite_detail_page_commands.dart` into a UI adapter

- [ ] Refactor `lib/features/favorites/presentation/pages/favorite_detail_page_commands.dart` with the same boundary:
  UI adapter only, no durable workflow ownership.
- [ ] Reuse the application-level commands introduced in Task 2 instead of duplicating detail-page-specific mutation logic.
- [ ] Keep detail-page-only concerns local if they are truly UI concerns, such as selection prompts, local invalidation, or navigation after a completed workflow.
- [ ] Update `favorite_detail_page.dart` or toolbar helpers only where the narrowed API requires it.

### Task 5: Lock the new ownership with tests

- [ ] Extend `test/features/favorites/application/favorite_folder_commands_test.dart` to cover every mutation workflow that was moved from presentation command files.
- [ ] Update `test/features/favorites/presentation/pages/favorites_page_commands_test.dart` so it verifies delegation to the application layer and preserves only UI responsibilities.
- [ ] Update `test/features/favorites/presentation/pages/favorite_detail_page_commands_test.dart` with the same expectation.
- [ ] Prefer focused tests over broad widget tests unless a widget boundary is the only way to prove the adapter behavior.

### Task 6: Decide whether the phase-3 guard should be tightened now

- [ ] Re-read `docs/architecture/phase3-structural-normalization-rules.md` after the refactor lands.
- [ ] If `favorites` now has a stable application home and production imports no longer need the presentation command files for workflow ownership, add the new approved home(s) to `test/architecture/phase3_workflow_ownership_guard_test.dart`.
- [ ] Update `docs/architecture/phase3-structural-normalization-rules.md` to list the new approved home(s) only when the migration is complete enough to enforce.
- [ ] If `favorites` still needs the page-command files as transitional adapters, leave the guard unchanged and document that the feature remains transitional by design.

### Task 7: Validate the slice end to end

- [ ] Run:
  `flutter test test/features/favorites/application/favorite_folder_commands_test.dart`
- [ ] Run:
  `flutter test test/features/favorites/presentation/pages/favorites_page_commands_test.dart`
- [ ] Run:
  `flutter test test/features/favorites/presentation/pages/favorite_detail_page_commands_test.dart`
- [ ] Run:
  `flutter test test/architecture/phase3_workflow_ownership_guard_test.dart`
- [ ] Run:
  `flutter analyze`
- [ ] If any touched call site crosses feature boundaries unexpectedly, stop and document the new coupling before widening the refactor.

## Commit Strategy

- Commit 1: application workflow extraction plus focused application tests
- Commit 2: favorites page-command slimming plus page-command tests
- Commit 3: detail page-command slimming plus detail tests
- Commit 4: phase-3 doc/guard updates if applicable

## Risks To Watch

- `favorites_page_commands.dart` may currently hide mutation ordering assumptions that tests do not cover yet.
- `favorite_detail_page_commands.dart` may mix local invalidation with workflow logic in a way that is easy to over-extract.
- If both page-command files call the same repository operations with slightly different side effects, forcing them into one application API too early may erase valid UI differences.
- The phase-3 guard should only be tightened after production imports clearly point at the application home. Tightening it early will create churn without architectural value.

## Done Criteria

- all durable `favorites` folder workflows are owned by `application/favorite_folder_commands.dart`
- both presentation command files are UI adapters only
- favorites tests pass with the new ownership split
- `flutter analyze` passes
- phase-3 docs and guards either enforce the completed migration or explicitly leave `favorites` transitional

## Handoff Notes

If this plan completes cleanly, the next best follow-up plan should target `lib/features/video/presentation/pages/comment_reply_page_commands.dart`, which is still documented as an intentional transitional adapter in the phase-3 rules.
