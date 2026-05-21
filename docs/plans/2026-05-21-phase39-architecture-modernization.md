# Phase 39 Architecture Modernization Plan

Tracking issue: `culcul-o9u`

> For agentic workers: use `superpowers:subagent-driven-development` or inline
> execution with review checkpoints when implementing independent slices. Do not
> use Markdown checkbox tracking in this repository; bd is the task tracker.

## Operating Rules

- Use Bash for shell commands.
- Use Context7 for current library/framework documentation.
- Use GitNexus impact analysis before editing any function, class, or method.
- Do not create empty services, managers, helpers, adapters, or facades.
- Do not keep old/new architecture side by side longer than the active slice.
- Preserve unrelated user changes in the dirty worktree.
- Run `gitnexus detect_changes` before committing.
- Session completion requires quality gates, bd status updates, `bd dolt push`,
  and `git push` per `AGENTS.md`.

## Current Problem Analysis

The active codebase already uses modern Flutter practices: Riverpod generated
providers, go_router, Dio/Retrofit, Freezed/JSON, Drift, Slang, and architecture
tests. The current complexity comes from incomplete consolidation rather than
missing frameworks.

Immediate baseline:

- `flutter analyze --no-pub`: 292 errors, mostly Dynamic model generated-file
  breakage after moving source files from `data/dtos` to `application/models`.
- `flutter test test/architecture/architecture_boundary_guard_test.dart`:
  passing.
- Dirty worktree: broad architecture moves are already present. Work must close
  the current move rather than restart it.

## Recommended Directory Structure

```text
lib/
  app/                 bootstrap, root app, router composition, shell
  core/                runtime contracts, network, storage, result/error, utils
  ui/                  shared design tokens, widgets, assemblies
  features/
    <feature>/
      route_entry.dart
      data/            APIs, DTOs, repository implementations
      application/     providers, workflows, read/view models
      domain/          real business entities and repository contracts
      presentation/    pages, view models, widgets
  i18n/
  protos/
```

## New Architecture Summary

- `app` composes and bootstraps; it should not own business rules.
- `core` contains cross-feature platform/runtime contracts and concrete shared
  infrastructure.
- `features` own their workflows. Cross-feature access goes through public route
  entries, core contracts, or an explicitly approved application/domain seam.
- `ui` is feature-agnostic.
- State remains Riverpod-first.
- Network remains `DioClient` plus repositories and `RequestExecutor`.
- DTOs, read models, and domain entities must not duplicate the same concept.

## Phase 1: Close Current Broken Move

Goal: restore analyzer health from the current Dynamic model move without
introducing a second model architecture.

Step 1: inspect the Dynamic model library.

Run:

```bash
flutter analyze --no-pub
```

Expected current failure: errors in
`lib/features/dynamic/application/models/dynamic_response.*`,
`dynamic_item_extensions.*`, and dependent Dynamic files.

Step 2: choose the first-phase model location.

Decision for this slice: keep the already moved Dynamic source files under
`features/dynamic/application/models` and move/regenerate their generated files
beside the library. A later DTO-classification slice can move transport DTOs
back to `data/dtos` if that proves clearer.

Step 3: close generated-file mismatch.

Move or regenerate:

- `lib/features/dynamic/data/dtos/dynamic_response.freezed.dart`
  to `lib/features/dynamic/application/models/dynamic_response.freezed.dart`
- `lib/features/dynamic/data/dtos/dynamic_response.g.dart`
  to `lib/features/dynamic/application/models/dynamic_response.g.dart`
- `lib/features/dynamic/data/dtos/emote_response.freezed.dart`
  to `lib/features/dynamic/application/models/emote_response.freezed.dart`
- `lib/features/dynamic/data/dtos/emote_response.g.dart`
  to `lib/features/dynamic/application/models/emote_response.g.dart`

Then run:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze --no-pub
```

Step 4: fix remaining imports created by the move.

Use analyzer errors to update import paths only. Do not rename concepts or add
facades.

Step 5: verify.

Run:

```bash
flutter analyze --no-pub
flutter test test/architecture/architecture_boundary_guard_test.dart
```

## Phase 2: Typed Navigation Cleanup

Goal: remove handwritten route strings while retaining go_router as the route
source of truth.

Files identified:

- `lib/features/history/presentation/pages/history_page.dart`
- `lib/features/to_view/presentation/pages/to_view_page.dart`
- `lib/features/notification/presentation/widgets/notification_category_grid.dart`

For each edited route call:

1. Run GitNexus impact analysis on the route class/helper being used.
2. Replace `context.push('/...')` with typed route calls or a feature
   `route_entry.dart` helper.
3. Run focused widget/view-model tests if present.
4. Run architecture guard.

## Phase 3: Dependency Hygiene

Goal: make dependency intent explicit without churn.

Actions:

- Keep `media_kit_libs_video` and `sqlite3_flutter_libs`; they are native runtime
  packages.
- Add direct `intl` if generated i18n files remain committed and import it.
- Do not remove packages based on import count alone.
- Do not upgrade major packages in the same slice as architecture moves.

Verification:

```bash
flutter pub get
flutter analyze --no-pub
```

## Phase 4: DTO And Entity Classification

Goal: one model source per concept.

Order:

1. Video `play_url`, `subtitle`, and danmaku models.
2. Dynamic `dynamic_response.*` and `emote_response.dart`.
3. Live `*_model.dart`.
4. Profile/history/to-view behaviorless domain entities.

Decision rule:

- Raw JSON transport shape: `data/dtos`.
- Feature read/view state: `application/models`.
- Cross-workflow business concept: `domain/entities`.
- Cross-feature contract: `core/contracts`.

## Phase 5: Endpoint Source Of Truth

Goal: remove endpoint duplication.

Actions:

- Inventory Retrofit annotation endpoint literals and `ApiConstants`.
- Decide per endpoint family whether Retrofit annotations or constants are the
  executable source.
- Delete duplicate constants that are not referenced.
- Keep `CommentService` shared reply endpoints centralized, as enforced by the
  architecture guard.

## Phase 6: App Boundary And Startup

Goal: reduce app-feature coupling and keep startup lean.

Actions:

- Move theme mode ownership out of `features/settings/application` only if a real
  app/runtime preference source can replace it without a wrapper-only facade.
- Keep network cache/cookie resources lazy unless a bootstrap test proves they
  are needed before first frame.
- Replace throwing provider defaults only with real safe defaults or explicit
  bootstrap wiring; do not add placeholder fallbacks.

## Delete, Merge, Archive Checklist

Already archived for this phase:

- Phase 38 active spec.
- Phase 38 active plan.

Delete during Phase 1:

- Old generated Dynamic files under `features/dynamic/data/dtos` after generated
  files exist under `features/dynamic/application/models`.

Merge/classify in later phases:

- DTO-shaped `application/models`.
- Behaviorless entities that are read models.
- Duplicate endpoint definitions.
- Cross-feature imports where a public seam already exists.

## First Phase Commands

```bash
flutter analyze --no-pub
dart run build_runner build --delete-conflicting-outputs
flutter analyze --no-pub
flutter test test/architecture/architecture_boundary_guard_test.dart
```

