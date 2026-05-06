# Shared Perf Ownership Normalization Implementation Plan

**Goal:** Move the canonical performance infrastructure from
`lib/shared/perf/**` to `lib/core/perf/**`, migrate all repo imports in the
same slice, delete the retired shared paths, and extend the architecture guard
so old perf imports cannot return.

**Architecture:** Keep this slice narrow. Perf is already documented as
cross-cutting infrastructure and does not depend on feature code. The change
should preserve public APIs and behavior while normalizing ownership. Do not
expand into network, widgets, pagination, or theme cleanup.

## File Structure Map

### Plan and design docs

- Reference:
  `docs/superpowers/specs/2026-05-01-shared-perf-ownership-normalization-design.md`
- Modify: `docs/architecture/shared-boundary-rules.md`
- Modify: `docs/architecture/phase3-structural-normalization-rules.md`

### Code files expected to change

- Create:
  `lib/core/perf/feature_flow_perf_logger.dart`
- Create:
  `lib/core/perf/frame_timing_sampler.dart`
- Create:
  `lib/core/perf/list_perf_logger.dart`
- Create:
  `lib/core/perf/network_perf_logger.dart`
- Create:
  `lib/core/perf/performance_policy.dart`
- Create:
  `lib/core/perf/startup_perf_logger.dart`
- Create:
  `lib/core/perf/video_perf_logger.dart`
- Delete: `lib/shared/perf/*.dart`
- Modify:
  `lib/main.dart`
- Modify:
  `lib/app/bootstrap/deferred_app_init.dart`
- Modify:
  `lib/shared/network/network_concurrency_executor.dart`
- Modify:
  `lib/shared/pagination/scroll_load_trigger.dart`
- Modify:
  `lib/shared/widgets/adaptive_blur.dart`
- Modify:
  `lib/shared/widgets/app_card_container.dart`
- Modify:
  `lib/shared/widgets/app_shimmer.dart`
- Modify:
  `lib/features/dynamic/**`
- Modify:
  `lib/features/favorites/**`
- Modify:
  `lib/features/home/**`
- Modify:
  `lib/features/live/**`
- Modify:
  `lib/features/profile/**`
- Modify:
  `lib/features/search/**`
- Modify:
  `lib/features/video/**`

### Tests

- Modify:
  `test/architecture/phase3_legacy_import_paths_test.dart`
- Modify:
  `test/app/shell/main_shell_responsive_test.dart`
- Modify:
  `test/shared/perf/startup_perf_logger_test.dart`
- Modify:
  `test/shared/widgets/adaptive_blur_test.dart`
- Modify:
  `test/shared/widgets/app_shimmer_test.dart`

## Implementation Tasks

### Task 0: Prepare the worktree, issue, and baseline

**Files:**

- Reference: `.gitignore`
- Reference:
  `docs/superpowers/specs/2026-05-01-shared-perf-ownership-normalization-design.md`

- [ ] **Step 1: Verify the worktree location is still ignored**

Run:

```bash
git check-ignore -v .worktrees
```

Expected: output shows `.worktrees/` is ignored by `.gitignore`.

- [ ] **Step 2: Create the dedicated branch and worktree**

Run:

```bash
git worktree add .worktrees/core-perf-ownership -b refactor/core-perf-ownership
```

Expected: a clean worktree is created from `master`.

- [ ] **Step 3: Create and claim the bd issue inside the worktree**

Run:

```bash
cd .worktrees/core-perf-ownership
ISSUE_ID="$(bd create "Normalize shared perf ownership" --description="Move canonical performance infrastructure from lib/shared/perf to lib/core/perf, migrate all repo imports, delete the retired shared perf paths, and lock the old imports down with architecture tests and docs." -t task -p 1 --json | python -c 'import json,sys; print(json.load(sys.stdin)["id"])')"
bd update "$ISSUE_ID" --claim --json
```

Expected: the first command returns a new issue id and the second command marks
it claimed for the session.

- [ ] **Step 4: Record the baseline import surface and architecture status**

Run:

