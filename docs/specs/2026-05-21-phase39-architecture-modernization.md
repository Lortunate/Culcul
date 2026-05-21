# Phase 39 Architecture Modernization Spec

Tracking issue: `culcul-o9u`

## Current Problem Analysis

The existing project already has a reasonable modern Flutter stack: Riverpod 3,
go_router with generated route support, Dio/Retrofit, Freezed/JSON, Drift, Slang,
and focused architecture guard tests. The highest-value refactor is therefore
not a package rewrite. The current problems are incomplete consolidation,
unclear ownership, and stale generated artifacts after recent large moves.

Observed baseline:

- `lib/` contains 879 Dart files: 647 source files and 232 generated files.
- `test/` contains 36 Dart test files.
- Largest source clusters are `features/video`, `features/dynamic`,
  `features/notification`, `features/profile`, `features/live`, and
  `features/search`.
- `flutter analyze --no-pub` currently reports 292 errors, concentrated in
  `features/dynamic/application/models`.
- Architecture boundary guard currently passes:
  `flutter test test/architecture/architecture_boundary_guard_test.dart`.
- The worktree is already dirty with broad architecture changes; this phase must
  close those moves instead of adding a parallel architecture.

Primary issues:

1. Dynamic model move is incomplete. Handwritten Dynamic DTO/model files were
   moved from `features/dynamic/data/dtos` into
   `features/dynamic/application/models`, but `dynamic_response.freezed.dart`,
   `dynamic_response.g.dart`, `emote_response.freezed.dart`, and
   `emote_response.g.dart` still live in the old `data/dtos` directory.
2. DTO/read-model ownership is inconsistent. Some response-shaped types live in
   `data/dtos`, some in `application/models`, and some behaviorless entities
   live in `domain/entities`.
3. App and feature boundaries still leak. `app/app.dart` consumes settings
   internals for theme state, and features still import other features'
   application/domain internals through approved but costly seams.
4. Router ownership is centralized in `app/router`, while feature route entries
   also exist. This creates two navigation concepts: typed app routes and public
   feature route seams.
5. Four handwritten string route pushes remain despite typed routes.
6. Endpoint source of truth is split between `ApiConstants` and Retrofit
   annotation literals.
7. Old architecture documents are already mostly archived, but the active Phase
   38 spec/plan is superseded by this phase and must not remain as a competing
   current plan.
8. Startup performance should keep first-frame work small. Network cache/cookie
   stores and heavyweight runtime resources should be lazy unless a test proves
   they are required before `runApp`.

## Recommended Directory Structure

Keep the current top-level split. It is familiar and maps well to the app.
Tighten ownership inside it:

```text
lib/
  main.dart
  app/
    app.dart
    bootstrap/
      app_bootstrap.dart
      deferred_app_init.dart
    router/
      app_routes.dart
      app_route_data.dart
      route_transitions.dart
      routes/
    runtime/
      root_overrides.dart
    shell/
  core/
    bootstrap/
      providers/
    constants/
    contracts/
    data/
      network/
    errors/
    result/
    runtime/
    session/
    storage/
    utils/
  ui/
    assemblies/
    theme/
    widgets/
  features/
    <feature>/
      route_entry.dart
      data/
        dtos/
        <feature>_api.dart
        <feature>_repository_impl.dart
      application/
        models/
        providers/
        view_data/
        workflows/
      domain/
        entities/
        repositories/
      presentation/
        pages/
        view_models/
        widgets/
  i18n/
  protos/
```

Use this structure pragmatically:

- `data/dtos` owns transport response/request shapes.
- `application/models` owns feature read models, view data, commands, and
  workflow state that are not raw transport shapes.
- `domain/entities` is only for concepts with business meaning across workflows,
  not a default folder for passive JSON records.
