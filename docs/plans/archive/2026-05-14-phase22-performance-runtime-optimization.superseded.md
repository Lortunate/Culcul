> Superseded on 2026-05-14 by `docs/plans/phase24-architecture-source-of-truth-consolidation.md`.
> Completed Phase 22 tasks are preserved here for audit history; incomplete closeout work is folded into Phase 24 verification/config tasks.

# Phase 22 Performance Runtime Optimization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

Spec: `docs/specs/phase22-performance-runtime-optimization.md`

## Ground Rules

- Before editing any function, class, method, or provider symbol, run GitNexus impact analysis for that symbol and record risk in the task notes.
- If GitNexus returns HIGH or CRITICAL risk, stop and report before editing that symbol.
- Do not touch UI visuals except where required to reduce rebuilds, list work, image decode cost, or lifecycle work.
- Keep new shared code in `core/` or `ui/` only when it has no feature dependency.
- New Riverpod work uses `@riverpod` generated providers.
- New DTO/domain value objects use freezed when they carry app data.
- Do not add a new library unless the task says why the existing stack cannot cover the need.
- After each task, run the smallest useful verification gate, then update this checklist.

## Phase Map

- Task 1: Baseline and performance guardrails.
- Task 2: Runtime performance policy.
- Task 3: Network endpoint policy and Dio wiring.
- Task 4: Request execution and repository cleanup.
- Task 5: Cache policy and targeted Drift/domain cache.
- Task 6: UI list/image smoothness pass.
- Task 7: Timer/socket/video/wakelock power pass.
- Task 8: Build/platform/config cleanup.
- Task 9: Final verification and closeout.

## Task 1: Baseline and Guardrails

- [x] Create `docs/performance/phase22-baseline.md`.

  Include:

  - Flutter/Dart version.
  - Device/emulator used.
  - Debug/profile/release mode distinction.
  - Startup smoke result.
  - Home feed scroll smoothness notes.
  - Dynamic/notification list scroll notes.
  - Video playback and route-exit wakelock notes.
  - Network cold/warm request notes for home/profile/search.
  - Current verification command results.

- [x] Add focused test scaffolding without large product changes.

  Candidate files:

  - `test/core/data/network/network_quality_policy_test.dart`
  - `test/core/data/network/endpoint_policy_test.dart`
  - `test/core/runtime/runtime_performance_policy_test.dart`

  If directories do not exist, create them.

- [x] Add a profile/integration trace target only if the existing integration test setup supports it cleanly.

  Preferred file:

  - `integration_test/performance/home_scroll_perf_test.dart`

  Use Flutter `traceAction` to scroll a stable high-traffic list. Keep it opt-in; do not force it into normal `flutter test` CI unless runtime is cheap and stable.

  Task 1 result: no existing `integration_test/` setup was present, so this remains documented in the baseline instead of adding a brittle trace target now.

- [x] Verification:

  - `dart format --output=none --set-exit-if-changed .`
  - `flutter analyze`
  - `flutter test test/core/data/network test/core/runtime`

  Task 1 result:

  - `dart format --output=none --set-exit-if-changed .` reports 227 existing format changes.
  - `flutter analyze` reports 305 existing issues.
  - `flutter test test/core/data/network test/core/runtime --reporter compact` passes with 6 passing tests and 1 skipped endpoint-policy placeholder.

## Task 2: Runtime Performance Policy

- [x] Impact-analysis targets before editing:

  - `NetworkQualityPolicy`
  - `networkQualityPolicyProvider`
  - `AppBootstrap`
  - `AppRuntime`
  - any new provider consumers selected for migration

  Task 2 result: GitNexus returned `UNKNOWN` / target not found for `NetworkQualityPolicy`, `networkQualityPolicyProvider`, `AppBootstrap`, `AppRuntime`, and `PerformancePolicy`; graph query also returned no matching definitions. No HIGH/CRITICAL risk was reported.