```bash
rg -l "package:culcul/shared/perf/" lib test | sort
flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact
flutter analyze
```

Expected: the `rg` output matches the known importer set; the existing legacy
import guard passes before perf paths are added; `flutter analyze` is either
green or any unrelated pre-existing failures are recorded before edits.

- [ ] **Step 5: Capture GitNexus blast radius for the moved public symbols**

Run impact analysis upstream for:

- `FeatureFlowPerfLogger`
- `FrameTimingSampler`
- `PerformancePolicy`
- `StartupPerfLogger`
- `NetworkPerfLogger`
- `ListPerfLogger`
- `VideoPerfLogger`

Expected: each symbol’s import surface is recorded before edits. If any symbol
reports HIGH or CRITICAL risk, stop and narrow the slice before modifying code.

### Task 1: Make the architecture guard fail on current shared perf imports

**Files:**

- Modify: `test/architecture/phase3_legacy_import_paths_test.dart`

- [ ] **Step 1: Add the retired perf paths to the guard list**

Append these paths to `_legacyImportPaths`:

- `package:culcul/shared/perf/feature_flow_perf_logger.dart`
- `package:culcul/shared/perf/frame_timing_sampler.dart`
- `package:culcul/shared/perf/list_perf_logger.dart`
- `package:culcul/shared/perf/network_perf_logger.dart`
- `package:culcul/shared/perf/performance_policy.dart`
- `package:culcul/shared/perf/startup_perf_logger.dart`
- `package:culcul/shared/perf/video_perf_logger.dart`

- [ ] **Step 2: Run the guard and confirm it fails on the known working set**

Run:

```bash
flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact
```

Expected: the test fails and the failure lists current `shared/perf` imports
from production files under `lib/**`.

### Task 2: Create `lib/core/perf/**` as the canonical home

**Files:**

- Create: `lib/core/perf/*.dart`

- [ ] **Step 1: Copy the perf helpers into `lib/core/perf/**` without API changes**

Create these files under `lib/core/perf/**`:

- `feature_flow_perf_logger.dart`
- `frame_timing_sampler.dart`
- `list_perf_logger.dart`
- `network_perf_logger.dart`
- `performance_policy.dart`
- `startup_perf_logger.dart`
- `video_perf_logger.dart`

Keep class names, enums, and method signatures unchanged.

- [ ] **Step 2: Fix intra-module imports to point at `package:culcul/core/perf/...`**

At minimum, update `performance_policy.dart` so it imports
`package:culcul/core/perf/frame_timing_sampler.dart`.

- [ ] **Step 3: Validate the new canonical files compile before broad importer churn**

Run:

```bash
flutter analyze
```

Expected: no new analyzer failures are introduced by the new `lib/core/perf/**`
files themselves.

### Task 3: Migrate shared and app-level consumers to `lib/core/perf/**`

**Files:**

- Modify: `lib/main.dart`
- Modify: `lib/app/bootstrap/deferred_app_init.dart`
- Modify: `lib/shared/network/network_concurrency_executor.dart`
- Modify: `lib/shared/pagination/scroll_load_trigger.dart`
- Modify: `lib/shared/widgets/adaptive_blur.dart`
- Modify: `lib/shared/widgets/app_card_container.dart`
- Modify: `lib/shared/widgets/app_shimmer.dart`

- [ ] **Step 1: Update imports to the new core paths**

Replace `package:culcul/shared/perf/...` imports in the files above with
`package:culcul/core/perf/...`.

- [ ] **Step 2: Re-run the focused tests that exercise these shared/app consumers**

Run:

```bash
flutter test test/shared/perf/startup_perf_logger_test.dart --reporter compact
flutter test test/shared/widgets/adaptive_blur_test.dart --reporter compact
flutter test test/shared/widgets/app_shimmer_test.dart --reporter compact
flutter test test/app/shell/main_shell_responsive_test.dart --reporter compact
```

Expected: the perf helpers still behave the same after the import move.

### Task 4: Migrate feature consumers and drive the shared-perf working set to zero

**Files:**

