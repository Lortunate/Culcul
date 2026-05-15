# Culcul Architecture Guide

Active phase: none. Last completed phase: Phase 29 Architecture Deep Cleanup.

Authoritative docs:

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

## Hard Rules

- `core/` and `ui/` must not import `features/`.
- A feature must not import another feature's `data/**` or `presentation/**`.
- Every shared model has one definition in `core/contracts/`.
- DTOs belong in `data/dtos/`; domain entities exist only when they carry business behavior.
- Feature public seams must be narrow; do not export data internals or declare executable symbols inside `feature_scope.dart`.
- New or rewritten providers use Riverpod generated `@riverpod`.
- Mutable or async state uses generated `Notifier`/`AsyncNotifier`.
- `AppError` is the single app error hierarchy.
- `AppFeedback` is the app notification pattern.
- `DioClient` and `RequestExecutor` (injected as a field, not via mixin) are the network policy path.
- No `UnimplementedError`/`TODO()` placeholders in runtime provider seams.

## Approved Public Seams

- `route_entry.dart`
- `feature_scope.dart`
- `<feature>.dart` when it exports a real feature API
- `lib/core/contracts/core_contracts.dart`
- `lib/ui/ui.dart`

Avoid new barrel files. Import source files directly unless the file is one of the approved public seams. `feature_scope.dart` must be export-only and source-owned: move providers, functions, typedefs, and command logic into the owning application or presentation file, then export that source.

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

### Phase 27 Baseline (archived)

- `lib/` source Dart files: 644.
- `lib/` generated Dart files: 225.
- `lib/` total Dart files: 869.

Update this baseline when the next active phase is created or when the source/generated audit count changes.
