# Phase 39 Architecture Modernization Spec

Tracking issue: `culcul-o9u`

## Status

Active architecture spec for the current refactor. Phase 38 and earlier phase
documents are archived and must not be treated as competing current plans.

Current verification baseline:

- `flutter analyze --no-pub`: no issues.
- `flutter test test/architecture/architecture_boundary_guard_test.dart`: pass.
- `flutter test test/architecture/architecture_route_ownership_guard_test.dart`:
  pass.
- `lib/` has 881 Dart files, including 648 authored source files.
- Active top-level source split: `app`, `core`, `features`, `ui`, `i18n`,
  `protos`.
- `lib/shared` is absent and remains retired.
- Architecture scan found 0 core/ui imports of feature internals, 0 private
  feature-to-feature data/presentation imports, 0 runtime placeholders, 0 raw
  string route pushes, and 0 handwritten Riverpod provider declarations.

## Current Problem Analysis

The project already uses a modern Flutter stack: Riverpod 3 generated providers,
go_router/go_router_builder, Dio/Retrofit, Freezed/JSON, Drift, Slang, and
architecture guard tests. The correct direction is consolidation, not a second
architecture or a wholesale package rewrite.

Primary problems that remain:

1. Historical architecture inventory documents were still visible in the active
   architecture directory even though they are baseline evidence, not active
   design.
2. Model ownership is not fully classified. Some DTO-shaped files live in
   `application/models`, and some behaviorless read models still live under
   `domain/entities`.
3. Endpoint ownership still needs a single source of truth between
   `ApiConstants` and Retrofit annotation literals.
4. Startup and global resource lifetime should keep first-frame work small and
   move cache/cookie/network work to deferred initialization where possible.
5. Some `service`, `helper`, and `utils` names still need review. They must be
   kept only when they own real policy or shared behavior.
6. The dependency tree has known drift and one discontinued transitive/file-store
   package path, but dependency upgrades must be isolated from architecture
   moves.

## Recommended Directory Structure

Keep the current top-level structure and tighten ownership inside it:

```text
lib/
  main.dart
  app/
    app.dart
    bootstrap/
    runtime/
    router/
    shell/
  core/
    bootstrap/
    contracts/
    data/
      network/
      pagination/
      storage/
    errors/
    feedback/
    perf/
    services/
    session/
    utils/
  ui/
    assemblies/
    components/
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

Ownership rules:

- `data/dtos` owns transport and persistence shapes.
- `application/models` owns feature read models, commands, workflow state, and
  view data that are not raw transport DTOs.
- `domain/entities` is only for concepts with business behavior or stable
  business meaning across workflows.
- `core/contracts` is the only shared contract model location.
- `route_entry.dart` is the route-facing public seam for a feature.
- `core` and `ui` never import `features`.

## New Architecture

The architecture is feature-first with a small app shell:

- `main.dart` performs framework startup and delegates app-specific initialization
  to `AppBootstrap`.
- `app` owns bootstrap, root overrides, typed route composition, and the root
  `MaterialApp.router`.
- `core` owns cross-feature runtime policy: errors, result handling, network
  execution, storage/bootstrap resources, contracts, session seams, feedback,
  and performance utilities.
- `features/<feature>` owns feature APIs, repositories, generated providers,
  workflows, feature state, pages, view models, and widgets.
- `ui` owns reusable visual primitives and assemblies with no business imports.

Network and error handling source of truth:

- `DioClient`, `RequestExecutor`, `AppError`, and `Result` remain the shared
  network policy.
- Feature repositories map feature DTOs and contracts, but do not duplicate
  generic Dio error handling.

State source of truth:

- Riverpod generated `@riverpod` providers remain the default.
- Widgets invoke notifier/workflow methods and do not duplicate business logic.
- No new handwritten provider globals, placeholder providers, or compatibility
  shims are allowed.

Performance source of truth:

- First-frame startup stays minimal.
- Cache, cookie, and network resource warmup belongs in deferred initialization
  unless required to render the first frame.
- Large lists use builder/lazy patterns, and provider watches should be scoped as
  deeply as practical.

## Specs

Phase 39 succeeds when:

1. Only the Phase 39 spec/plan and `architecture-guide.md` are active current
   architecture documents.
2. Superseded architecture inventories and plans are archived, not mixed with the
   active design.
3. Analyzer and architecture guards remain green after every executable slice.
4. Each shared model, state, endpoint rule, and network error policy has one
   authoritative source.
5. DTO-shaped, read-model-shaped, and domain-entity-shaped files are classified
   by behavior and ownership, not by old folder history.
6. No empty facade, manager, helper, service, adapter, or compatibility shim is
   introduced.
7. No dead code is kept for possible future use.
8. Dependency changes are isolated, justified, and verified; major upgrades are
   not mixed with structural refactors.
9. Any symbol-level code edit is preceded by GitNexus upstream impact analysis.
   HIGH or CRITICAL impact must be reported before editing.

## Delete, Merge, Archive List

Already archived:

- Phase 38 spec and plan.
- Older completed or superseded Phase 22-38 architecture specs and plans.

Archive in this phase:

- `docs/architecture/phase30-application-seam-inventory.md` to
  `docs/architecture/archive/2026-05-21-phase30-application-seam-inventory.superseded.md`.
- `docs/architecture/phase30-presentation-data-inventory.md` to
  `docs/architecture/archive/2026-05-21-phase30-presentation-data-inventory.superseded.md`.

Merge or classify in later executable slices:

- DTO-shaped files under `features/*/application/models`.
- Behaviorless read models under `features/*/domain/entities`.
- Endpoint definitions duplicated between `ApiConstants` and Retrofit APIs.
- Service/helper/utils files that do not own meaningful policy.

Retain:

- Current Riverpod/go_router/Dio/Retrofit/Freezed/Drift/Slang stack.
- Native runtime packages that are intentionally not imported from Dart code.
- Protobuf generated files needed by runtime/protobuf availability.

## First-Phase Refactor Steps

1. Update Phase 39 spec/plan to the verified current baseline.
2. Archive Phase 30 inventory documents and update active references to the
   archive paths.
3. Run the architecture boundary guard and route ownership guard.
4. Run `flutter analyze --no-pub`.
5. Run GitNexus `detect_changes` before commit to verify affected scope.

## Acceptance Criteria

- Active architecture docs no longer present archived inventories as current
  design.
- Analyzer and focused architecture tests pass.
- No new dependency, layer, facade, placeholder, or compatibility API is added.
- Follow-up work remains tracked in `bd`, not markdown task lists.
