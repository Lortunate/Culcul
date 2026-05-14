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

## Task 1: Archive Phase 27 And Planning Hygiene

- [ ] Mark Phase 27 spec as completed, move to `docs/specs/archive/2026-05-15-phase27-architecture-simplification.completed.md`.
- [ ] Mark Phase 27 plan as completed, move to `docs/plans/archive/2026-05-15-phase27-architecture-simplification.completed.md`.
- [ ] Update `CLAUDE.md` active pointers to Phase 28.
- [ ] Update `docs/architecture/architecture-guide.md` active phase reference.

## Task 2: Remove `uuid` Dependency

Target: Replace `package:uuid` with inline utility.

- [ ] Create `lib/core/utils/uuid_v4.dart` with a `generateUuidV4()` function using `Random.secure()`.
- [ ] Update `lib/features/notification/data/notification_repository_impl.message_send_service.dart` to use the new utility.
- [ ] Remove `uuid` from `pubspec.yaml`.
- [ ] Run `flutter pub get` and `flutter analyze`.

## Task 3: Remove `archive` Dependency

Target: Replace `GZipDecoder` from `archive` with `dart:io` `gzip.decode()`.

- [ ] Update `lib/core/utils/danmaku_mask_parser.dart`:
  - Replace `import 'package:archive/archive.dart'` with `import 'dart:io'`.
  - Replace `GZipDecoder().decodeBytes(data)` with `gzip.decode(data)`.
- [ ] Remove `archive` from `pubspec.yaml`.
- [ ] Run `flutter pub get` and `flutter analyze`.

## Task 4: Eliminate Trivial Alias Providers

Target: Remove 5 providers that are pure forwarding/aliases.

### 4a: Remove `searchDefaultHintProvider`

- [ ] Grep all usages of `searchDefaultHintProvider`.
- [ ] Replace with `defaultSearchProvider` at all call sites.
- [ ] Delete `lib/features/search/application/search_default_hint_provider.dart`.

### 4b: Remove `clearProfileCacheProvider`

- [ ] Grep all usages of `clearProfileCacheProvider`.
- [ ] Replace with direct `ref.read(profileCacheRepositoryProvider).clearAll()` at call sites.
- [ ] Delete `lib/features/profile/application/profile_cache_commands.dart`.

### 4c: Remove `logoutActionProvider`

- [ ] Grep all usages of `logoutActionProvider`.
- [ ] Replace with `ref.read(authProvider.notifier).logout()` at call sites.
- [ ] Remove from `lib/features/auth/application/auth_session_providers.dart`.

### 4d: Remove `searchPortProvider`

- [ ] Grep all usages of `searchPortProvider`.
- [ ] Replace with `searchRepositoryProvider` (or adjust type if needed).
- [ ] Delete `lib/features/search/application/search_port_provider.dart`.

### 4e: Remove `userCardProvider`

- [ ] Grep all usages of `userCardProvider`.
- [ ] Replace with direct repository call at call sites.
- [ ] Remove from `lib/features/profile/application/profile_session_providers.dart`.

### 4f: Verify

- [ ] Run `flutter analyze`.
- [ ] Verify no dangling imports.

## Task 5: Migrate Hand-Written Providers To @riverpod

Target: 4 providers that should use codegen.

### 5a: Migrate `relationPortProvider`

- [ ] Convert to `@Riverpod(keepAlive: true)` function in `lib/core/services/relation_service.dart`.
- [ ] Run `dart run build_runner build --delete-conflicting-outputs`.
- [ ] Verify `.g.dart` generated correctly.

### 5b: Migrate `networkQualityPolicy` providers

- [ ] Convert `_connectivityProvider` (inline or eliminate).
- [ ] Convert `networkQualityProfileProvider` to `@Riverpod(keepAlive: true)` Stream function.
- [ ] Convert `networkQualityPolicyProvider` to `@Riverpod(keepAlive: true)` function.
- [ ] Run build_runner.

### 5c: Migrate `watchLaterPortProvider`

- [ ] Convert to `@Riverpod(keepAlive: true)` function.
- [ ] Run build_runner.

### 5d: Migrate `userProfileInfoProvider`

- [ ] Convert to `@riverpod` family function (autoDispose by default).
- [ ] Run build_runner.

### 5e: Verify

- [ ] Run `flutter analyze`.
- [ ] Verify all generated files are correct.

## Task 6: Convert EndpointPolicy To Freezed

- [ ] Run impact analysis on `EndpointPolicy`.
- [ ] Add `@freezed` annotation and convert to freezed class.
- [ ] Remove hand-written `copyWith`.
- [ ] Run build_runner to generate `.freezed.dart`.
- [ ] Verify all usages still compile (the generated `copyWith` has the same signature).
- [ ] Run `flutter analyze`.

## Task 7: Convert Home/Ranking DTOs To Codegen

Target: `PopularResponseDto`, `WeeklyModelDto`, `FeedResponseDto` — hand-written `fromJson`.

