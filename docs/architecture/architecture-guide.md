# Culcul Architecture Guide

Active phase: Phase 40 Architecture SSOT Modernization.

Authoritative docs:

- Active spec: `docs/specs/2026-05-22-phase40-architecture-ssot-modernization.md`
- Active plan: `docs/plans/2026-05-22-phase40-architecture-ssot-modernization.md`
- Superseded spec: `docs/specs/archive/2026-05-21-phase39-architecture-modernization.superseded.md`
- Superseded plan: `docs/plans/archive/2026-05-21-phase39-architecture-modernization.superseded.md`
- Superseded spec: `docs/specs/archive/2026-05-21-phase38-architecture-ssot-startup-performance.superseded.md`
- Superseded plan: `docs/plans/archive/2026-05-21-phase38-architecture-ssot-startup-performance.superseded.md`
- Superseded spec: `docs/specs/archive/2026-05-19-phase37-modern-architecture-consolidation.superseded.md`
- Superseded plan: `docs/plans/archive/2026-05-19-phase37-modern-architecture-consolidation.superseded.md`
- Superseded spec: `docs/specs/archive/2026-05-18-phase36-aggressive-architecture-cleanup.superseded.md`
- Superseded plan: `docs/plans/archive/2026-05-18-phase36-aggressive-architecture-cleanup.superseded.md`
- Superseded spec: `docs/specs/archive/2026-05-16-phase32-source-of-truth-consolidation.superseded.md`
- Superseded plan: `docs/plans/archive/2026-05-16-phase32-source-of-truth-consolidation.superseded.md`
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

Phase 40 may aggressively reorganize directories inside a feature. It must keep
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

Broad public barrels are retired. Import source files directly. `feature_scope.dart`
is retired in the current baseline; reintroduce it only if a later plan names a
concrete runtime composition seam.

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
- approved broad public barrels: none.
- generated files are excluded from source-debt architecture guards by default;
  generated verification remains explicit.
- generated Dart is ignored by default and restored with
  `bash scripts/bootstrap_codegen.sh`; checked-in generated exceptions are
  allowlisted only when needed for bootstrap/runtime/protobuf availability
  before codegen.
- `feature_scope.dart` files: 0.
- `pubspec.yaml` direct dependencies are all imported, generated/tooling-backed,
  or platform/runtime-backed. `riverpod` and `fixnum` are directly imported by
  source/generated source; `flutter_launcher_icons`, `media_kit_libs_video`,
  and `sqlite3_flutter_libs` are retained with evidence.

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

### Phase 38 Planning Baseline

- `lib/` source Dart files: 642.
- `lib/` generated Dart files: 235.
- `lib/` total Dart files: 877.
- cross-feature private `data/**` or `presentation/**` imports: 0.
- cross-feature `domain/**` or `application/**` imports found by planning audit: 34.
- non-data imports of feature `data/dtos`: 77.
- Phase 30 cross-feature application/domain inventory remains archived guard evidence: `docs/architecture/archive/2026-05-21-phase30-application-seam-inventory.superseded.md`.
- Phase 30 presentation data/proto inventory remains archived baseline evidence: `docs/architecture/archive/2026-05-21-phase30-presentation-data-inventory.superseded.md`.

### Phase 30 Completion Baseline

- `lib/` source Dart files: 640.
- `lib/` generated Dart files: 241.
- `lib/` total Dart files: 881.
- cross-feature private `data/**` or `presentation/**` imports: 0.
- cross-feature `domain/**` or `application/**` imports classified: 27.
- cross-feature application imports moved behind feature public APIs: 3.
- Phase 30 cross-feature application/domain inventory: `docs/architecture/archive/2026-05-21-phase30-application-seam-inventory.superseded.md`.
- Phase 30 presentation data/proto inventory: `docs/architecture/archive/2026-05-21-phase30-presentation-data-inventory.superseded.md` (118 same-feature feature-data/proto hits; classified, not banned).
- `feature_scope.dart` files: 0.
- Completed focus: semantic seam cleanup, domain/data leak cleanup, presentation data/proto classification, app runtime seam alignment, codegen source-of-truth cleanup, large-file decomposition, no-op workflow cleanup.

### Phase 40 Current Baseline

- Active branch: `codex/phase40-route-entry-seams`.
- `lib/` source Dart files: 657.
- `lib/` generated Dart files: 241.
- `lib/` total Dart files: 898.
- Current source-shape scan: 108 model/entity/domain-shaped files, 42 DTO files,
  87 view-model files, 35 repository files, 16 provider files, and 9 contract
  files.
- Authored files with JSON transport markers: 84.
- Cross-feature direct imports found by the current audit: 32.
- Completed focus so far: media runtime moved behind `core/runtime`,
  route-entry guard baseline added, notification navigation ownership moved to
  feature application, and several DTO ownership patterns migrated under
  `culcul-ory`, including dynamic publish responses.
- Remaining focus: Profile route callback slice, DTO/domain mirror
  consolidation, network response/error consolidation, endpoint policy SSOT,
  and startup/runtime retention cleanup.

### Phase 27 Baseline (archived)

- `lib/` source Dart files: 644.
- `lib/` generated Dart files: 225.
- `lib/` total Dart files: 869.

Update this baseline when the next active phase is created or when the source/generated audit count changes.
