# Culcul Architecture Guide

Active phase: Phase 36 Aggressive Architecture Cleanup. Last completed phase: Phase 34 Architecture Modernization. Phase 35 was superseded before code execution.

Authoritative docs:

- Active spec: `docs/specs/2026-05-18-phase36-aggressive-architecture-cleanup.md`
- Active plan: `docs/plans/2026-05-18-phase36-aggressive-architecture-cleanup.md`
- Superseded spec: `docs/specs/archive/2026-05-17-phase35-architecture-simplification.superseded.md`
- Superseded plan: `docs/plans/archive/2026-05-17-phase35-architecture-simplification.superseded.md`
- Completed spec: `docs/specs/archive/2026-05-17-phase34-architecture-modernization.completed.md`
- Completed plan: `docs/plans/archive/2026-05-17-phase34-architecture-modernization.completed.md`
- Superseded spec: `docs/specs/archive/2026-05-17-phase33-architecture-consolidation.superseded.md`
- Superseded plan: `docs/plans/archive/2026-05-17-phase33-architecture-consolidation.superseded.md`
- Superseded spec: `docs/specs/archive/2026-05-16-phase31-architecture-excellence.superseded.md`
- Superseded plan: `docs/plans/archive/2026-05-16-phase31-architecture-excellence.superseded.md`
- Completed spec: `docs/specs/archive/2026-05-15-phase30-architecture-optimization.completed.md`
- Completed plan: `docs/plans/archive/2026-05-15-phase30-architecture-optimization.completed.md`
- Completed spec: `docs/specs/archive/2026-05-15-phase29-architecture-deep-cleanup.completed.md`
- Completed plan: `docs/plans/archive/2026-05-15-phase29-architecture-deep-cleanup.completed.md`

## Current Shape

`lib/` is organized as:

- `app/`: app bootstrap, router, root composition, root overrides.
- `core/`: shared contracts, runtime policy, network/data infrastructure, persistence, services, errors, session abstractions.
- `features/`: feature-owned data/domain/presentation code.
- `ui/`: reusable UI primitives and approved UI public API.
- `i18n/`: localization generated/source files.
- `protos/`: protobuf-generated integration surface.

`lib/shared/` is retired and must not return.

Phase 36 may aggressively reorganize directories inside a feature. It must keep
the top-level `app/`, `core/`, `features/`, and `ui/` boundary intact.

## Hard Rules

- `core/` and `ui/` must not import `features/`.
- A feature must not import another feature's `data/**` or `presentation/**`.
- Every shared model has one definition in `core/contracts/`.
- DTOs belong in `data/dtos/`; domain entities exist only when they carry business behavior.
- Feature public seams must be narrow; Phase 30 baseline has 0 `feature_scope.dart` files, so do not reintroduce them without a concrete approved runtime seam.
- New or rewritten providers use Riverpod generated `@riverpod`.
- Mutable or async state uses generated `Notifier`/`AsyncNotifier`.
- `AppError` is the single app error hierarchy.
- `AppFeedback` is the app notification pattern.
- `DioClient` and `RequestExecutor` (injected as a field, not via mixin) are the network policy path.
- No `UnimplementedError`/`TODO()` placeholders in runtime provider seams.
- No compatibility shims for removed internal APIs.

## Approved Public Seams

- `route_entry.dart`
- `<feature>.dart` when it exports a real feature API
- `lib/core/contracts/core_contracts.dart`
- `lib/ui/ui.dart`

Avoid new barrel files. Import source files directly unless the file is one of the approved public seams. `feature_scope.dart` is retired in the current baseline; reintroduce it only if a later plan names a concrete runtime composition seam.

## Modernization Defaults

- Flutter: profile first, keep long lists lazy, reduce rebuild work, move heavy work off the UI thread, verify with focused tests or traces.
- Riverpod: prefer generated providers, `Notifier`, `AsyncNotifier`, and provider tests over hand-written provider wiring.
- Dio: prefer `BaseOptions`, explicit interceptor order, `CancelToken`, `QueuedInterceptor`, request `extra`, and lifecycle cleanup over custom duplicated network side channels.
- Dependencies: reuse current popular stack before adding new packages.
- Local architecture guard: `bash tool/architecture/run_architecture_guards.sh`

## Phase 29 Completion Baseline

- `lib/` source Dart files: 636.
- `lib/` generated Dart files: 241.
- `lib/` total Dart files: 877.
- `lib/shared/` files: 0.
- Phase 29 provider tail target: 0 unnecessary hand-written providers remain.
- cross-feature private `data/**` or `presentation/**` imports found by final audit: 0.
- `core/` or `ui/` imports of `features/` found by planning audit: 0.
- placeholder/no-op grep matches found by final strict source audit: 0.
- duplicate model/DTO exact names found by final audit: 0.
- approved broad public barrels: `lib/core/contracts/core_contracts.dart`, `lib/ui/ui.dart`.
- generated files are excluded from source-debt architecture guards by default; generated verification remains explicit.
- `feature_scope.dart` files: 0.
- `pubspec.yaml` direct dependencies are all imported, generated/tooling-backed, or platform/runtime-backed. `riverpod` is directly imported by source, and `flutter_launcher_icons`, `media_kit_libs_video`, and `sqlite3_flutter_libs` are retained with evidence.

### Completed in Phase 28

- `uuid` dependency removed (replaced by inline `lib/core/utils/uuid_v4.dart`).
- `archive` dependency removed (replaced by `dart:io` GZipCodec).
- 5 trivial alias providers eliminated (`searchDefaultHintProvider`, `clearProfileCacheProvider`, `logoutActionProvider`, `searchPortProvider`, `userCardProvider`).
- 4 hand-written providers migrated to `@riverpod` codegen.
- `EndpointPolicy` converted to freezed.
- `PopularResponseDto`, `WeeklyModelDto`, `FeedResponseDto` converted to `@JsonSerializable` codegen.
- 3 unnecessary single-export `feature_scope.dart` files removed.
- Notification repository helpers refactored from mixin/god-object pattern to independent services with explicit dependency injection.
- `NotificationMessagePersistence` extracted as shared persistence service.
- `notification_repository_impl.message_send_helpers.dart` mixin deleted.
- Circular dependency in notification data layer broken via callback injection (`SyncMessagesHeadFn`).

### Phase 30 Completion Baseline

- `lib/` source Dart files: 640.
- `lib/` generated Dart files: 241.
- `lib/` total Dart files: 881.
- cross-feature private `data/**` or `presentation/**` imports: 0.
- cross-feature `domain/**` or `application/**` imports classified: 27.
- cross-feature application imports moved behind feature public APIs: 3.
- Phase 30 cross-feature application/domain inventory: `docs/architecture/phase30-application-seam-inventory.md`.
- Phase 30 presentation data/proto inventory: `docs/architecture/phase30-presentation-data-inventory.md` (118 same-feature feature-data/proto hits; classified, not banned).
- `feature_scope.dart` files: 0.
- Completed focus: semantic seam cleanup, domain/data leak cleanup, presentation data/proto classification, app runtime seam alignment, codegen source-of-truth cleanup, large-file decomposition, no-op workflow cleanup.

### Phase 27 Baseline (archived)

- `lib/` source Dart files: 644.
- `lib/` generated Dart files: 225.
- `lib/` total Dart files: 869.

Update this baseline when the next active phase is created or when the source/generated audit count changes.
