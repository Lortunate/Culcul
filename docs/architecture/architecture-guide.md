# Culcul Architecture Guide

Active phase: Phase 25 Architecture Surface Reduction.

Authoritative docs:

- Spec: `docs/specs/phase25-architecture-surface-reduction.md`
- Plan: `docs/plans/phase25-architecture-surface-reduction.md`

## Current Shape

`lib/` is organized as:

- `app/`: app bootstrap, router, root composition, root overrides.
- `core/`: shared contracts, runtime policy, network/data infrastructure, persistence, services, errors, session abstractions.
- `features/`: feature-owned data/domain/presentation code.
- `ui/`: reusable UI primitives and approved UI public API.
- `i18n/`: localization generated/source files.
- `protos/`: protobuf-generated integration surface.

`lib/shared/` is retired and must not return.

## Hard Rules

- `core/` and `ui/` must not import `features/`.
- A feature must not import another feature's `data/**` or `presentation/**`.
- Every shared model has one definition in `core/contracts/`.
- DTOs belong in `data/dtos/`; domain entities exist only when they carry business behavior.
- Feature public seams must be narrow; do not export data or presentation internals without a proven cross-feature consumer.
- New or rewritten providers use Riverpod generated `@riverpod`.
- Mutable or async state uses generated `Notifier`/`AsyncNotifier`.
- `AppError` is the single app error hierarchy.
- `AppFeedback` is the app notification pattern.
- `DioClient` and `RequestExecutor` are the network policy path.
- No `UnimplementedError`/`TODO()` placeholders in runtime provider seams.

## Approved Public Seams

- `route_entry.dart`
- `feature_scope.dart`
- `<feature>.dart` when it exports a real feature API
- `lib/core/contracts/core_contracts.dart`
- `lib/ui/ui.dart`

Avoid new barrel files. Import source files directly unless the file is one of the approved public seams.

## Modernization Defaults

- Flutter: profile first, keep long lists lazy, reduce rebuild work, move heavy work off the UI thread, verify with focused tests or traces.
- Riverpod: prefer generated providers, `Notifier`, `AsyncNotifier`, and provider tests over hand-written provider wiring.
- Dio: prefer `BaseOptions`, explicit interceptor order, `CancelToken`, `QueuedInterceptor`, request `extra`, and lifecycle cleanup over custom duplicated network side channels.
- Dependencies: reuse current popular stack before adding new packages.
- Local architecture guard: `bash tool/architecture/run_architecture_guards.sh`

## Phase 25 Baseline

- `lib/` source Dart files: 643.
- `lib/` generated Dart files: 228.
- `lib/` total Dart files: 871.
- `lib/shared/` files: 0.
- provider/bootstrap/session placeholders: 0.
- cross-feature private `data/**` or `presentation/**` imports found by planning audit: 0.
- `core/` or `ui/` imports of `features/` found by planning audit: 0.
- placeholder provider/bootstrap/session files: 0.
- TODO/FIXME presentation files found by planning audit: 0.
- approved broad public barrels: `lib/core/contracts/core_contracts.dart`, `lib/ui/ui.dart`.
- generated files are excluded from source-debt architecture guards by default; generated verification remains explicit.

Update this baseline only when the active phase changes or when the source/generated audit count changes.
