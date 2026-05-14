# Culcul Architecture Guide

Active phase: Phase 24 Architecture Source-of-Truth Consolidation.

Authoritative docs:

- Spec: `docs/specs/phase24-architecture-source-of-truth-consolidation.md`
- Plan: `docs/plans/phase24-architecture-source-of-truth-consolidation.md`

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

## Phase 24 Baseline

- `lib/` Dart files: 890.
- top-level counts: `app` 16, `core` 94, `features` 709, `i18n` 4, `protos` 2, `ui` 64.
- Riverpod-annotated provider source files: 90.
- placeholder provider/bootstrap/session files: 0.
- TODO/FIXME presentation files: 0.
- barrel-like files: 2 approved.
- `shared` imports: 0.

Update this baseline only when the active phase changes or when Task 2 replaces manual counts with an automated guard.
