# Phase 28 Deep Simplification Plan

Spec: `docs/specs/phase28-deep-simplification.md`

## Ground Rules

- Execute one task at a time.
- Run GitNexus impact analysis before editing functions, classes, methods or provider symbols.
- Keep changes behavior-preserving.
- Run `flutter analyze` after each task.
- Do not add compatibility shims for old imports.
- Commit after each task with conventional commit format.

## Phase Map

- Task 1: Archive Phase 27 and planning hygiene.
- Task 2: Remove `uuid` dependency — inline UUID v4 utility.
- Task 3: Remove `archive` dependency — use `dart:io` GZipCodec.
- Task 4: Eliminate trivial alias providers.
- Task 5: Migrate hand-written providers to `@riverpod`.
- Task 6: Convert `EndpointPolicy` to freezed.
- Task 7: Convert home/ranking DTOs to codegen.
- Task 8: Remove unnecessary single-export feature_scope files.
- Task 9: Refactor notification repository helpers into independent services.
- Task 10: Final verification and baseline update.

---

## Task 1: Archive Phase 27 And Planning Hygiene ✓

- [x] Mark Phase 27 spec as completed, move to `docs/specs/archive/2026-05-15-phase27-architecture-simplification.completed.md`.
- [x] Mark Phase 27 plan as completed, move to `docs/plans/archive/2026-05-15-phase27-architecture-simplification.completed.md`.
- [x] Update `CLAUDE.md` active pointers to Phase 28.
- [x] Update `docs/architecture/architecture-guide.md` active phase reference.

## Task 2: Remove `uuid` Dependency ✓

Target: Replace `package:uuid` with inline utility.

- [x] Create `lib/core/utils/uuid_v4.dart` with a `generateUuidV4()` function using `Random.secure()`.
- [x] Update `lib/features/notification/data/notification_repository_impl.message_send_service.dart` to use the new utility.
- [x] Remove `uuid` from `pubspec.yaml`.
- [x] Run `flutter pub get` and `flutter analyze`.

## Task 3: Remove `archive` Dependency ✓

Target: Replace `GZipDecoder` from `archive` with `dart:io` `gzip.decode()`.

- [x] Update `lib/core/utils/danmaku_mask_parser.dart`:
  - Replace `import 'package:archive/archive.dart'` with `import 'dart:io'`.
  - Replace `GZipDecoder().decodeBytes(data)` with `gzip.decode(data)`.
- [x] Remove `archive` from `pubspec.yaml`.
- [x] Run `flutter pub get` and `flutter analyze`.

## Task 4: Eliminate Trivial Alias Providers ✓

Target: Remove 5 providers that are pure forwarding/aliases.

### 4a: Remove `searchDefaultHintProvider`

- [x] Grep all usages of `searchDefaultHintProvider`.
- [x] Replace with `defaultSearchProvider` at all call sites.
- [x] Delete `lib/features/search/application/search_default_hint_provider.dart`.

### 4b: Remove `clearProfileCacheProvider`

- [x] Grep all usages of `clearProfileCacheProvider`.
- [x] Replace with direct `ref.read(profileCacheRepositoryProvider).clearAll()` at call sites.
- [x] Delete `lib/features/profile/application/profile_cache_commands.dart`.

### 4c: Remove `logoutActionProvider`

- [x] Grep all usages of `logoutActionProvider`.
- [x] Replace with `ref.read(authProvider.notifier).logout()` at call sites.
- [x] Remove from `lib/features/auth/application/auth_session_providers.dart`.

### 4d: Remove `searchPortProvider`

- [x] Grep all usages of `searchPortProvider`.
- [x] Replace with `searchRepositoryProvider` (or adjust type if needed).
- [x] Delete `lib/features/search/application/search_port_provider.dart`.

### 4e: Remove `userCardProvider`

- [x] Grep all usages of `userCardProvider`.
- [x] Replace with direct repository call at call sites.
- [x] Remove from `lib/features/profile/application/profile_session_providers.dart`.

### 4f: Verify

- [x] Run `flutter analyze`.
- [x] Verify no dangling imports.

## Task 5: Migrate Hand-Written Providers To @riverpod ✓

Target: 4 providers that should use codegen.

### 5a: Migrate `relationPortProvider`

- [x] Convert to `@Riverpod(keepAlive: true)` function in `lib/core/services/relation_service.dart`.
- [x] Run `dart run build_runner build --delete-conflicting-outputs`.
- [x] Verify `.g.dart` generated correctly.

### 5b: Migrate `networkQualityPolicy` providers

- [x] Convert `_connectivityProvider` (inline or eliminate).
- [x] Convert `networkQualityProfileProvider` to `@Riverpod(keepAlive: true)` Stream function.
- [x] Convert `networkQualityPolicyProvider` to `@Riverpod(keepAlive: true)` function.
- [x] Run build_runner.

### 5c: Migrate `watchLaterPortProvider`

- [x] Convert to `@Riverpod(keepAlive: true)` function.
- [x] Run build_runner.

### 5d: Migrate `userProfileInfoProvider`

- [x] Convert to `@riverpod` family function (autoDispose by default).
- [x] Run build_runner.

### 5e: Verify

- [x] Run `flutter analyze`.
- [x] Verify all generated files are correct.

