# Phase 33 Architecture Consolidation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use
> superpowers:subagent-driven-development (recommended) or
> superpowers:executing-plans to implement this plan task-by-task. Steps use
> checkbox (`- [ ]`) syntax for tracking. Use bd for issue status, not markdown
> TODOs outside this plan.

## Global Rules

- Work from `docs/specs/phase33-architecture-consolidation.md`.
- Use Git Bash on Windows.
- Run GitNexus impact before editing any function, class, or method.
- Stop and report before editing HIGH or CRITICAL risk symbols.
- Keep generated files consistent with `dart run build_runner build`.
- Do not use the removed build_runner conflict-output flag.
- Run `gitnexus_detect_changes(scope: "all")` before committing.
- Do not modify dirty user files outside the current worktree.

## File Map

- Archived:
  - `docs/specs/archive/2026-05-16-phase32-source-of-truth-consolidation.completed.md`
  - `docs/plans/archive/2026-05-16-phase32-source-of-truth-consolidation.completed.md`
- Active docs:
  - `docs/specs/phase33-architecture-consolidation.md`
  - `docs/plans/phase33-architecture-consolidation.md`
- Existing guard fixture, preserved:
  - `docs/architecture/phase30-application-seam-inventory.md`

## Task 0: Archive Phase 32 And Activate Phase 33

**Issue:** `culcul-7di`

**Files:**

- Move:
  - `docs/specs/phase32-source-of-truth-consolidation.md`
  - `docs/plans/phase32-source-of-truth-consolidation.md`
- Create:
  - `docs/specs/phase33-architecture-consolidation.md`
  - `docs/plans/phase33-architecture-consolidation.md`

**Steps:**

- [ ] Claim `culcul-7di`.

```bash
bd update culcul-7di --claim --json
```

- [ ] Move completed Phase 32 docs into archive paths.
- [ ] Write the Phase 33 spec.
- [ ] Write this Phase 33 plan.
- [ ] Verify only docs and bd metadata changed.

```bash
git status --short
```

- [ ] Close `culcul-7di`.

```bash
bd close culcul-7di --reason "Phase 33 spec and plan created; Phase 32 docs archived." --json
```

## Task 1: Standardize ResourceApi Instantiation

**Issue:** `culcul-xoe`

**Impact baseline:** `ResourceApi` is MEDIUM risk: 7 direct callers/importers,
34 total impacted symbols.

**Files likely touched:**

- `lib/core/data/network/resource_api.dart`
- `lib/core/data/network/resource_api_provider.dart`
- `lib/core/data/network/providers/wbi_helper_provider.dart`
- `lib/core/services/media_service.dart`
- `lib/features/video/data/video_repository_impl.dart`
- `lib/features/video/data/danmaku_repository_impl.dart`
- `test/architecture/architecture_boundary_guard_test.dart`

**Steps:**

- [ ] Claim `culcul-xoe`.
- [ ] Run GitNexus impact on `ResourceApi`, `resourceApi`, and
  `basicResourceApi`.
- [ ] Add or extend an architecture guard that fails if `ResourceApi(` is used
  outside the approved provider/factory files.
- [ ] Run the new guard and confirm it fails on current ad hoc instantiation.
- [ ] Route direct `ResourceApi` construction through the approved provider or
  constructor injection.
- [ ] Run `dart run build_runner build` if provider annotations changed.
- [ ] Run `flutter test test/architecture`.
- [ ] Run `flutter analyze --no-fatal-infos`.
- [ ] Run `gitnexus_detect_changes(scope: "all")`.
- [ ] Close `culcul-xoe`.

## Task 2: Remove Ranking Dead Code And Stale Names

**Issue:** `culcul-1iv`

**Impact baseline:** `RankingCategory` is LOW risk: 2 direct importers, 4 total
impacted symbols. `PageQuery` is already absent. `rankingCategoriesV2` still
exists and is used by the ranking page.

**Files likely touched:**

- `lib/features/ranking/presentation/models/ranking_category.dart`
- `lib/features/ranking/presentation/pages/ranking_page.dart`
- `lib/features/ranking/presentation/widgets/ranking_list_view.dart`
- `test/architecture/architecture_boundary_guard_test.dart`

**Steps:**

- [ ] Claim `culcul-1iv`.
- [ ] Run GitNexus impact on `RankingCategory`.
- [ ] Add a guard assertion that rejects `PageQuery` and
  `rankingCategoriesV2`.
- [ ] Run the guard and confirm `rankingCategoriesV2` fails.
- [ ] Rename the single active list to `rankingCategories`.
- [ ] Update ranking page/list imports and references.
- [ ] Run `flutter test test/architecture`.
- [ ] Run `flutter analyze --no-fatal-infos`.
- [ ] Run `gitnexus_detect_changes(scope: "all")`.
- [ ] Close `culcul-1iv`.

## Task 3: Extract Shared CommentService

**Issue:** `culcul-mt9`

**Files likely touched:**

