# Culcul Shared Perf Ownership Normalization Design

## Problem Summary

Phase 3 already defines `lib/core/**` as the long-term home for cross-cutting
infrastructure such as network, session, result, errors, services, perf, and
stable shared contracts. Culcul still keeps all canonical performance helpers
under `lib/shared/perf/**`, and production code imports those paths directly
from app bootstrap, feature view models, shared widgets, shared pagination, and
shared network helpers.

That mismatch leaves `lib/shared/**` acting as an ownership home instead of a
compatibility layer. The next refactor slice should finish the perf ownership
move without reopening broader `shared/network`, `shared/widgets`, or
`shared/pagination` restructuring.

## Current Evidence

### Remaining `shared/perf/**` surface

Canonical perf files still live under `lib/shared/perf/**`:

- `feature_flow_perf_logger.dart`
- `frame_timing_sampler.dart`
- `list_perf_logger.dart`
- `network_perf_logger.dart`
- `performance_policy.dart`
- `startup_perf_logger.dart`
- `video_perf_logger.dart`

### Import surface

`rg -l "package:culcul/shared/perf/" lib test` currently returns these groups:

- app/bootstrap:
  `lib/main.dart`, `lib/app/bootstrap/deferred_app_init.dart`
- shared infrastructure:
  `lib/shared/network/network_concurrency_executor.dart`,
  `lib/shared/pagination/scroll_load_trigger.dart`,
  `lib/shared/widgets/adaptive_blur.dart`,
  `lib/shared/widgets/app_card_container.dart`,
  `lib/shared/widgets/app_shimmer.dart`
- features:
  dynamic, favorites, home, live, profile, search, and video
- tests:
  `test/app/shell/main_shell_responsive_test.dart`,
  `test/shared/perf/startup_perf_logger_test.dart`,
  `test/shared/widgets/adaptive_blur_test.dart`,
  `test/shared/widgets/app_shimmer_test.dart`

### Dependency shape

The perf helpers are already structurally isolated:

- they depend on Flutter foundation/scheduler primitives and `dart:developer`
- they do not import feature code
- `performance_policy.dart` only depends on `frame_timing_sampler.dart`

This makes them a clean candidate for a canonical move into `lib/core/perf/**`.

### Existing guard posture

`test/architecture/phase3_legacy_import_paths_test.dart` already blocks new
production imports of retired shared responsive, error, and result paths.
Nothing currently blocks new imports of `package:culcul/shared/perf/...`.

## Approaches

### Option A: Move canonical perf ownership to `lib/core/perf/**`, migrate all imports, delete the old shared paths

Create `lib/core/perf/**`, copy the canonical perf helpers there without API
changes, update every importer in `lib/**` and `test/**`, then delete
`lib/shared/perf/**` and extend the architecture guard to forbid the old import
paths.

Pros:

- finishes the perf ownership story in one slice
- keeps `lib/shared/**` from remaining a stealth canonical home
- gives a durable guard against regressions

Cons:

- touches around thirty importers in one change
- requires careful sequencing so the guard is added before the delete

### Option B: Move the canonical files to `lib/core/perf/**` but keep `lib/shared/perf/**` as compatibility exports

This lowers the immediate risk because the old paths can remain as temporary
shims, but it leaves the cleanup incomplete and guarantees another follow-up
plan just to delete the compatibility layer later.

### Option C: Expand into a broader infra slice (`shared/perf`, `shared/network`, `shared/pagination`)

This would address more ownership debt, but it is the wrong next step. The
import surface and blast radius become much larger, and the work stops being a
bounded architecture normalization slice.

## Recommendation

Use **Option A**.

Perf already has a clearly documented destination, a self-contained file set,
and a measurable import surface. It is large enough to matter, but still small
enough to keep reviewable if the work is sequenced as move -> import migration
-> guard -> delete.

## Approved Design

### 1. `lib/core/perf/**` becomes the only canonical perf home

Add `lib/core/perf/**` with the same public APIs and class names currently
exported from `lib/shared/perf/**`. This is an ownership move, not a behavior
rewrite.

### 2. Migrate every importer in the same slice

Update all production and test imports from:

- `package:culcul/shared/perf/...`

to:

- `package:culcul/core/perf/...`

This includes app bootstrap, shared infra consumers, shared widgets, feature
view models, and the focused perf/widget tests.

### 3. Extend the legacy import guard before deleting the old files

Add the retired perf paths to
`test/architecture/phase3_legacy_import_paths_test.dart` so production code
cannot reintroduce `package:culcul/shared/perf/...` imports once the migration
is complete.

### 4. Delete `lib/shared/perf/**` only after the working set reaches zero

The slice should use `rg -n "package:culcul/shared/perf/" lib test` as the
deletion gate. Once the result set is empty except for the guard test itself,
remove the old files from `lib/shared/perf/**`.

### 5. Update architecture docs after the code move is real

Document that perf is now canonical under `lib/core/perf/**` and that
`lib/shared/perf/**` has been retired.

## Constraints

- Do not change logger event names, payload formats, or sampling thresholds.
- Do not redesign `PerformancePolicy`.
- Do not combine this slice with `shared/network`, `shared/widgets`, or theme
  migration.
- Do not leave both canonical homes active at the end of the slice.

## Worktree Strategy

Use a dedicated worktree and branch:

- worktree: `.worktrees/core-perf-ownership`
- branch: `refactor/core-perf-ownership`

## Validation Expectations

Minimum validation for this slice:

- `flutter test test/architecture/phase3_legacy_import_paths_test.dart --reporter compact`
- `flutter test test/shared/perf/startup_perf_logger_test.dart --reporter compact`
- `flutter test test/shared/widgets/adaptive_blur_test.dart --reporter compact`
- `flutter test test/shared/widgets/app_shimmer_test.dart --reporter compact`
- `flutter test test/app/shell/main_shell_responsive_test.dart --reporter compact`
- `flutter analyze`

## Out of Scope

- moving generic shared widgets into `lib/ui/**`
- moving `shared/network/**` into `lib/core/**`
- pagination ownership redesign
- theme ownership cleanup