- `core/contracts` owns intentionally shared cross-feature contracts.
- `ui` owns feature-agnostic visual assemblies and widgets only.
- `app` composes the app, bootstraps runtime resources, and owns routing
  composition. It should avoid importing feature internals except route/public
  entry points.

## New Architecture

The target architecture is a small set of real sources of truth:

- State source of truth: generated Riverpod providers using `@riverpod`,
  `Notifier`, and `AsyncNotifier` where mutable or async state is needed.
- Network source of truth: `DioClient`, `RequestExecutor`, `AppError`, `Result`,
  and feature repositories. Avoid one-off error parsing and one-off Dio wrappers.
- Route source of truth: typed go_router route data and feature route entries.
  Raw string navigation is not allowed in feature UI.
- Model source of truth: one type per concept. Raw API shape, feature read model,
  and shared contract must not duplicate the same business rule.
- Endpoint source of truth: pick one per endpoint family. If Retrofit annotation
  literals remain the executable source, `ApiConstants` should not duplicate
  those same paths except for shared non-Retrofit service endpoints.
- Startup source of truth: `app/bootstrap` handles first-frame setup;
  `deferred_app_init` handles post-frame or lazy initialization.

## Specs

Phase 39 succeeds when:

1. Current active spec/plan is this Phase 39 pair; superseded Phase 38 docs are
   archived.
2. `flutter analyze --no-pub` no longer fails because generated files are in the
   wrong directory after the Dynamic model move.
3. The Dynamic model location is deliberate and documented: either the moved
   files stay in `application/models` with generated parts beside them, or they
   move back to `data/dtos` as transport DTOs. No split generated state remains.
4. String route pushes are replaced by typed route calls or narrow route-entry
   helpers.
5. Dependency hygiene is explicit: native zero-import packages are retained with
   justification, and generated i18n's `intl` use is either directly declared or
   removed from generated output.
6. Cross-feature imports are reduced only where a real shared contract/public
   seam exists; no empty facade/service/helper is introduced.
7. No dead compatibility layer is kept for older architecture names.
8. Architecture guard tests continue to pass.
9. Any symbol-level code edit is preceded by GitNexus impact analysis and any
   HIGH/CRITICAL result is reported before proceeding.

## Delete, Merge, Archive List

Archive now:

- `docs/specs/2026-05-21-phase38-architecture-ssot-startup-performance.md`
  to `docs/specs/archive/2026-05-21-phase38-architecture-ssot-startup-performance.superseded.md`.
- `docs/plans/2026-05-21-phase38-architecture-ssot-startup-performance.md`
  to `docs/plans/archive/2026-05-21-phase38-architecture-ssot-startup-performance.superseded.md`.

Delete after replacement:

- Stale generated Dynamic files in the old `features/dynamic/data/dtos` path
  after regenerated or moved generated files exist beside their source library.
- Raw string route pushes after typed navigation replacements land.
- Any obsolete import updates left by DTO/model moves.

Merge or classify:

- DTO-shaped files under `application/models`:
  `dynamic_response.*`, `emote_response.dart`, video `play_url/subtitle`,
  and live `*_model.dart`.
- Behaviorless `domain/entities` files that are only feature read models.
- Duplicate endpoint path definitions between `ApiConstants` and Retrofit APIs.

Retain:

- `media_kit_libs_video` and `sqlite3_flutter_libs`, because they provide native
  runtime libraries and are not expected to be imported from Dart code.
- Current Riverpod/go_router/Dio/Retrofit/Freezed/Drift/Slang stack, because it
  is mainstream and already in use.

## First-Phase Refactor Steps

The first executable slice is intentionally narrow:

1. Close the Dynamic generated-file mismatch.
2. Re-run `flutter analyze --no-pub` and record the new baseline.
3. Replace the four raw route pushes with typed routes.
4. Run the architecture guard test.
5. Add or justify `intl` dependency based on the committed i18n generated files.
6. Update remaining-work bd issues for broader DTO, endpoint, route ownership,
   and session seam consolidation.