- [x] Extend the existing policy model instead of creating a parallel one.

  Candidate files:

  - `lib/core/perf/performance_policy.dart`
  - `lib/core/perf/frame_timing_sampler.dart`
  - `lib/core/runtime/runtime_performance_policy.dart`

  Define:

  - `PerformanceProfile` with `interactive`, `balanced`, `constrained`, `background`.
  - `RuntimePerformancePolicy` with network prefetch budget, request concurrency class, timer behavior, cache stale allowance, and image prefetch allowance.
  - Pure factory methods that map frame timing, connectivity, and app lifecycle to a profile.
  - A compatibility bridge from current `PerformancePolicy` render-degrade levels to the new runtime policy.

- [x] Add generated providers.

  Candidate file:

  - `lib/core/runtime/runtime_performance_policy_provider.dart`

  Provider inputs:

  - `networkQualityProfileProvider`
  - app lifecycle provider from `app/runtime` or a new core runtime provider

- [x] Tests:

  - Fast connectivity + resumed lifecycle returns `interactive` or `balanced`.
  - Mobile/constrained connectivity lowers prefetch and concurrency.
  - Background lifecycle disables non-critical prefetch and polling.

- [x] Verification:

  - `dart run build_runner build --delete-conflicting-outputs`
  - `flutter test test/core/runtime/runtime_performance_policy_test.dart`
  - `flutter analyze`

  Task 2 result:

  - `dart run build_runner build --delete-conflicting-outputs` passed; current build_runner warns that `--delete-conflicting-outputs` is ignored.
  - `flutter test test/core/runtime/runtime_performance_policy_test.dart --reporter compact` passed with 7 tests.
  - `flutter test test/core/data/network test/core/runtime --reporter compact` passed with 6 passing tests and 1 skipped endpoint-policy placeholder.
  - `flutter analyze` reports 308 existing/project-wide info issues; filtered analyze output showed no issues in `lib/core/runtime` or `test/core`.

## Task 3: Endpoint Policy and Dio Wiring

- [x] Impact-analysis targets before editing:

  - `dioClientProvider`
  - `basicDioProvider`
  - `NetworkQualityPolicy`
  - `NetworkQualityInterceptor`
  - `CacheInterceptor`
  - `InFlightDedupInterceptor`
  - `RequestExecutor`

  Task 3 result: GitNexus returned `UNKNOWN` / target not found for all listed targets; no HIGH/CRITICAL risk was reported.

- [x] Add endpoint/request policy types.

  Candidate files:

  - `lib/core/data/network/endpoint_policy.dart`
  - `lib/core/data/network/endpoint_policy_provider.dart`

  Define:

  - request class: `interactiveRead`, `backgroundRead`, `mediaMetadata`, `search`, `auth`, `mutation`, `download`.
  - cache TTL and stale allowance.
  - retry max attempts and retryable status list.
  - dedup enabled flag.
  - concurrency lane.
  - unsafe-method retry default: false.

- [x] Refactor Dio setup to read policy centrally.

  Candidate files:

  - `lib/core/data/network/dio_client.dart`
  - `lib/core/data/network/interceptors/network_quality_interceptor.dart`
  - `lib/core/data/network/interceptors/cache_interceptor.dart`

  Requirements:

  - Keep Dio.
  - Keep `BaseOptions` global defaults.
  - Keep `dio_smart_retry`, but gate retries by endpoint policy and method safety.
  - Keep cache interceptor, but source TTL/stale behavior from endpoint policy.
  - Logging remains debug-only and last if present.

- [x] Tests:

  - GET retries according to policy.
  - POST does not retry by default.
  - Cache TTL resolves from endpoint policy.
  - Background/constrained policy lowers concurrency and disables prefetch.

- [x] Verification:

  - `flutter test test/core/data/network`
  - `flutter analyze`

  Task 3 result:

  - `dart run build_runner build --delete-conflicting-outputs` passed; current build_runner warns that `--delete-conflicting-outputs` is ignored.
  - `dart format --output=none --set-exit-if-changed` on Task 3 Dart files passed with 0 changes after formatting.
  - `flutter test test/core/data/network --reporter expanded` passed with 7 tests.
  - `flutter test test/core/data/network test/core/runtime --reporter expanded` passed with 14 tests.
  - `flutter analyze` reports 309 existing/project-wide info issues; filtered analyze output showed no issues in `lib/core/data/network`, `lib/core/runtime`, or `test/core`.