- `lib/core/contracts/comment_contract.dart`
- `lib/core/services/comment_service.dart`
- `lib/core/services/comment_service_provider.dart`
- `lib/features/video/data/video_api.dart`
- `lib/features/video/data/video_api.g.dart`
- `lib/features/dynamic/data/dynamic_api.dart`
- `lib/features/dynamic/data/dynamic_api.g.dart`
- Video and dynamic comment view models that currently call feature APIs.

**Steps:**

- [ ] Claim `culcul-mt9`.
- [ ] Run GitNexus impact on `VideoApi`, `DynamicApi`, and
  `CommentResponse`.
- [ ] Write a failing unit or architecture test proving video and dynamic common
  reply endpoints use one shared service path.
- [ ] Create `CommentService` over `CommentResponse`, `CommentItem`, oid, type,
  and optional headers.
- [ ] Keep article cursor-specific comment loading in dynamic until another
  feature shares it.
- [ ] Remove duplicated common reply endpoint methods from feature APIs or make
  them private implementation details of the shared service.
- [ ] Run `dart run build_runner build`.
- [ ] Run targeted comment-related tests.
- [ ] Run `flutter test test/architecture`.
- [ ] Run `flutter analyze --no-fatal-infos`.
- [ ] Run `gitnexus_detect_changes(scope: "all")`.
- [ ] Close `culcul-mt9`.

## Task 4: Unify Feedback And Toast Usage

**Issue:** `culcul-phn`

**Impact baseline:** `AppFeedbackContext` is HIGH risk: 22 direct importers,
69 total impacted symbols. Do this as a standalone slice.

**Files likely touched:**

- `lib/core/feedback/app_feedback.dart`
- `test/architecture/architecture_feedback_guard_test.dart`
- Feature presentation files that show snackbars, toasts, or raw errors.

**Steps:**

- [ ] Claim `culcul-phn`.
- [ ] Run GitNexus impact on `AppFeedbackContext`.
- [ ] Report the HIGH risk blast radius before editing code.
- [ ] Extend the feedback guard to reject any second toast/snackbar abstraction.
- [ ] Run the guard and confirm current offenders fail if present.
- [ ] Convert feature calls to `BuildContext` feedback extensions.
- [ ] Delete zero-value wrappers such as legacy toast helpers when no callers
  remain.
- [ ] Run `flutter test test/architecture/architecture_feedback_guard_test.dart`.
- [ ] Run `flutter analyze --no-fatal-infos`.
- [ ] Run `gitnexus_detect_changes(scope: "all")`.
- [ ] Request code review before closing because the slice is HIGH risk.
- [ ] Close `culcul-phn`.

## Task 5: Continue Presentation-Data Boundary Cleanup

**Issue:** `culcul-3a4`

**Files likely touched:**

- `test/architecture/architecture_boundary_guard_test.dart`
- `docs/architecture/phase30-application-seam-inventory.md`
- Feature presentation files importing data or proto internals.

**Steps:**

- [ ] Re-read the active seam inventory.
- [ ] Run the architecture boundary guard.
- [ ] Pick one feature with the smallest failing presentation-data surface.
- [ ] Run GitNexus impact on each symbol before moving or deleting it.
- [ ] Move shared contracts to `core/contracts/` or UI-only types to `ui/`.
- [ ] Delete wrappers that only forward to the moved source.
- [ ] Update the seam inventory in the same slice.
- [ ] Run `flutter test test/architecture`.
- [ ] Run `flutter analyze --no-fatal-infos`.
- [ ] Run `gitnexus_detect_changes(scope: "all")`.
- [ ] Update or close `culcul-3a4` according to remaining scope.

## Task 6: Build Command And Analyzer Debt Cleanup

**Issues:** `culcul-354`, `culcul-xap`, `culcul-ojk`

**Files likely touched:**

- `docs/plans/archive/*.md`
- `scripts/*`
- `analysis_options.yaml`
- Files reported by `flutter analyze --no-fatal-infos`.

**Steps:**

- [ ] Claim `culcul-354`.
- [ ] Search active docs and scripts for the removed build_runner
  conflict-output flag.
- [ ] Replace active command docs with `dart run build_runner build`.
- [ ] Keep historical archive references only if they are clearly marked as
  historical and not instructions.
- [ ] Run `dart run build_runner build`.
- [ ] Close `culcul-354` when no active instruction uses the removed flag.
- [ ] Claim one analyzer debt issue.
- [ ] Run `flutter analyze --no-fatal-infos`.
- [ ] Fix one coherent lint cluster at a time.
- [ ] Run `flutter analyze --no-fatal-infos` again.
- [ ] Update or close the analyzer debt issue according to remaining count.

## Final Verification

- [ ] Run architecture tests.

```bash
flutter test test/architecture
```

- [ ] Run full static analysis.

```bash
flutter analyze --no-fatal-infos
```

- [ ] Run build generation with the supported command.

```bash
dart run build_runner build
```

- [ ] Run GitNexus change detection.

```text
gitnexus_detect_changes(scope: "all")
```

- [ ] Commit only the files from the completed slice.
- [ ] Push git and bd state according to `AGENTS.md`.