### 7a: Convert `PopularResponseDto`

- [ ] Add `@JsonSerializable` annotation.
- [ ] Replace hand-written `fromJson` with generated `_$PopularResponseDtoFromJson`.
- [ ] Run build_runner.

### 7b: Convert `WeeklyModelDto`

- [ ] Same pattern as 7a.

### 7c: Convert `FeedResponseDto`

- [ ] Same pattern as 7a.

### 7d: Verify

- [ ] Run `flutter analyze`.
- [ ] Verify JSON parsing still works (field names, nested lists).

## Task 8: Remove Unnecessary Single-Export Feature Scope Files

Target: `feature_scope.dart` files that export only one symbol and provide no access-control value.

- [ ] Audit each feature_scope.dart:
  - `video/feature_scope.dart` (1 export)
  - `to_view/feature_scope.dart` (1 export)
  - `live/feature_scope.dart` (1 export)
- [ ] For each: check if the exported symbol is used by other features or only by the router.
- [ ] If only used by router: remove feature_scope.dart, update router import to source file.
- [ ] If used cross-feature: keep (it serves as access control).
- [ ] Run `flutter analyze`.

## Task 9: Refactor Notification Repository Helpers

Target: Break circular back-references. Make helpers independent services.

### 9a: Design dependency graph

- [ ] Define what each helper actually needs (from analysis):
  - `CleanupPolicy`: database, nowSeconds(), constants
  - `StreamWatchers`: database, constants
  - `LocalReadStore`: database, messageSendService, constants
  - `FeedSync`: database, nowSeconds(), cleanupPolicy, messageSendService
  - `SessionSync`: database, nowSeconds(), api, requestExecutor, cleanupPolicy, messageSendService
  - `MessageSync`: database, nowSeconds(), api, requestExecutor, cleanupPolicy, messageSendService
  - `MessageSendService`: database, nowSeconds(), api, dio, requestExecutor, sessionTypeFromReceiver()
    - Sub-helper `MessageSupport`: api, requestExecutor, constants
- [ ] Break the runtime cycle: `messageSendService.sendPrivateMessage()` calls `repo.syncMessagesHead()` which calls `messageSync` which calls back into `messageSendService`. Solution: extract the shared data-persistence methods from `messageSendService` into a separate `MessagePersistence` service that both `messageSync` and `messageSendService` depend on (no cycle).

### 9b: Extract `MessagePersistence` service

- [ ] Create `notification_message_persistence.dart` with methods: `upsertMessageDetail`, `upsertMessageEmojis`, `reconcileTemporaryMessages`, `putEmojiVariants`, `rowToPrivateMessage`.
- [ ] Dependencies: database, nowSeconds(), api (for emoji fetch).
- [ ] Move implementations from `messageSendService` mixin/helpers.

### 9c: Refactor helpers to accept explicit deps

- [ ] For each helper class:
  - Replace `final NotificationRepositoryImpl repo` with explicit typed dependencies.
  - Update constructor to accept individual deps.
  - Replace `repo.database` with `database`, `repo.api` with `api`, etc.
- [ ] Update `NotificationRepositoryImpl` to construct helpers with explicit deps.

### 9d: Break the sync cycle

- [ ] `MessageSendService.sendPrivateMessage()` currently calls `repo.syncMessagesHead()`.
- [ ] Replace with: accept a `SyncMessagesHead` callback in constructor, injected by the repository.
- [ ] Or: extract `syncMessagesHead` logic into `MessageSync` and have `MessageSendService` depend on `MessageSync` directly (one-way, no cycle because `MessageSync` now depends on `MessagePersistence` not `MessageSendService`).

### 9e: Register as Riverpod providers (optional)

- [ ] Evaluate: if helpers are only used within the repository, keep as plain classes instantiated by the repository with explicit deps (simpler).
- [ ] If any helper is needed outside the repository: register as Riverpod provider.

### 9f: Verify

- [ ] Run `flutter analyze`.
- [ ] Verify notification feature works: WebSocket connect, message sync, feed polling, message send.
- [ ] Run architecture guard tests.

## Task 10: Final Verification And Baseline Update

- [ ] Run full `flutter analyze` — must be clean.
- [ ] Run architecture guard tests.
- [ ] Run `gitnexus detect_changes` to verify scope.
- [ ] Update `docs/architecture/architecture-guide.md` with new baseline counts.
- [ ] Update `CLAUDE.md` if any architectural rules changed.
- [ ] Verify source file count reduced by ≥3.
- [ ] Verify dependency count reduced by ≥2.
- [ ] Commit all changes.

## Self-Review Checklist

- [ ] No new barrel files introduced.
- [ ] No new mutable globals introduced.
- [ ] No runtime call cycles in notification system.
- [ ] All architecture guards pass.
- [ ] `flutter analyze` clean.
- [ ] App builds for at least one platform.
- [ ] Source file count reduced.
- [ ] Dependency count reduced.
- [ ] No behavior changes to user-facing features.
