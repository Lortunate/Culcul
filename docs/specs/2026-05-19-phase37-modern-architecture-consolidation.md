# Phase 37 Modern Architecture Consolidation Spec

## Status

Active.

Tracking:

- Epic: `culcul-2fi`
- Core seam reduction: `culcul-de4`
- Network/error consolidation: `culcul-h21`
- DTO/state consolidation: `culcul-57b`
- Runtime performance cleanup: `culcul-dg8`

This is the only active architecture cleanup spec for Phase 37. Phase 36 and
the lingering Phase 32 active draft are superseded by this document.

## Current Problem Analysis

The project is already mostly organized by `app/`, `core/`, `features/`, `ui/`,
`i18n/`, and `protos/`, but the active docs and some code seams still show
older architecture decisions:

- Multiple active architecture docs existed at once: Phase 36 plus a stale
  Phase 32 source-of-truth draft.
- `lib/features/` dominates the codebase, but cross-feature calls are still
  sometimes routed through `core/contracts` and tiny adapters that only forward
  a method call.
- Some bootstrap providers are override-only global placeholders. They are
  acceptable only while they represent real startup-owned resources; they must
  not spread into feature-level compatibility layers.
- DTO/model/state files are concentrated in `video`, `dynamic`, `notification`,
  and `live`. Those features need explicit ownership and should not duplicate
  shared concepts in `core/contracts`.
- Generated files are large and should remain generated source of truth, not
  copied into handwritten model layers.
- Performance risk is mostly structural: unnecessary provider layers, broad
  watches in widgets, heavyweight startup ownership, and repeated mapping work
  around network/database boundaries.

## Target Directory Structure

```text
lib/
  main.dart
  app/
    bootstrap/          # startup-only async resource creation
    router/             # go_router route data and generated routes
    runtime/            # app lifecycle/runtime policy providers
    shell/              # root shell composition only
    app.dart            # MaterialApp.router root
  core/
    data/
      network/          # Dio, Retrofit, request execution, API response policy
      pagination/       # generic pagination primitives with behavior
    errors/             # AppError only
    feedback/           # user feedback primitives
    perf/               # logging/timing/profile tools
    result/             # Result only
    services/           # true platform/app services, not feature adapters
    session/            # session lifecycle primitives only
  features/
    <feature>/
      route_entry.dart  # feature route exports for app/router
      data/             # DTOs, mappers, local DB, repository implementation
      application/      # feature use cases/providers with business behavior
      presentation/     # pages, widgets, view models
  ui/
    theme/
    widgets/
    assemblies/
    responsive/
  i18n/
  protos/
```

No `shared/` directory. No feature-owned compatibility shims in `core/`.

## Architecture

- `app/` owns startup, root overrides, router, and app shell composition.
- `core/` owns only cross-feature primitives with real behavior or platform
  lifecycle value.
- `features/<feature>` owns its DTOs, repositories, state, UI, route entry, and
  feature workflows.
- Cross-feature access is allowed only when the dependency is a real product
  relationship and the import is explicit. Do not hide a one-call dependency
  behind an adapter unless it removes a real cycle or enforces a reusable
  contract.
- Riverpod source of truth is generated `@riverpod` providers. Mutable state is
  `Notifier` or `AsyncNotifier`. Widgets call notifier methods and should not
  host business logic.
- go_router source of truth is typed route data under `app/router` plus
  feature `route_entry.dart` files.
- Network source of truth is `RequestExecutor` + `AppError` + `Result`.
  Feature repositories should not duplicate generic Dio error mapping.
- Generated code is the source for generated types. Handwritten duplicate
  model layers must be merged or deleted.

## Delete, Merge, Or Archive List

Archive now:

- `docs/specs/2026-05-18-phase36-aggressive-architecture-cleanup.md`
- `docs/plans/2026-05-18-phase36-aggressive-architecture-cleanup.md`
- `docs/specs/phase32-source-of-truth-consolidation.md`
- `docs/plans/phase32-source-of-truth-consolidation.md`

First code cleanup candidates:

- Delete `lib/core/contracts/watch_later_port.dart`.
- Delete `lib/features/to_view/application/watch_later_adapter.dart`.
- Delete `lib/features/to_view/application/watch_later_port_provider.dart` and
  generated output after callers move.
- Replace the single caller in
  `lib/features/home/presentation/widgets/home_video_actions.dart` with direct
  use of `toViewListProvider.notifier.add`.
- Move `ToViewList` from `to_view/presentation/view_models` to
  `to_view/application` so cross-feature callers depend on an application
  boundary instead of another feature's presentation layer.

Next cleanup candidates after impact analysis:

- Review `lib/features/profile/application/profile_lookup_adapter.dart` and
  `lib/features/profile/application/profile_session_providers.dart`.
- Review `lib/features/auth/application/auth_session_adapter.dart` and
  `lib/features/auth/application/auth_session_providers.dart`.
- Review override-only startup providers under `lib/core/bootstrap/providers/`.
- Review DTO/model ownership in `video`, `dynamic`, `notification`, and `live`.

## Acceptance Criteria

- Exactly one active architecture spec and plan exist.
- Superseded architecture docs live in `docs/specs/archive` and
  `docs/plans/archive`.
- No compatibility shim remains after its callers move.
- Each shared concept has one source of truth.
- Code changes are preceded by GitNexus impact analysis.
- HIGH or CRITICAL impact edits stop before modification.
- `dart run build_runner build --delete-conflicting-outputs` is run when
  generated providers/routes change.
- Analyzer/tests/architecture guards pass or every blocker is documented with
  exact failing command and output summary.
