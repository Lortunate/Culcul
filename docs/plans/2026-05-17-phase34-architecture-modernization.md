# Phase 34 Architecture Modernization Plan

Spec: `docs/specs/2026-05-17-phase34-architecture-modernization.md`

## Global Rules

- Use Git Bash on Windows.
- Use bd for issue state. Do not create separate markdown issue lists.
- Run GitNexus impact before editing any function, class, or method.
- Stop and report before editing HIGH or CRITICAL risk symbols.
- Keep generated files consistent with `dart run build_runner build`.
- Prefer generated Riverpod providers and `Notifier`/`AsyncNotifier` when state
  owns behavior.
- Do not add pass-through wrappers, alias providers, or new barrel files.
- Run `gitnexus_detect_changes(scope: "all")` before committing code changes.

## File Map

Active docs:

- `docs/specs/2026-05-17-phase34-architecture-modernization.md`
- `docs/plans/2026-05-17-phase34-architecture-modernization.md`

Archived docs:

- `docs/specs/archive/2026-05-16-phase31-architecture-excellence.superseded.md`
- `docs/plans/archive/2026-05-16-phase31-architecture-excellence.superseded.md`
- `docs/specs/archive/2026-05-17-phase33-architecture-consolidation.superseded.md`
- `docs/plans/archive/2026-05-17-phase33-architecture-consolidation.superseded.md`

Pointers:

- `CLAUDE.md`
- `docs/architecture/architecture-guide.md`

## Task 0: Activate Phase 34 Docs

**Issue:** `culcul-fgn`

**Files:**

- Create: `docs/specs/2026-05-17-phase34-architecture-modernization.md`
- Create: `docs/plans/2026-05-17-phase34-architecture-modernization.md`
- Move:
  - `docs/specs/2026-05-16-phase31-architecture-excellence.md`
  - `docs/plans/2026-05-16-phase31-architecture-excellence.md`
  - `docs/specs/phase33-architecture-consolidation.md`
  - `docs/plans/phase33-architecture-consolidation.md`
- Modify: `CLAUDE.md`
- Modify: `docs/architecture/architecture-guide.md`

- [x] Archive Phase 31 and Phase 33 docs as superseded.
- [x] Write the Phase 34 spec.
- [x] Write this Phase 34 plan.
- [x] Update active pointers in `CLAUDE.md`.
- [x] Update active pointers in `docs/architecture/architecture-guide.md`.
- [x] Verify:

```bash
rg -n "Active spec|Active plan|Phase 31 active|phase33-architecture-consolidation|2026-05-16-phase31" \
  CLAUDE.md docs/architecture docs/specs docs/plans
```

Expected:

- Active pointers name Phase 34.
- Phase 31 and Phase 33 hits are only in archived docs or historical text.

## Task 1: Decide Stale Worktree Branches

**Issue:** `culcul-bgr`

**Files:**

- Inspect only until decision:
  - old worktree branch `phase31-architecture-excellence-clean`
  - old worktree branch `phase8-boundary-cleanup`

- [x] Compare branch heads against `master`.
- [x] For each branch, choose one:
  - merge useful commits manually and run tests.
  - supersede branch with bd note explaining why it is stale.
- [x] Do not start code-heavy Phase 34 slices until this issue is closed or
  explicitly deferred.

Verification:

```bash
bd show culcul-bgr --json
git branch --contains 9b803d42
git branch --contains 44cd915
```

## Task 2: Consolidate Error And Query Models

**Issues:** `culcul-i2u`, `culcul-8os`, `culcul-f47`, `culcul-28y`, `culcul-1iv`

**Likely files:**

- `lib/core/errors/app_error.dart`
- `lib/core/errors/exceptions.dart`
- `lib/features/favorites/**`
- `lib/features/to_view/data/dtos/to_view_model_dto.dart`
- `lib/features/to_view/data/to_view_mapper.dart`
- `lib/features/search/**`
- `lib/features/ranking/presentation/models/ranking_category.dart`
- `lib/features/ranking/presentation/pages/ranking_page.dart`
- `test/architecture/architecture_boundary_guard_test.dart`

- [x] Run GitNexus impact for each edited symbol before changing code.
- [x] Replace `AppException` throws with `AppError` factories and delete the
  second hierarchy.
- [x] Inline favorite query parameter objects into named parameters.
- [x] Move `ToViewModelDto` business behavior into the mapper/domain owner.
- [x] Flatten `SearchTrendingKeyword` if it only mirrors another shape.
- [x] Delete retired pagination/ranking names after references are gone.

Verification:

```bash
rg -n "AppException|FavoriteFolderListQuery|FavoriteFolderResourcesQuery|PageQuery|rankingCategoriesV2|SearchTrendingKeyword" lib test
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

## Task 3: Standardize ResourceApi Ownership

**Issue:** `culcul-xoe`

**Likely files:**

- `lib/core/data/network/**`
- `lib/features/dynamic/data/dynamic_api.dart`
- `lib/features/dynamic/data/dynamic_repository_impl.dart`
- `lib/features/video/data/video_api.dart`
- `lib/features/video/data/video_repository_impl.dart`

- [x] Run GitNexus impact before editing each API constructor/provider.
- [x] Find all ad hoc `ResourceApi` construction.
- [x] Route construction through provider or constructor injection.
- [x] Keep endpoint constants in one owner.
- [x] Do not create a repository interface unless tests or runtime polymorphism
  need it.

Verification:

```bash
rg -n "ResourceApi\\(" lib --glob "*.dart" --glob "!*.g.dart"
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

## Task 4: Split Oversized Mixed-Responsibility Files

**Issue:** `culcul-878`

**Initial candidates:**

- `lib/features/notification/data/notification_repository_impl.dart`
- `lib/features/video/presentation/detail/video_detail_view_model.dart`
- `lib/features/video/presentation/comments/video_comments_view_model.dart`
- `lib/features/video/data/video_repository_impl.dart`
- `lib/features/live/presentation/view_models/live_socket_service.dart`
- `lib/core/services/audio_handler.dart`
- `lib/core/services/comment_service.dart`

- [x] Pick one candidate per commit.
- [x] Run GitNexus impact for the edited class or method.
- [x] Extract behavior only when the new file has one clear responsibility.
- [x] Keep imports direct.
- [x] Do not add a part file or wrapper just to shrink line count.

Verification:

```bash
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

## Task 5: Reduce Analyzer Info Debt

**Issues:** `culcul-xap`, `culcul-ojk`

**Files:**

- Any file reported by `flutter analyze --no-fatal-infos`.

- [x] Capture current analyzer info count.
- [x] Fix lints in small batches.
- [x] Do not weaken `analysis_options.yaml`.
- [x] Close duplicate analyzer-debt issue if `culcul-xap` and `culcul-ojk`
  track the same work.

Verification:

```bash
flutter analyze --no-fatal-infos
```

Expected:

- Analyzer exits 0.
- Info count decreases.
- No rule is disabled to hide debt.

## Phase Close

- [ ] Run:

```bash
dart run build_runner build
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
gitnexus_detect_changes(scope: "all")
bd ready --json
```

- [ ] Close completed bd issues with concrete reasons.
- [ ] Commit and push.
