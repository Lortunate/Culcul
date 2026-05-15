# Phase 31 Architecture Excellence Plan

Spec: `docs/specs/2026-05-16-phase31-architecture-excellence.md`

## Execution Rules

- Work in the clean `phase31-architecture-excellence-clean` worktree.
- Keep `app/` + `core/` + `features/` + `ui/`; do not reintroduce `shared/`.
- Prefer generated Riverpod (`@riverpod`) and Freezed 3 models when a generator removes real boilerplate.
- Do not create alias-only providers, barrel chains, or empty abstraction layers.
- Run architecture tests and analyzer after each completed slice when code changed.
- Use bd for follow-up issues; do not create markdown TODOs.

## Task 0: Re-establish Planning Source of Truth

**Files:**

- Create: `CLAUDE.md`
- Create/update: `docs/architecture/architecture-guide.md`
- Create: `docs/specs/2026-05-16-phase31-architecture-excellence.md`
- Create: `docs/plans/2026-05-16-phase31-architecture-excellence.md`

**Steps:**

1. Verify branch/worktree state.
2. Restore active architecture pointers to Phase 31.
3. Record that older Phase 22-30 docs remain historical and Phase 31 is the only active spec/plan.
4. Verify pointers with `rg -n "Phase 31|Active spec|Active plan" CLAUDE.md docs/architecture docs/specs docs/plans`.

## Task 1: Add Architecture Guard Baseline

**Files:**

- Inspect/update: `test/architecture/**`

**Steps:**

1. Inspect existing guard helpers and boundary tests.
2. Add or update tests for:
   - no `core/` or `ui/` imports from `features/`.
   - no new hand-written Riverpod provider declarations.
   - presentation-data imports are tracked by an explicit temporary allowlist.
3. Run `flutter test test/architecture --reporter compact`.

## Task 2: Settings and History Boundary Cleanup

**Files:**

- Modify: `lib/features/settings/**`
- Modify: `lib/features/history/**`
- Update tests if existing focused tests cover these features.

**Steps:**

1. Move settings repository access behind an application provider or generated notifier consumed by presentation.
2. Move history view-facing DTO use into a domain/view contract, or promote the existing data type if it is the single real model.
3. Remove direct `presentation -> data` imports for settings and history.
4. Run:
   - `flutter test test/architecture --reporter compact`
   - `flutter analyze --no-fatal-infos`

## Task 3: Live and Dynamic DTO Exposure Cleanup

**Files:**

- Modify: `lib/features/live/**`
- Modify: `lib/features/dynamic/**`

**Steps:**

1. Classify every live/dynamic presentation import from `data/dtos`.
2. For repeated UI contracts, introduce domain/view Freezed classes or extension mappers.
3. Keep socket/API DTOs inside data boundaries.
4. Run architecture tests and analyzer.

## Task 4: Notification Navigation and Persistence Separation

**Files:**

- Modify: `lib/features/notification/**`

**Steps:**

1. Split navigation-facing notification types away from storage DTOs.
2. Keep persistence code isolated under data/local or an equivalent data-only boundary.
3. Reduce `notification_repository_impl.dart` only when a split has a real responsibility name.
4. Run focused tests if present, then architecture tests and analyzer.

## Task 5: Large File Decomposition

**Files:**

- Candidate: `lib/features/video/presentation/player/controls/player_settings_sheet.options.dart`
- Candidate: `lib/features/video/presentation/comments/comment_reply_page.dart`
- Candidate: `lib/core/services/audio_handler.dart`
- Candidate: `lib/core/data/network/providers/wbi_helper_provider.dart`

**Steps:**

1. Pick the highest-value file based on responsibility boundaries, not line count alone.
2. Extract cohesive helpers/widgets/services with direct imports.
3. Avoid barrel-chain or re-export-only files.
4. Run analyzer and targeted tests.

## Task 6: Codegen and Dependency Source-of-Truth Closeout

**Files:**

- Inspect/update: `build.yaml`
- Inspect/update: `scripts/**`
- Inspect/update: `README.md` or architecture guide if command docs are needed.

**Steps:**

1. Confirm one source of truth for slang, build_runner, retrofit, riverpod, freezed, json_serializable, and drift generation.
2. Remove duplicate command paths or document the single sanctioned command.
3. Run the smallest safe generator command if source annotations changed.

## Verification

Run at closeout:

```bash
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
git status --short
```

If generated files are missing, run:

```bash
dart run slang
dart run build_runner build --delete-conflicting-outputs
```

Then rerun verification.

## Self-Review

- Spec coverage: tasks cover planning, guards, presentation-data cleanup, large files, codegen source of truth, and closeout.
- Placeholder scan: no placeholder tasks; each task has files, steps, and verification.
- Type consistency: Phase 31 docs and paths use the same date/slug.
