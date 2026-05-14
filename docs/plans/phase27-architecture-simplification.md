# Phase 27 Architecture Simplification Plan

Spec: `docs/specs/phase27-architecture-simplification.md`

## Ground Rules

- Execute one task at a time.
- Run GitNexus impact analysis before editing functions, classes, methods, or provider symbols.
- Keep changes behavior-preserving.
- Run `flutter analyze` after each task.
- Do not add compatibility shims for old imports.
- Commit after each task with conventional commit format.

## Phase Map

- Task 1: Planning rollover and archive hygiene.
- Task 2: Remove dead infrastructure (EndpointConcurrencyLane, RequestExecutorBinding).
- Task 3: Remove pass-through application commands.
- Task 4: Rename CacheInterceptor for clarity.
- Task 5: Flatten bootstrap layer.
- Task 6: Simplify DeferredAppInitController.
- Task 7: Remove/gate verifyRootOverrides.
- Task 8: Clean up redundant dependencies.
- Task 9: Refactor notification repository helpers into independent services.
- Task 10: Final verification and baseline update.

## Task 1: Planning Rollover And Archive Hygiene

- [x] Archive Phase 26 active spec as completed.
- [x] Archive Phase 26 active plan as completed.
- [x] Create active Phase 27 spec.
- [x] Create active Phase 27 plan.
- [x] Update `CLAUDE.md` active pointers.
- [x] Update `docs/architecture/architecture-guide.md` active phase reference.

## Task 2: Remove Dead Infrastructure

Target: `EndpointConcurrencyLane` enum and `RequestExecutorBinding` mixin.

### 2a: Remove EndpointConcurrencyLane

- [x] Run impact analysis on `EndpointConcurrencyLane`.
- [x] Remove enum definition from `lib/core/data/network/endpoint_policy.dart`.
- [x] Remove `concurrencyLane` field from `EndpointPolicy` class.
- [x] Remove lane assignment in `_basePolicyFor`.
- [x] Verify no other references exist.
- [x] Run `flutter analyze`.

### 2b: Remove RequestExecutorBinding

- [x] Run impact analysis on `RequestExecutorBinding`.
- [x] Identify all repositories that use the mixin.
- [x] For each repository: replace `with RequestExecutorBinding` with a `RequestExecutor` field/parameter.
- [x] Replace `requestResult(...)` calls with `requestExecutor.run(...)`.
- [x] Replace `requestApiResult(...)` calls with `requestExecutor.runApi(...)`.
- [x] Replace `requestVoidResult(...)` calls with `requestExecutor.runUnit(...)`.
- [x] Delete `lib/core/data/network/request_executor_binding.dart`.
- [x] Run `flutter analyze`.

## Task 3: Remove Pass-Through Application Commands

Target: Application layer files that are pure delegation with no business logic.

- [ ] Audit `lib/features/favorites/application/favorite_folder_commands.dart` — confirm pure pass-through.
- [ ] If confirmed: move repository calls directly into the presentation layer (view model).
- [ ] Remove the commands file.
- [ ] Audit other features' application layers for similar pass-throughs.
- [ ] Run `flutter analyze`.

## Task 4: Rename CacheInterceptor

- [ ] Run impact analysis on `CacheInterceptor`.
- [ ] Rename class `CacheInterceptor` → `EndpointCacheOptionsInterceptor`.
- [ ] Rename file `cache_interceptor.dart` → `endpoint_cache_options_interceptor.dart`.
- [ ] Update all imports (likely only `dio_client.dart`).
- [ ] Run `flutter analyze`.

## Task 5: Flatten Bootstrap Layer

Target: Merge `BootstrapCoordinator` + `AppRuntime` + 3 mutable-global providers into a single flat bootstrap.

- [ ] Run impact analysis on `BootstrapCoordinator`, `AppRuntime`, `initializeCookieJar`, `initializeCacheStore`, `initializeStorage`.
- [ ] Modify `AppBootstrap.initialize()` to return `List<Override>` directly (cookie jar, cache store, shared prefs as `overrideWithValue`).
- [ ] Update `main()` to use the returned overrides in `ProviderScope`.
- [ ] Delete `lib/app/runtime/bootstrap_coordinator.dart`.
- [ ] Delete `lib/app/runtime/app_runtime.dart`.
- [ ] Simplify `lib/core/bootstrap/providers/cookie_jar_provider.dart` — remove mutable global, keep only the provider declaration.
- [ ] Simplify `lib/core/bootstrap/providers/cache_store_provider.dart` — same.
- [ ] Simplify `lib/core/bootstrap/providers/storage_provider.dart` — same.
- [ ] Ensure initialization order preserved: SharedPrefs → CookieJar → CacheStore.
- [ ] Run `flutter analyze`.
- [ ] Verify app starts correctly.

## Task 6: Simplify DeferredAppInitController

- [ ] Run impact analysis on `DeferredAppInitController`.
- [ ] If only one deferred task (MediaKit init): replace with `addPostFrameCallback` in `main()` or `AppBootstrap`.
- [ ] If `ensureMediaKitInitialized()` is called elsewhere: keep a minimal future-based guard (≤15 lines).
- [ ] Delete or reduce `lib/app/bootstrap/deferred_app_init.dart`.
- [ ] Run `flutter analyze`.

## Task 7: Remove/Gate verifyRootOverrides

- [ ] Run impact analysis on `verifyRootOverrides`.
- [ ] Wrap in `if (kDebugMode)` or remove entirely.
- [ ] Run `flutter analyze`.

## Task 8: Clean Up Redundant Dependencies

- [ ] Remove explicit `riverpod: ^3.2.1` from pubspec.yaml (re-exported by `hooks_riverpod`).
- [ ] Audit `crypto` usage: grep for `import 'package:crypto/`.
- [ ] Audit `pointycastle` usage: grep for `import 'package:pointycastle/`.
- [ ] If overlap confirmed (both used only for hashing): remove `pointycastle`, use `crypto`.
- [ ] If `pointycastle` used for AES/RSA (likely for WBI): keep both, document why.
- [ ] Run `flutter pub get` and `flutter analyze`.

## Task 9: Refactor Notification Repository Helpers

Target: Break circular back-references in notification data layer.

- [ ] Map current helper classes and their dependencies on the parent repo.
- [ ] For each helper, identify what it actually needs (api? database? dio? other helpers?).
- [ ] Convert helpers to independent classes with explicit constructor dependencies.
- [ ] Register each as a Riverpod provider (or keep as plain classes instantiated by the repository with explicit deps).
- [ ] Remove `repo` back-reference from all helpers.
- [ ] Keep `NotificationRepositoryImpl` as a facade but with injected helpers (no circular ref).
- [ ] Run `flutter analyze`.
- [ ] Verify notification feature still works (WebSocket connect, message sync, feed polling).

## Task 10: Final Verification And Baseline Update

- [ ] Run full `flutter analyze` — must be clean.
- [ ] Run architecture guard tests: `flutter test test/architecture/`.
- [ ] Run `gitnexus detect_changes` to verify scope.
- [ ] Update `docs/architecture/architecture-guide.md` with new baseline counts and removed patterns.
- [ ] Update `CLAUDE.md` if any architectural rules changed.
- [ ] Verify source file count reduced by ≥5.
- [ ] Commit all changes.

## Self-Review Checklist

- [ ] No new barrel files introduced.
- [ ] No new mutable globals introduced.
- [ ] All architecture guards pass.
- [ ] `flutter analyze` clean.
- [ ] App builds for at least one platform.
- [ ] Source file count reduced.
- [ ] No behavior changes to user-facing features.
