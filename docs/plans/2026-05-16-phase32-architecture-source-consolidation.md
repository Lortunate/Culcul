# Phase 32 Architecture Source Consolidation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove duplicate architecture truths, direct presentation-to-data coupling, zero-value wrappers, and mixed-responsibility files while preserving the modern Flutter/Riverpod/go_router/Freezed stack.

**Architecture:** Keep `app/` + `core/` + `features/` + `ui/`. Move app-facing state to `application/`, keep DTOs/persistence/API code in `data/`, use `domain/` only for real business concepts, and keep cross-feature contracts in `core/contracts/`.

**Tech Stack:** Flutter, hooks_riverpod 3, riverpod_annotation/generator, Freezed 3, go_router 17, go_router_builder, Retrofit, Dio, Drift, Slang, build_runner.

Spec: `docs/specs/2026-05-16-phase32-architecture-source-consolidation.md`

---

## Execution Notes

- Work in `E:/Projects/Flutter/Culcul/.worktrees/phase31-architecture-excellence-clean`.
- Use Git Bash.
- Do not touch the dirty root checkout or the separate `phase31-architecture-excellence` worktree unless the user explicitly asks.
- Do not add compatibility wrappers for old internal paths.
- Prefer deletion over aliasing when an abstraction has no behavior.
- Commit after each task if code changes are coherent and checks for that task pass.

## Task 0: Activate Phase 32 Docs

**Files:**

- Modify: `CLAUDE.md`
- Modify: `docs/architecture/architecture-guide.md`
- Move: `docs/specs/2026-05-16-phase31-architecture-excellence.md` to `docs/specs/archive/2026-05-16-phase31-architecture-excellence.superseded.md`
- Move: `docs/plans/2026-05-16-phase31-architecture-excellence.md` to `docs/plans/archive/2026-05-16-phase31-architecture-excellence.superseded.md`
- Create: `docs/specs/2026-05-16-phase32-architecture-source-consolidation.md`
- Create: `docs/plans/2026-05-16-phase32-architecture-source-consolidation.md`

- [ ] Move Phase 31 active docs into archive with `.superseded.md` suffix.
- [ ] Add a superseded banner to both archived Phase 31 files.
- [ ] Write the Phase 32 spec and plan.
- [ ] Update active pointers:

```text
Active spec: `docs/specs/2026-05-16-phase32-architecture-source-consolidation.md`
Active plan: `docs/plans/2026-05-16-phase32-architecture-source-consolidation.md`
Archived: Phase 22-31 specs/plans in `docs/specs/archive/` and `docs/plans/archive/`
```

- [ ] Run:

```bash
rg -n "Phase 32|Active spec|Active plan|phase31-architecture-excellence|phase32-architecture-source-consolidation" CLAUDE.md docs/architecture docs/specs docs/plans
git status --short
```

Expected:

- Phase 32 paths are active.
- Phase 31 active files no longer exist outside archive.

## Task 1: Add Architecture Debt Snapshot Guards

**Files:**

- Modify: `test/architecture/architecture_guard_utils.dart`
- Modify: `test/architecture/architecture_boundary_guard_test.dart`
- Create or modify: `test/architecture/phase32_architecture_source_guard_test.dart`
- Modify: `docs/architecture/architecture-guide.md`

- [ ] Add a helper that lists authored Dart files:

```dart
Iterable<File> authoredDartFiles(Directory root) sync* {
  for (final entity in root.listSync(recursive: true)) {
    if (entity is! File) continue;
    final path = entity.path.replaceAll('\\', '/');
    if (!path.endsWith('.dart')) continue;
    if (path.endsWith('.g.dart') || path.endsWith('.freezed.dart')) continue;
    yield entity;
  }
}
```

- [ ] Add a guard for presentation-to-data imports using this rule:

```dart
final illegal = authoredDartFiles(Directory('lib/features'))
    .where((file) => file.path.replaceAll('\\', '/').contains('/presentation/'))
    .where((file) => file.readAsStringSync().contains('/data/') ||
        RegExp(r"package:culcul/features/.+/data").hasMatch(file.readAsStringSync()))
    .map((file) => file.path.replaceAll('\\', '/'))
    .toList()
  ..sort();
```

- [ ] Add a temporary allowlist only for files proven too large for one slice. Each entry must include a comment with the planned task number.
- [ ] Add guards for:

```text
lib/shared has zero files
authored source has zero old-style hand-written provider declarations
feature presentation does not import another feature's data or presentation internals
```

- [ ] Run:

```bash
flutter test test/architecture --reporter compact
```

Expected:

- New guard either passes with a documented allowlist or fails with exact file paths before implementation.

## Task 2: Clean App Boundary and Auth Session Source

**Files:**

- Modify: `lib/app/app.dart`
- Modify: `lib/app/runtime/root_overrides.dart`
- Modify: `lib/features/auth/application/**`
- Modify: `lib/features/auth/presentation/**`
- Modify: `test/architecture/architecture_boundary_guard_test.dart`
- Modify: `test/architecture/phase32_architecture_source_guard_test.dart`

