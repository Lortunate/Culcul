# Phase 32 Source-of-Truth Consolidation Implementation Plan

> For agentic workers: use `superpowers:subagent-driven-development` for
> implementation. Project tracking lives in bd, so numbered steps below are
> execution instructions, not markdown task tracking.

Goal: collapse duplicate architecture sources and keep the app on modern
Riverpod/provider boundaries with fewer wrappers.

Architecture: each slice removes one duplicate source, updates callers, runs
architecture guards, and closes the matching bd issue. Error hierarchy cleanup
comes first because feedback and service cleanup depend on it.

Tech stack: Flutter, Dart 3.10, Riverpod 3, go_router 17, Drift, Retrofit,
Freezed, json_serializable, build_runner, GitNexus, bd.

## Global Rules

1. Work in Git Bash.
2. Do not edit `AGENTS.md`, `CLAUDE.md`, or
   `.claude/skills/gitnexus/gitnexus-cli/SKILL.md` unless the user explicitly
   asks.
3. Before changing a symbol, run GitNexus impact for that exact symbol.
4. If impact is HIGH or CRITICAL, report risk before editing.
5. Use bd issue status as the only progress tracker.
6. Run `gitnexus_detect_changes(scope: "all")` before committing.
7. Run architecture tests after every implementation slice.

## Slice 0: Planning Documents

Tracking issue: `culcul-zpy`

Files:

- Create: `docs/specs/phase32-source-of-truth-consolidation.md`
- Create: `docs/plans/phase32-source-of-truth-consolidation.md`
- Create:
  `docs/architecture/archive/2026-05-16-phase30-application-seam-inventory.archived.md`
- Preserve: `docs/architecture/phase30-application-seam-inventory.md`

Steps:

1. Claim issue.

```bash
bd update culcul-zpy --claim --json
```

2. Add the spec and plan files.

3. Copy the Phase 30 inventory into the archive path, but keep the original in
   place because `architecture_boundary_guard_test.dart` still reads it.

4. Validate docs exist.

```bash
test -f docs/specs/phase32-source-of-truth-consolidation.md
test -f docs/plans/phase32-source-of-truth-consolidation.md
test -f docs/architecture/archive/2026-05-16-phase30-application-seam-inventory.archived.md
test -f docs/architecture/phase30-application-seam-inventory.md
```

Expected: all commands exit 0.

5. Close the planning issue after verification.

```bash
bd close culcul-zpy --reason "Phase 32 spec and plan created; Phase 30 inventory archived without breaking guard fixture." --json
```

## Slice 1: Merge AppException Into AppError

Tracking issue: `culcul-i2u`

Files to inspect before edits:

- `lib/core/errors/app_error.dart`
- Any file matching `rg "AppException|exceptions.dart" lib test`
- `lib/core/feedback/app_feedback.dart`
- `test/architecture/architecture_feedback_guard_test.dart`

Steps:

1. Claim issue.

```bash
bd update culcul-i2u --claim --json
```

2. Find symbols and imports.

```bash
rg -n "AppException|exceptions\\.dart|AppError" lib test
```

3. Run GitNexus impact before edits.

Targets:

- `AppError`
- `AppException` if present
- every `AppException` factory or constructor found by `rg`

4. Make `AppError` implement `Exception` if it does not already.

Expected shape:

```dart
sealed class AppError implements Exception {
  const AppError();
}
```

If `AppError` is already not sealed, keep its current sealed/base/final style
and add only `implements Exception`.

5. Replace `throw AppException...` and `Future.error(AppException...)` with the
equivalent `AppError` factory or constructor.

6. Delete `exceptions.dart` only after `rg "exceptions\\.dart|AppException" lib test`
   returns no authored references.

7. Run:

```bash
dart format lib test
flutter test test/architecture
flutter analyze --no-fatal-infos
```

8. Run GitNexus change detection.

```text
gitnexus_detect_changes(scope: "all")
```

9. Close issue if all gates pass.

```bash
bd close culcul-i2u --reason "AppError is the single app exception/error source." --json
```

## Slice 2: Inline Favorite Query Parameter Objects

Tracking issue: `culcul-8os`

Files to inspect before edits:

- File containing `FavoriteFolderListQuery`
- File containing `FavoriteFolderResourcesQuery`
- Favorites repository interface and implementation files.
- Favorites view models that construct those query objects.

Steps:

1. Claim issue.

```bash
bd update culcul-8os --claim --json
```

2. Locate query definitions and constructors.

```bash
rg -n "FavoriteFolderListQuery|FavoriteFolderResourcesQuery|favorite_queries" lib test
```

3. Run GitNexus impact on both query classes.

4. Replace repository method signatures with named parameters. Preserve current
   parameter names and types. Example target shape:

```dart
Future<Result<T>> loadFolders({
  required int mid,
  required int page,
  required int pageSize,
});
```

Use the actual return type and method names from the repository.

5. Update callers to pass named parameters directly.

6. Delete the query file and any generated parts after references are gone.

7. Run:

```bash
dart run build_runner build --delete-conflicting-outputs
dart format lib test
flutter test test/architecture
flutter analyze --no-fatal-infos
```

8. Run GitNexus change detection and close issue.

## Slice 3: Remove ToViewModelDto Business Logic

Tracking issue: `culcul-f47`