## Task 4: Request Execution and Repository Cleanup

- [x] Impact-analysis targets before editing:

  - `RequestExecutor`
  - `RequestExecutorBinding`
  - `AppError`
  - `AppException`
  - first migrated repository implementation

  Task 4 result: GitNexus returned `UNKNOWN` / target not found for `RequestExecutor`, `RequestExecutorBinding`, `AppError`, `AppException`, `SearchRepositoryImpl`, and `HomeRepositoryImpl`; no HIGH/CRITICAL risk was reported. `AppException` is not present at `lib/core/errors/app_exception.dart` in this checkout.

- [x] Extend `RequestExecutor` so repositories can express:

  - request class / endpoint policy key
  - cancellation token
  - cache policy override only when needed
  - app error mapping
  - optional stale-cache fallback

- [x] Migrate a low-risk repository first.

  Preferred first targets:

  - `lib/features/search/data/search_repository_impl.dart`
  - `lib/features/home/data/home_repository_impl.dart`

  Avoid auth and mutation-heavy code until request semantics are proven.

- [x] Remove duplicated catch/error mapping only inside migrated files.

  Do not broad-rewrite all `51` repository impls in one commit.

- [x] Tests:

  - migrated repository maps Dio failures through the shared executor.
  - cancellation returns the intended app error/result.
  - stale-cache fallback only triggers for opted-in read requests.

- [x] Verification:

  - targeted repository tests
  - `flutter analyze`

  Task 4 result:

  - `dart run build_runner build --delete-conflicting-outputs` passed; current build_runner warns that `--delete-conflicting-outputs` is ignored.
  - `dart format --output=none --set-exit-if-changed` on Task 4 Dart files passed with 0 changes after formatting.
  - `flutter test test/core/data/network test/core/runtime --reporter expanded` passed with 18 tests.
  - `flutter analyze` reports 303 existing/project-wide info issues; filtered analyze output showed no issues in Task 4 changed files.

## Task 5: Cache Policy and Targeted Durable Cache

- [x] Impact-analysis targets before editing:

  - `cacheStoreProvider`
  - `storageProvider`
  - existing profile/user cache repositories
  - notification Drift database only if reused or touched

  Task 5 result: GitNexus returned `UNKNOWN` / target not found for
  `UserInfoCacheRepository`, `ProfileCacheRepositoryImpl`,
  `userInfoCacheRepository`, `profileCacheRepository`, `createRootOverrides`,
  `Auth`, and `logout`; no HIGH/CRITICAL risk was reported. Notification Drift
  database was not reused or touched.

- [x] Document cache taxonomy in code comments or `docs/performance/phase22-cache-policy.md`.

  Keep it short:

  - HTTP cache: transport cache, short TTL, public/safe reads.
  - Domain cache: Drift, structured data, stale read allowed by feature.
  - Sensitive cache: invalidated on logout/session switch.

- [x] Pick one durable cache migration target.

  Recommended first target:

  - profile/user info cache currently stored as JSON blobs in `SharedPreferences`.

  Candidate files:

  - `lib/features/profile/data/profile_cache_repository.dart`
  - `lib/features/profile/data/user_info_cache_repository.dart`
  - new Drift table/database module under `lib/core/storage/` or feature-owned data storage if feature-specific

  Task 5 result: migrated profile/user info cache from `SharedPreferences` JSON
  blobs to feature-owned `ProfileCacheDatabase` under
  `lib/features/profile/data/local/`.

- [x] Add invalidation rules:

  - logout clears session-bound domain cache.
  - account switch clears or namespaces user-bound data.
  - schema migration has tests.

- [x] Tests:

  - warm read returns cached data.
  - stale read respects TTL.
  - logout/session invalidation clears sensitive rows.
  - migration opens cleanly.

- [x] Verification:

  - `dart run build_runner build --delete-conflicting-outputs`
  - Drift/cache tests
  - `flutter analyze`

  Task 5 result:

  - `dart run build_runner build --delete-conflicting-outputs` passed; current build_runner warns that `--delete-conflicting-outputs` is ignored.
  - `dart format --output=none --set-exit-if-changed` on Task 5 files passed with 0 changes after formatting.
  - `flutter test test/core/data/network test/core/runtime test/features/profile/data --reporter expanded` passed with 22 tests.
  - `flutter analyze` reports 304 existing/project-wide info issues; filtered analyze output showed no issues in Task 5 changed files.