- [ ] Find app imports of feature internals:

```bash
rg -n "package:culcul/features/.+/(presentation|data)" lib/app --glob "*.dart"
```

- [ ] Replace app imports of presentation view models with app/core contracts or feature public application seams.
- [ ] Find auth application imports of presentation:

```bash
rg -n "features/auth/presentation" lib/features/auth/application --glob "*.dart"
```

- [ ] Split auth session state from login UI state:

```text
auth/application: session providers, session commands, auth repository coordination
auth/presentation: form state, page widgets, UI-only validation display
core/session: cross-feature session contract only if multiple features need it
```

- [ ] Update guards so app cannot import feature `presentation/**` or `data/**`.
- [ ] Run:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

Expected:

- `lib/app/**` has no feature presentation/data imports.
- `lib/features/auth/application/**` has no auth presentation imports.

## Task 3: Remove Direct Repository Access From Presentation

**Files:**

- Modify: `lib/features/favorites/presentation/**`
- Modify: `lib/features/favorites/application/**`
- Modify: `lib/features/to_view/presentation/**`
- Modify: `lib/features/to_view/application/**`
- Modify: `lib/features/settings/presentation/**`
- Modify: `lib/features/settings/application/**`
- Modify: `lib/features/history/presentation/**`
- Modify: `lib/features/history/application/**`
- Modify tests if existing focused tests cover these controllers.

- [ ] Find direct repository imports:

```bash
rg -n "features/.+/data/.+repository|RepositoryImpl|data/.+repository" lib/features/{favorites,to_view,settings,history}/presentation --glob "*.dart"
```

- [ ] For each direct repository call in presentation, move the call behind an `@riverpod` application controller or command.
- [ ] Use generated Riverpod APIs:

```dart
@riverpod
class ExampleController extends _$ExampleController {
  @override
  FutureOr<ExampleState> build() async {
    final repository = ref.watch(exampleRepositoryProvider);
    return repository.load();
  }
}
```

- [ ] Keep UI consumption as `ref.watch(exampleControllerProvider)` and render `AsyncValue` with `switch`.
- [ ] Delete old presentation view-model files if they only forwarded repository calls.
- [ ] Run:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

Expected:

- No presentation file in these features imports a repository implementation.
- Generated provider files are refreshed.

## Task 4: Move View-Facing DTO Use Behind Application or Domain Contracts

**Files:**

- Modify: `lib/features/live/**`
- Modify: `lib/features/profile/**`
- Modify: `lib/features/video/**`
- Modify: `lib/features/notification/**`
- Modify: `lib/core/contracts/**` only for cross-feature models.

- [ ] List DTO imports from presentation:

```bash
rg -n "package:culcul/features/.+/data/dtos" lib/features/{live,profile,video,notification}/presentation --glob "*.dart"
```

- [ ] For DTOs used only by one widget tree and matching transport exactly, map them in the application provider before UI sees them.
- [ ] For reusable view concepts, create a Freezed app-facing type in the owning feature:

```dart
@freezed
abstract class ExampleViewState with _$ExampleViewState {
  const factory ExampleViewState({
    required String title,
    required bool isActive,
  }) = _ExampleViewState;
}
```

- [ ] For cross-feature concepts, use or extend `core/contracts/`; do not create feature-local duplicates.
- [ ] Keep API response DTOs in `data/dtos/`.
- [ ] Remove mappers that only copy identical DTO fields into identical entity fields.
- [ ] Run:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

Expected:

- UI files in these features no longer import `data/dtos`.
- Remaining DTO exposure, if any, is listed in the Phase 32 guard allowlist with a task reference.

## Task 5: Consolidate Duplicate Contracts

**Files:**

- Modify: `lib/core/contracts/**`
- Modify: `lib/features/**/domain/**`
- Modify: `lib/features/**/data/*mapper*.dart`
- Modify: affected generated files through build_runner.

- [ ] Find duplicate concept names:

```bash
find lib/core/contracts lib/features -name "*.dart" ! -name "*.g.dart" ! -name "*.freezed.dart" \
  | sed 's#\\\\#/#g' \
  | xargs rg -n "class .*Video|class .*User|class .*Comment|class .*Relation|class .*Search|class .*Live"
```

- [ ] For each duplicate, choose one owner:

```text
core/contracts: shared by 2+ features
feature/domain or feature/application: feature-local app concept
feature/data/dtos: transport/storage shape only
```

- [ ] Replace duplicate imports with the chosen owner.
- [ ] Delete duplicate Freezed source and generated files after references are moved.
- [ ] Run:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

Expected:

- Every shared model has one source file.
- Mapper count decreases where models were identical.

## Task 6: Decompose Notification Data Cluster

**Files:**

- Modify: `lib/features/notification/data/notification_repository_impl.dart`
- Modify: `lib/features/notification/data/notification_message_persistence.dart`
- Modify: `lib/features/notification/data/notification_mapper.dart`
- Create: focused files under `lib/features/notification/data/` or `lib/features/notification/application/` only when names map to real responsibilities.