- Modify: `lib/features/dynamic/data/dynamic_repository_impl.dart`
- Modify:
  `lib/features/dynamic/presentation/view_models/article_detail_view_model.dart`
- Modify:
  `lib/features/dynamic/presentation/view_models/user_dynamic_view_model.dart`
- Modify:
  `lib/features/favorites/presentation/view_models/favorites_view_model.dart`
- Modify: `lib/features/home/presentation/pages/home_page.dart`
- Modify:
  `lib/features/home/presentation/view_models/home_feed_paging_mixin.dart`
- Modify:
  `lib/features/home/presentation/view_models/home_popular_view_model.dart`
- Modify:
  `lib/features/home/presentation/view_models/home_recommend_view_model.dart`
- Modify:
  `lib/features/home/presentation/widgets/home_feed_view_utils.dart`
- Modify: `lib/features/home/presentation/widgets/live_view.dart`
- Modify: `lib/features/home/presentation/widgets/popular_view.dart`
- Modify: `lib/features/home/presentation/widgets/recommend_view.dart`
- Modify:
  `lib/features/live/presentation/view_models/live_room_view_model.dart`
- Modify:
  `lib/features/profile/presentation/view_models/user_space_videos_view_model.dart`
- Modify: `lib/features/search/data/dtos/search_result.dart`
- Modify:
  `lib/features/search/presentation/view_models/search_view_model.dart`
- Modify: `lib/features/video/application/video_detail_workflows.dart`
- Modify: `lib/features/video/presentation/view_models/player_view_model.dart`

- [ ] **Step 1: Migrate every remaining feature import to `package:culcul/core/perf/...`**

Use:

```bash
rg -l "package:culcul/shared/perf/" lib test | sort
```

after each small batch to confirm the working set is shrinking toward zero.

- [ ] **Step 2: Stop only when the old shared perf imports remain in no production or test files**

Run:

```bash
rg -n "package:culcul/shared/perf/" lib test
```

Expected: no matches remain under `lib/**` or `test/**`.

- [ ] **Step 3: Delete the retired shared perf files**

Delete:

- `lib/shared/perf/feature_flow_perf_logger.dart`
- `lib/shared/perf/frame_timing_sampler.dart`
- `lib/shared/perf/list_perf_logger.dart`
- `lib/shared/perf/network_perf_logger.dart`
- `lib/shared/perf/performance_policy.dart`
- `lib/shared/perf/startup_perf_logger.dart`
- `lib/shared/perf/video_perf_logger.dart`

### Task 5: Update docs and close the slice with full verification

**Files:**

- Modify: `docs/architecture/shared-boundary-rules.md`
- Modify: `docs/architecture/phase3-structural-normalization-rules.md`
- Modify: `test/architecture/phase3_legacy_import_paths_test.dart`

- [ ] **Step 1: Update the architecture docs to reflect the new perf home**

Document that:

- perf is canonical under `lib/core/perf/**`
- `lib/shared/perf/**` is retired
- new production imports must use `package:culcul/core/perf/...`

- [ ] **Step 2: Re-run the guard now that the old paths are gone**

Run:

```bash
flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact
```

Expected: the guard passes with the perf paths included in `_legacyImportPaths`.

- [ ] **Step 3: Run the final validation set**

Run:

```bash
flutter test test/shared/perf/startup_perf_logger_test.dart --reporter compact
flutter test test/shared/widgets/adaptive_blur_test.dart --reporter compact
flutter test test/shared/widgets/app_shimmer_test.dart --reporter compact
flutter test test/app/shell/main_shell_responsive_test.dart --reporter compact
flutter test test/architecture --reporter compact
flutter analyze
git diff --stat
```

Expected: focused tests pass, architecture tests pass, `flutter analyze` is
green, and the diff stays constrained to perf ownership normalization, docs,
and architecture guards.

## Commit Strategy

- Commit 1: add failing legacy-import guard coverage for shared perf paths
- Commit 2: add `lib/core/perf/**` and migrate app/shared consumers
- Commit 3: migrate feature consumers and delete `lib/shared/perf/**`
- Commit 4: update docs and land final validation cleanups