## Task 6: UI List and Image Smoothness Pass

- [x] Impact-analysis targets before editing:

  - `AppNetworkImage`
  - `useScrollPrecache`
  - selected high-traffic list widgets
  - selected view models/providers watched by those widgets

  Task 6 result: GitNexus returned `UNKNOWN` / target not found for
  `AppNetworkImage`, `useScrollPrecache`, `RecommendView`, `PopularView`,
  `DynamicListView`, `NotificationListPage`, and `LiveDanmakuView`; no
  HIGH/CRITICAL risk was reported.

- [x] Audit and update high-traffic surfaces one group at a time.

  Candidate files:

  - `lib/ui/widgets/media/app_network_image.dart`
  - `lib/core/hooks/use_scroll_precache.dart`
  - `lib/features/home/presentation/widgets/recommend_view.dart`
  - `lib/features/home/presentation/widgets/popular_view.dart`
  - `lib/features/dynamic/presentation/widgets/dynamic_list_view.dart`
  - `lib/features/notification/presentation/pages/notification_list_page.dart`
  - `lib/features/live/presentation/widgets/live_danmaku_view.dart`

- [x] Required changes:

  - preserve lazy builders for large collections.
  - add stable keys where item identity is stable.
  - ensure image cache width/height is passed for common thumbnails.
  - throttle/cancel scroll prefetch based on runtime performance policy.
  - narrow Riverpod watches on hot widgets with `.select` where rebuild scope is too broad.
  - avoid changing visual layout except for performance-correct placeholder sizing.

  Task 6 result:

  - Preserved existing lazy `SliverGrid`/`SliverList`/`ListView` builders.
  - `AppNetworkImage` already resolves cache dimensions from explicit or logical sizes, so no visual/API change was needed there.
  - `useScrollPrecache` now resolves count/concurrency from `RuntimePerformancePolicy` and cancels prefetch when runtime policy disallows image prefetch.
  - Home recommend/popular/live pass runtime policy into scroll prefetch.
  - Home recommend/popular/live and notification lists now use stable keys without list index where identity is stable.

- [x] Tests:

  - widget tests for stable placeholder/image sizing where practical.
  - unit tests for prefetch policy gating.

- [x] Verification:

  - `flutter test` for touched widgets/policies.
  - optional performance trace from Task 1.
  - manual scroll smoke in profile/release mode.

  Task 6 result:

  - `dart format --output=none --set-exit-if-changed` on Task 6 files passed with 0 changes after formatting.
  - `flutter test test/core/hooks test/core/data/network test/core/runtime test/features/profile/data --reporter expanded` passed with 25 tests.
  - `flutter analyze` reports 303 existing/project-wide info issues; filtered analyze output showed no issues in Task 6 changed files.
  - Optional performance trace/manual profile scroll smoke not run in this environment.

## Task 7: Timer, Socket, Video, and Wakelock Power Pass

- [x] Impact-analysis targets before editing:

  - `live_socket_service`
  - `use_player_system_settings`
  - `vertical_video_page`
  - QR/SMS login view models with timers
  - topic picker timers

  Task 7 result: GitNexus returned `UNKNOWN` / target not found for
  `live_socket_service`, `usePlayerSystemSettings`, `VerticalVideoPage`, and
  `LiveRoomController`; no HIGH/CRITICAL risk was reported. QR/SMS/topic timer
  files were audited but not edited.

- [x] Audit all timer/socket/wakelock owners.

  Known pattern locations:

  - `lib/core/hooks/use_scroll_precache.dart`
  - `lib/features/auth/presentation/view_models/auth_qr_login_view_model.dart`
  - `lib/features/auth/presentation/widgets/sms_login_view.dart`
  - `lib/features/dynamic/presentation/widgets/topic_picker.dart`
  - `lib/features/live/presentation/view_models/live_socket_service.dart`
  - `lib/features/video/presentation/player/hooks/use_player_system_settings.dart`
  - `lib/features/video/presentation/player/vertical_video_page.dart`