- [ ] Split navigation-facing parsing/state out of persistence/DTO code.
- [ ] Keep local storage details in data-only files.
- [ ] Keep repository implementation as orchestration, not parsing plus storage plus navigation.
- [ ] Keep mappers cohesive:

```text
DTO -> application/domain contract
local row -> application/domain contract
navigation payload -> application route state
```

- [ ] Run:

```bash
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

Expected:

- Notification presentation imports no notification data DTOs.
- Notification data files have single-purpose names.

## Task 7: Decompose High-Value UI and Service Files

**Files:**

- Modify: `lib/features/video/presentation/player/controls/player_settings_sheet.options.dart`
- Modify: `lib/features/video/presentation/comments/comment_reply_page.dart`
- Modify: `lib/core/services/audio_handler.dart`
- Modify: `lib/features/home/presentation/widgets/live_view.dart`
- Modify: `lib/features/home/presentation/widgets/recommend_view.dart`

- [ ] For each file, identify mixed responsibilities before editing:

```text
rendering
state binding
input parsing
side effects
formatting
navigation
```

- [ ] Extract only real responsibilities into sibling files.
- [ ] Keep widget files focused on composition and rendering.
- [ ] Move side effects into application commands/controllers when they call repositories or services.
- [ ] Run:

```bash
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

Expected:

- No extracted file is a barrel or alias wrapper.
- Existing UI behavior remains intact.

## Task 8: Delete Zero-Value Wrappers and Empty Symmetry Folders

**Files:**

- Modify/delete: `lib/features/**`
- Modify: `test/architecture/phase32_architecture_source_guard_test.dart`

- [ ] Find re-export-only files:

```bash
find lib -name "*.dart" ! -name "*.g.dart" ! -name "*.freezed.dart" -print0 \
  | xargs -0 awk 'FNR==1{file=FILENAME; count=0; exportOnly=1} {if ($0 !~ /^export / && $0 !~ /^library / && $0 !~ /^$/) exportOnly=0; count++} ENDFILE{if(exportOnly && count>0) print file}'
```

- [ ] Find typedef-only files:

```bash
rg -n "^typedef " lib --glob "*.dart" -g "!*.g.dart" -g "!*.freezed.dart"
```

- [ ] Inline imports to the real source file.
- [ ] Delete wrappers with no behavior.
- [ ] Delete empty folders after moves.
- [ ] Run:

```bash
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

Expected:

- Guard prevents new zero-wrapper files.

## Task 9: Consolidate Codegen Recovery Commands

**Files:**

- Modify: `README.md`
- Modify: `CLAUDE.md`
- Modify: `docs/architecture/architecture-guide.md`

- [ ] Keep one documented generated-code recovery path:

```bash
dart run slang
dart run build_runner build --delete-conflicting-outputs
```

- [ ] Document protobuf separately:

```text
`lib/protos/*.proto` is not regenerated by build_runner. If protobuf sources change, add an explicit protoc/protoc_plugin path before editing generated protobuf Dart files.
```

- [ ] Document that analyzer failures caused by missing generated files must list exact missing paths before changing architecture code.
- [ ] Remove duplicate/conflicting command descriptions.
- [ ] Run:

```bash
rg -n "build_runner|slang|generated|delete-conflicting-outputs" README.md CLAUDE.md docs/architecture docs/specs docs/plans
```

Expected:

- One clear recovery path.
- No conflicting generation instructions.

## Task 10: Final Verification and Closeout

**Files:**

- Modify: `docs/architecture/architecture-guide.md`
- Modify: `docs/specs/2026-05-16-phase32-architecture-source-consolidation.md`
- Modify: `docs/plans/2026-05-16-phase32-architecture-source-consolidation.md`

- [ ] Run final architecture snapshot:

```bash
rg -n "package:culcul/features/.*/data" lib/features --glob "*.dart"
rg -n "final .*Provider = (Provider|FutureProvider|StreamProvider|StateProvider|AsyncNotifierProvider)" lib --glob "*.dart" -g "!*.g.dart" -g "!*.freezed.dart"
find lib/shared -type f 2>/dev/null
```

- [ ] Run final gates:

```bash
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

- [ ] Update docs with actual final counts and any temporary allowlist.
- [ ] Close or update bd issues for work completed or deferred.
- [ ] Commit with a focused message:

```bash
git add CLAUDE.md docs README.md test lib
git commit -m "refactor(phase32): consolidate architecture sources"
```

Expected:

- active docs are Phase 32.
- architecture guard tests pass.
- analyzer either passes or has exact generated-file recovery notes.

## Self-Review

- Spec coverage: tasks cover active docs, guard baseline, presentation-data cleanup, contract consolidation, controller normalization, decomposition, wrapper deletion, codegen source of truth, and closeout.
- Placeholder scan: no TBD/TODO placeholders.
- Type consistency: Phase 32 docs and archive paths use the same date and slug.
