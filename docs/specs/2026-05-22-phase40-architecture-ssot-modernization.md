# Phase 40 Architecture SSOT Modernization Spec

Date: 2026-05-22

Tracking issue: `culcul-pe9`

This is the active design output for the next architecture refactor. It
supersedes Phase 39 as the decision record for this request. Phase execution
must still be tracked in `bd`; this document is the product/architecture spec,
not an issue tracker.

## Current Problem Analysis

The project is already on a modern Flutter stack: Riverpod 3 generated
providers, `go_router`/`go_router_builder`, Dio/Retrofit, Freezed/JSON, Drift,
Slang, and architecture guard tests. The biggest risk is not missing libraries;
it is boundary drift and duplicated ownership.

Verified baseline:

- `flutter analyze` reports no errors.
- `bash tool/architecture/run_architecture_guards.sh` exits 0.
- Handwritten Dart files under `lib`: 649.
- Feature code dominates handwritten source: 506 files under `lib/features`.
- Cross-feature imports found: 34.
- Feature imports of `app/router/app_routes.dart`: 42.
- Feature import of app bootstrap: 1.
- Presentation imports of concrete `data/*_impl.dart`: 32.
- Raw `MaterialPageRoute` usages: 6.
- `lib/shared` imports: 0.
- Runtime `TODO()` / `UnimplementedError`: 0.
- Manual Riverpod providers are effectively retired; generated `@riverpod`
  remains the state-management source of truth.

Primary problems:

1. Architecture documentation was not a single source of truth before this
   phase: active docs and guide references disagreed about the current phase.
2. Feature UI imports app route classes directly, creating cyclic ownership
   between feature modules and the app composition layer.
3. Some feature UI bypasses app-owned routing with raw `MaterialPageRoute`.
4. Cross-feature imports remain broad, especially session/auth access.
5. Presentation/view-model code still imports concrete data implementations.
6. DTO-shaped models leak into application models in video, dynamic, and live.
7. Network response decoding and error conversion have parallel paths.
8. API endpoint/config ownership is split between constants and literals.
9. Small low-value abstractions remain, such as `ErrorHandler` when it is only
   used by one UI widget.
10. Startup/media readiness policy leaks from `app/bootstrap` into live UI.

## Recommended Directory Structure

The top-level structure should stay shallow. Do not introduce empty layers or
folders that a feature does not need.

```text
lib/
  main.dart
  app/
    bootstrap/
    router/
    shell/
    overrides/
  core/
    contracts/
    data/
      network/
      storage/
    errors/
    result/
    session/
    media/
    runtime/
  features/
    <feature>/
      route_entry.dart
      <feature>.dart
      application/
        models/
        ports/
        providers/
        workflows/
      data/
        api/
        dtos/
        mappers/
        repositories/
      presentation/
        pages/
        widgets/
        view_models/
  ui/
    feedback/
    media/
    theme/
    widgets/
  i18n/
  protos/
```

Rules for optional folders:

- A feature may omit any folder that has no real code.
- `data/dtos` contains JSON/API shapes and generated serialization.
- `application/models` contains UI/use-case state and no `fromJson`.
- `application/ports` is allowed only when more than one caller benefits from
  the contract or when it breaks a real dependency cycle.
- `<feature>.dart` is allowed only for a real public API.
- `route_entry.dart` is the route-facing public seam for the feature.
- `core/session` exists only for cross-feature session state that is genuinely
  app-wide.

## New Architecture

The architecture is feature-first with app-owned composition:

- `app` owns startup, root overrides, typed router wiring, shell composition,
  and deferred initialization policy.
- `features` own product behavior. Feature internals may depend on `core` and
  `ui`, but not on `app` internals.
- Feature-to-feature access must be explicit through a public feature seam or a
  core contract when the concept is truly shared.
- `core` owns cross-feature runtime primitives only: network execution, error
  hierarchy, results, session state, media readiness, persistence, contracts,
  and performance policy.
- `ui` owns reusable widgets and theme primitives, not feature behavior.
- Generated code is authoritative for generated models/providers/routes.

Routing:

- App router remains the composition root.
- Feature UI must not import `app/router/app_routes.dart`.
- Raw `MaterialPageRoute` is not allowed in features.
- Same-feature route locations may be exposed from that feature's
  `route_entry.dart`.
- Cross-feature navigation must be triggered through app composition, explicit
  callbacks, or a narrow public route contract. Do not add a generic navigation
  service unless it removes a verified cycle.

State and data:

- Riverpod generated providers are the only provider style for new work.
- Widgets call notifier/view-model methods and do not hold business rules.
- Repositories return application-ready models or `Result<T, AppError>`.
- Generic network failure mapping belongs in `RequestExecutor` and `AppError`.
- Repeated `result.when(success: ..., failure: throw ...)` conversions must
  move to one shared adapter.

Performance:

- Keep first-frame bootstrap lean.
- Move heavyweight/deferred initialization behind idempotent core runtime
  providers or app bootstrap policies, not feature widget `build` methods.
- Review long-lived `keepAlive` providers and mutable global caches; keep only
  caches with measured product value.
- Avoid synchronous parsing or repeated computation in widget builds.

## Specs

Acceptance criteria:

1. Active architecture docs have one visible source of truth for Phase 40.
2. Architecture guide points to this spec and the Phase 40 plan.
3. Existing older phase documents are archived or clearly marked superseded.
4. Feature code has zero imports of `app/router/app_routes.dart`.
5. Feature code has zero imports of `app/bootstrap/**`.
6. Feature code has zero raw `MaterialPageRoute` route pushes.
7. Presentation code has zero imports of concrete `data/*_impl.dart`.
8. DTO classes with JSON serialization live under `data/dtos`.
9. Application models are JSON-free unless the feature has a documented reason.
10. Shared auth/session state has one public source of truth.
11. Generic network response decoding has one implementation path.
12. Generic error conversion has one implementation path.
13. API base URLs and shared endpoint constants have one source of truth.
14. Low-value one-use wrappers are deleted after callers migrate.
15. No new unused dependencies are introduced.
16. `flutter analyze` stays clean.
17. `bash tool/architecture/run_architecture_guards.sh` stays clean.
18. `flutter test` or focused tests pass for touched behavior.
19. GitNexus `detect_changes(scope: "all", repo: "Culcul")` is run before
    commit.

## Delete, Merge, Or Archive Inventory

Archive documentation, not dead runtime code:

- Archive or supersede Phase 39 docs after Phase 40 is accepted.
- Reconcile duplicate Phase 30 and Phase 32 archive variants.
- Add a documentation guard so active docs cannot reference missing active
  phase files or archived plans as current work.

Delete or merge runtime code after migration:

- Delete `lib/core/data/network/api_response_decoder.dart` after its behavior
  is merged into `RequestExecutor` or a private manual-Dio adapter.
- Delete `lib/core/errors/error_handler.dart` if `AppErrorWidget` remains its
  only caller.
- Delete application-level JSON DTO surfaces after moving them to `data/dtos`.
- Delete presentation-to-data allowlist entries as each feature is converted.
- Delete raw route pushes after converting them to app-owned typed routing.
- Delete compatibility shims immediately after callers move.

Do not keep old implementation code in `lib/archive`; archived implementation
code still affects search, ownership, and maintenance cost. If old behavior is
valuable as historical evidence, archive a short design note under `docs`.