- [x] Required changes:

  - every timer has a clear owner and dispose/cancel path.
  - socket reconnect/ping loops obey lifecycle/background policy.
  - video wakelock is enabled only during active playback.
  - route exit, pause, app background, and playback error release wakelock.
  - non-visible live/video surfaces stop unnecessary work.

  Task 7 result:

  - Existing scroll, QR login, SMS login, and topic picker timers already have cancel/dispose paths.
  - `LiveSocketService` now stores the active room connection, suspends heartbeat/socket work when runtime policy enters background/suspended mode, and reconnects when runtime policy resumes.
  - `LiveRoomController` applies `runtimePerformancePolicyProvider` to its socket service.
  - `VerticalVideoPage` no longer enables wakelock unconditionally.
  - `usePlayerSystemSettings` now owns wakelock through a wrapper and disables it on pause, player error, and hook dispose.

- [x] Tests:

  - fake-async tests for timers where possible.
  - view-model dispose cancels pending loops.
  - wakelock service wrapper receives release on pause/dispose/error.

- [x] Verification:

  - targeted tests
  - `flutter analyze`
  - manual video/live background/foreground smoke.

  Task 7 result:

  - `dart format --output=none --set-exit-if-changed` on Task 7 files passed with 0 changes after formatting.
  - `flutter test test/features/video/presentation/player/player_wakelock_test.dart test/core/hooks test/core/data/network test/core/runtime test/features/profile/data --reporter expanded` passed with 26 tests.
  - `flutter analyze` reports 302 existing/project-wide info issues; filtered analyze output showed no issues in Task 7 changed files.
  - Manual video/live background/foreground smoke not run in this environment.

## Task 8: Build, Platform, and Configuration Cleanup

- [ ] Impact-analysis is not required for pure Gradle/YAML/doc config, but do inspect generated/build files before changing them.

- [ ] Review Android release config.

  Candidate files:

  - `android/app/build.gradle.kts`
  - `android/app/proguard-rules.pro`
  - `android/gradle.properties`

  Requirements:

  - keep resource shrinking in release.
  - document debug signing limitation if release remains debug-signed locally.
  - avoid broad keep rules unless required by runtime failures.

- [ ] Review CI gates.

  Candidate file:

  - `.github/workflows/ci.yml`

  Requirements:

  - align `flutter-version` with the `pubspec.yaml` Dart SDK constraint, or introduce a shared repo toolchain pin and make CI consume it.
  - keep format/analyze/test.
  - keep Android build smoke.
  - do not add expensive profile traces to every PR by default.
  - optional manual workflow/job for performance trace is acceptable.

- [ ] Review analysis/lint config.

  Candidate file:

  - `analysis_options.yaml`

  Requirements:

  - do not suppress performance-relevant lints broadly.
  - generated file excludes remain narrow.

- [ ] Verification:

  - `flutter analyze`
  - `flutter test`
  - `flutter build apk --debug --target-platform android-arm64`

## Task 9: Final Verification and Closeout

- [ ] Run full codegen and localization:

  - `dart run slang`
  - `dart run build_runner build --delete-conflicting-outputs`

- [ ] Run full static/test gates:

  - `dart format --output=none --set-exit-if-changed .`
  - `flutter analyze`
  - `flutter test`

- [ ] Run build smoke:

  - `flutter build apk --debug --target-platform android-arm64`

- [ ] Run GitNexus change detection before commit:

  - `gitnexus_detect_changes(scope: "all", repo: "Culcul")`

- [ ] Update documentation:

  - `docs/performance/phase22-baseline.md`
  - this plan checklist
  - spec status from Draft to Accepted/Completed only after review or implementation closeout

- [ ] Commit in small slices:

  - baseline/docs
  - runtime/network policy
  - repository/cache migration
  - UI/power pass
  - config/CI closeout

## Self-Review

- Spec coverage: all spec goals map to tasks 1-9.
- Scope: broad, but intentionally split into independently verifiable slices.
- No hidden library swap: existing mature stack stays primary.
- Risk controls: high-blast-radius symbols require GitNexus impact analysis before edits.
- Verification: normal correctness gates plus opt-in performance trace and manual profile smoke.