Files:

- `lib/features/to_view/data/dtos/to_view_model_dto.dart`
- `lib/features/to_view/domain/entities/to_view_entry.dart`
- `lib/features/to_view/data/to_view_mapper.dart`
- To-view repository and view model callers found by `rg`.

Steps:

1. Claim issue.

```bash
bd update culcul-f47 --claim --json
```

2. Locate duplicated behavior.

```bash
rg -n "hasProgress|progressRatio|ToViewModelDto|ToViewEntry" lib/features/to_view test
```

3. Run GitNexus impact on `ToViewModelDto`, `ToViewEntry`, `hasProgress`, and
   `progressRatio`.

4. Remove `hasProgress` and `progressRatio` from `ToViewModelDto`.

5. Ensure mapper passes raw DTO fields into `ToViewEntry`.

6. Ensure presentation reads progress behavior from `ToViewEntry`, not DTO.

7. Run:

```bash
dart run build_runner build --delete-conflicting-outputs
dart format lib test
flutter test test/architecture
flutter analyze --no-fatal-infos
```

8. Run GitNexus change detection and close issue.

## Slice 4: Flatten SearchTrendingKeyword

Tracking issue: `culcul-28y`

Files to inspect:

- Search DTO/entity files containing `SearchTrendingKeyword`.
- Search repository and search view models.

Steps:

1. Claim issue.

```bash
bd update culcul-28y --claim --json
```

2. Locate definitions and callers.

```bash
rg -n "SearchTrendingKeyword|TrendingItem|showName|label" lib/features/search test
```

3. Run GitNexus impact on `SearchTrendingKeyword` and `TrendingItem`.

4. Remove the one-to-one wrapper if it only renames `showName` to `label`.

5. Update callers to use `TrendingItem` directly or expose a UI label getter in
   the single surviving type.

6. Regenerate if the removed type uses Freezed/json_serializable.

7. Run architecture tests, analyze, GitNexus change detection, and close issue.

## Slice 5: Standardize ResourceApi Instantiation

Tracking issue: `culcul-xoe`

Files:

- `lib/core/data/network/resource_api_provider.dart`
- `lib/core/data/network/resource_api.dart`
- `lib/features/video/data/video_repository_impl.dart`
- `lib/features/video/data/danmaku_repository_impl.dart`

Steps:

1. Claim issue.

```bash
bd update culcul-xoe --claim --json
```

2. Locate direct constructors and providers.

```bash
rg -n "ResourceApi\\(|resourceApiProvider|basicResourceApiProvider" lib test
```

3. Run GitNexus impact on `ResourceApi`, `resourceApiProvider`, and
   `basicResourceApiProvider`.

4. Replace repository-local `ResourceApi(...)` construction with injected API
   instances from existing providers. Pick `resourceApiProvider` for authenticated
   endpoints and `basicResourceApiProvider` only where current policy requires a
   basic client.

5. Keep constructor parameters explicit so tests can still inject fakes.

6. Run architecture tests, analyze, GitNexus change detection, and close issue.

## Slice 6: Remove PageQuery And Stale Ranking Category Source

Tracking issue: `culcul-1iv`

Files:

- `lib/core/data/pagination/page_query.dart`
- `lib/features/ranking/presentation/models/ranking_category.dart`

Steps:

1. Claim issue.

```bash
bd update culcul-1iv --claim --json
```

2. Verify usage.

```bash
rg -n "PageQuery|rankingCategories\\b|rankingCategoriesV2" lib test
```

3. Run GitNexus impact on `PageQuery`, `rankingCategories`, and
   `rankingCategoriesV2`.

4. Delete `page_query.dart` only if it has no imports.

5. Delete `rankingCategories` only if all runtime code uses
   `rankingCategoriesV2`.

6. Run architecture tests, analyze, GitNexus change detection, and close issue.

## Slice 7: Rename Active Seam Inventory

Tracking: create a new bd issue discovered from `culcul-zpy` after Slices 1-6,
unless implementation reveals this is unnecessary.

Files:

- `test/architecture/architecture_boundary_guard_test.dart`
- `docs/architecture/phase30-application-seam-inventory.md`
- Proposed new active path:
  `docs/architecture/active-application-seam-inventory.md`

Steps:

1. Create and claim a bd issue.

```bash
bd create "Phase 32: Rename active application seam inventory" --description="Move the guard fixture from the phase-specific Phase 30 inventory path to an active architecture inventory path, preserving the classified seam table." -t task -p 2 --deps discovered-from:culcul-zpy --json
```

2. Run GitNexus impact on `main` in
   `test/architecture/architecture_boundary_guard_test.dart` before editing the
   guard test.

3. Move the active inventory to the new path and update the guard constant.

4. Run:

```bash
flutter test test/architecture/architecture_boundary_guard_test.dart
flutter test test/architecture
flutter analyze --no-fatal-infos
```

5. Run GitNexus change detection and close issue.

## Final Verification

After all selected slices:

```bash
bd ready --json
flutter test test/architecture
flutter test
flutter analyze --no-fatal-infos
git status --short
```

Expected:

- No architecture guard failures.
- No analyzer errors.
- Ready issues no longer include completed Phase 32 slices.
- Dirty files are only intentional Phase 32 files plus existing user-owned dirty
  files that were present before the work.