## Task 6: Convert EndpointPolicy To Freezed ✓

- [x] Run impact analysis on `EndpointPolicy`.
- [x] Add `@freezed` annotation and convert to freezed class.
- [x] Remove hand-written `copyWith`.
- [x] Run build_runner to generate `.freezed.dart`.
- [x] Verify all usages still compile (the generated `copyWith` has the same signature).
- [x] Run `flutter analyze`.

## Task 7: Convert Home/Ranking DTOs To Codegen ✓

Target: `PopularResponseDto`, `WeeklyModelDto`, `FeedResponseDto` — hand-written `fromJson`.

### 7a: Convert `PopularResponseDto`

- [x] Add `@JsonSerializable` annotation.
- [x] Replace hand-written `fromJson` with generated `_$PopularResponseDtoFromJson`.
- [x] Run build_runner.

### 7b: Convert `WeeklyModelDto`

- [x] Same pattern as 7a.

### 7c: Convert `FeedResponseDto`

- [x] Same pattern as 7a (with custom `JsonConverter` for dynamic list).

### 7d: Verify

- [x] Run `flutter analyze`.
- [x] Verify JSON parsing still works (field names, nested lists).

## Task 8: Remove Unnecessary Single-Export Feature Scope Files ✓

Target: `feature_scope.dart` files that export only one symbol and provide no access-control value.

- [x] Audit each feature_scope.dart:
  - `video/feature_scope.dart` (1 export)
  - `to_view/feature_scope.dart` (1 export)
  - `live/feature_scope.dart` (1 export)
- [x] For each: check if the exported symbol is used by other features or only by the router.
- [x] If only used by router: remove feature_scope.dart, update router import to source file.
- [x] If used cross-feature: keep (it serves as access control).
- [x] Run `flutter analyze`.

## Task 9: Refactor Notification Repository Helpers ✓

Target: Break circular back-references. Make helpers independent services.

### 9a: Design dependency graph

- [x] Define what each helper actually needs (from analysis):
  - `CleanupPolicy`: database, nowSeconds(), constants
  - `StreamWatchers`: database, constants
  - `LocalReadStore`: database, messageSendService, constants
  - `FeedSync`: database, nowSeconds(), cleanupPolicy, messageSendService
  - `SessionSync`: database, nowSeconds(), api, requestExecutor, cleanupPolicy, persistence
  - `MessageSync`: database, nowSeconds(), api, requestExecutor, cleanupPolicy, persistence
  - `MessageSendService`: database, nowSeconds(), api, dio, requestExecutor, persistence, messageSupport, syncMessagesHead callback
    - Sub-helper `MessageSupport`: api, requestExecutor, constants
- [x] Break the runtime cycle: extracted `MessagePersistence` service; `MessageSendService` receives `SyncMessagesHeadFn` callback instead of referencing repo/messageSync directly.

### 9b: Extract `MessagePersistence` service

- [x] Create `notification_message_persistence.dart` with methods: `upsertMessageDetail`, `upsertMessageEmojis`, `reconcileTemporaryMessages`, `putEmojiVariants`, `rowToPrivateMessage`.
- [x] Dependencies: database, nowSeconds(), api (for emoji fetch).
- [x] Move implementations from `messageSendService` mixin/helpers.

### 9c: Refactor helpers to accept explicit deps

- [x] For each helper class:
  - Replace `final NotificationRepositoryImpl repo` with explicit typed dependencies.
  - Update constructor to accept individual deps.
  - Replace `repo.database` with `database`, `repo.api` with `api`, etc.
- [x] Update `NotificationRepositoryImpl` to construct helpers with explicit deps.

### 9d: Break the sync cycle

- [x] `MessageSendService.sendPrivateMessage()` no longer calls `repo.syncMessagesHead()`.
- [x] Replaced with: `SyncMessagesHeadFn` callback in constructor, injected by the repository.

### 9e: Register as Riverpod providers (optional)

- [x] Evaluated: helpers are only used within the repository — kept as plain classes instantiated by the repository with explicit deps (simpler).

### 9f: Verify

- [x] Run `flutter analyze`.
- [x] Verify notification feature works: WebSocket connect, message sync, feed polling, message send.
- [x] Run architecture guard tests.

## Task 10: Final Verification And Baseline Update ✓

- [x] Run full `flutter analyze` — must be clean (277 info-level only, 0 errors/warnings).
- [x] Run architecture guard tests.
- [x] Run `gitnexus detect_changes` to verify scope.
- [x] Update `docs/architecture/architecture-guide.md` with new baseline counts.
- [x] Update `CLAUDE.md` if any architectural rules changed.
- [x] Verify source file count reduced by ≥3 (644→635 = -9 source files).
- [x] Verify dependency count reduced by ≥2 (uuid + archive removed).
- [x] Commit all changes.

## Self-Review Checklist

- [x] No new barrel files introduced.
- [x] No new mutable globals introduced.
- [x] No runtime call cycles in notification system.
- [x] All architecture guards pass.
- [x] `flutter analyze` clean (info-level only).
- [x] App builds for at least one platform.
- [x] Source file count reduced.
- [x] Dependency count reduced.
- [x] No behavior changes to user-facing features.
