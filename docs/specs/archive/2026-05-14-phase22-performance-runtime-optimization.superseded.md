> Superseded on 2026-05-14 by `docs/specs/phase24-architecture-source-of-truth-consolidation.md`.
> Phase 22 completed most runtime-policy work, but remaining build/config closeout is absorbed into Phase 24 so the active architecture plan has one source of truth.

# Phase 22 Performance Runtime Optimization Spec

## Status

Draft for review.

## Context

Culcul has finished the structural architecture cleanup through Phase 20, and `CLAUDE.md` points at a Phase 21 consolidation effort. In this checkout, the referenced Phase 21 spec/plan files are absent, so this spec defines the next concrete performance-focused phase without assuming those missing files.

Current architecture remains:

- `lib/app/` owns bootstrap, routing, runtime wiring, and root overrides.
- `lib/core/` owns shared contracts, network, bootstrap providers, storage, services, hooks, and session state.
- `lib/features/` owns feature data/domain/presentation code.
- `lib/ui/` owns shared design-system and assembly widgets.
- `lib/shared/` remains retired.

The app already has mature foundations: `dio`, `retrofit`, `dio_cache_interceptor`, `dio_smart_retry`, `dio_http2_adapter`, `connectivity_plus`, `drift`, `riverpod_annotation`, `freezed`, `extended_image`, `media_kit`, and `wakelock_plus`. It also already has `lib/core/perf/` with `FrameTimingSampler`, `PerformancePolicy`, `PerformancePolicyController`, and `DevLogger`. Phase 22 should optimize policy and architecture around these existing pieces before adding more dependencies.

Official Flutter performance guidance emphasizes profiling first, reducing unnecessary rebuild/work, using lazy lists, keeping heavy work off the UI thread, and validating smoothness with DevTools/timeline traces. Official Dio guidance supports configured `BaseOptions`, interceptors, cancellation, and explicit lifecycle cleanup. Phase 22 applies those rules to this codebase.

## Problem

Performance work is currently spread across many local seams:

- Network timeout/retry/cache/dedup/concurrency behavior is split across `dio_client.dart`, interceptors, `NetworkQualityPolicy`, `RequestExecutor`, repository code, and endpoint-specific constants.
- Many repositories still repeat request execution, `Result` mapping, `AppError` mapping, and local catch/throw behavior.
- Cache storage is fragmented: Dio HTTP cache, notification Drift database, and profile/user JSON in `SharedPreferences`.
- Connectivity-aware network policy exists, but it does not yet account for app foreground/background lifecycle, metered/constrained behavior beyond connectivity class, request importance, or unsafe retry protection.
- UI smoothness risks remain in image-heavy feeds, list pages, timers, socket/live/video surfaces, and broad Riverpod rebuild scopes.
- Power risks remain around prefetching, timers, sockets, wakelock, media playback, and background network work.
- Local toolchain and CI config appear misaligned: `pubspec.yaml` requires Dart `^3.10.7`, while CI pins Flutter `3.10.7`, which predates that SDK line.
- CI verifies correctness but has no performance guardrails, trace budgets, cache policy tests, or network policy tests.

## Goals

1. Establish measurable performance baselines before large rewrites.
2. Centralize runtime performance policy in `core/`, then make features consume it.
3. Make network behavior predictable: endpoint policy, safe retries, cancellation, cache TTL, concurrency class, priority, and lifecycle behavior.
4. Improve smoothness for image/list/feed/video/live surfaces by reducing rebuilds, eager work, decoding cost, and scroll-time side effects.
5. Reduce power use by lifecycle-aware timers, socket/polling cleanup, prefetch budgets, and wakelock discipline.
6. Strengthen build/platform/config defaults where they affect runtime performance, release size, startup cost, or diagnostics.
7. Preserve Phase 21 architecture rules: no `lib/shared`, no cross-feature internals, generated Riverpod providers for new work, freezed DTO/entities, and core/ui not importing features.

## Non-Goals

- No visual redesign.
- No replacement of Dio, Riverpod, Retrofit, Drift, ExtendedImage, media_kit, or go_router.
- No backwards compatibility guarantee for old internal APIs.
- No broad offline-first product mode in this phase. Only targeted durable cache seams that improve performance and reduce repeated network work.
- No hand-written provider graph for new work.
- No custom retry engine if `dio_smart_retry` can express the behavior.

## Success Criteria

Performance baselines and guards:

- Add repeatable measurement commands for analyze/test/codegen plus at least one profile-oriented integration trace target.
- Document baseline numbers before implementation and updated numbers after each major task.
- Add tests for endpoint retry/cache policy, request cancellation, lifecycle throttling, and cache invalidation.

Network/data:

- All core network defaults come from one policy model.
- Unsafe requests do not retry unless explicitly opted in.
- Endpoint policy decides timeout, retry, cache TTL, dedup, concurrency lane, and stale-cache allowance.
- Repositories use a shared request execution seam instead of duplicating error mapping.
- Durable cache migration has explicit invalidation and session-safety rules.

UI/runtime/power:

- Image-heavy list surfaces use explicit cache sizing and lazy builders.
- Scroll prefetch is constrained by network quality, app lifecycle, and list priority.
- Timers, sockets, polling, and wakelock have owner lifecycle cleanup.
- Riverpod rebuild scopes are narrowed on high-traffic screens through `.select`, scoped providers, or view-model state splitting.

Build/platform/config:

- Release Android config keeps shrinking/resource shrinking and documents signing/minification constraints.
- CI Flutter version aligns with the Dart SDK constraint or the repo adds an explicit toolchain pin that CI and local development share.
- CI keeps current correctness gates and adds focused performance/config tests without making every PR run expensive profile jobs by default.

## Proposed Architecture

### Runtime Policy

Extend the existing performance policy layer under `lib/core/perf/` and add runtime inputs under `lib/core/runtime/` only where lifecycle state is needed:

- `PerformanceProfile`: `interactive`, `balanced`, `constrained`, `background`.
- `RuntimePerformancePolicy`: composed from frame timing, connectivity, app lifecycle, user settings if any, and platform hints available in Flutter.
- `EndpointPolicy`: per endpoint or request class policy for timeout, retry, cache, dedup, concurrency, and background behavior.

The policy should reuse `FrameTimingSampler` and `PerformancePolicyController`, stay mostly pure Dart, remain easily unit-tested, and expose Riverpod providers only at the app/runtime boundary.

### Network Policy

Keep Dio as the HTTP client. Consolidate behavior around:

- `Dio(BaseOptions(...))` for global base URL, timeouts, headers, and response type defaults.
- Interceptor order: auth/csrf/wbi, network quality, dedup, cache, retry, logging only in debug.
- `dio_smart_retry` only for idempotent safe methods by default.
- `CancelToken` propagation from view-model/page lifecycle to repository/API calls.
- `dio_cache_interceptor` for HTTP cache, with policy-driven TTL and stale behavior.
- `dio_http2_adapter` retained only if current platform behavior is verified.

### Data Cache

Keep HTTP response cache separate from domain cache:

- HTTP cache: transport-level, short TTL, safe for anonymous or public responses.
- Domain cache: Drift-backed where stale reads improve UX and reduce repeated requests.
- Sensitive/session-bound data: explicit invalidation on logout/session change.
- Profile/search/home/feed metadata are better first candidates than broad dynamic/social writes.

### UI Smoothness

Target high-traffic surfaces first:

- Home feeds, ranking/weekly lists, dynamic lists, notification lists, live/video surfaces, and image preview surfaces.
- Prefer lazy builders and stable item keys.
- Prefer `const` widgets and narrower provider watches where useful.
- Keep image cache dimensions explicit through `AppNetworkImage`.
- Keep prefetch bounded and cancelable.
- Move heavy parsing/transforms off the UI path only when profiling shows it matters.

### Power

Power optimization is mostly lifecycle control:

- Stop timers, sockets, and polling when screens are disposed or backgrounded.
- Pause or lower prefetch while constrained/backgrounded.
- Apply wakelock only during active video playback and release on pause, background, route exit, and errors.
- Avoid network retries for user-invisible background work unless the request is safe and valuable.

## Libraries

Keep and standardize:

- `dio`
- `retrofit`
- `dio_cache_interceptor`
- `dio_cache_interceptor_file_store`
- `dio_cookie_manager`
- `dio_smart_retry`
- `dio_http2_adapter`
- `connectivity_plus`
- `drift` / `drift_flutter`
- `riverpod_annotation`
- `freezed`
- `extended_image`
- `media_kit`
- `wakelock_plus`

Add only if implementation proves a real gap:

- `path`: acceptable if cache/database path handling needs clearer cross-platform joins.
- `rxdart`: acceptable only if stream composition for live/notification state becomes materially simpler.
- No new HTTP client.

## Risk

- `dioClientProvider`, `RequestExecutor`, `NetworkQualityPolicy`, and shared error types have high blast radius.
- Retry policy can duplicate side-effect requests if unsafe methods are retried.
- Cache policy can leak stale or session-bound data if invalidation is weak.
- Drift expansion can add startup/migration cost if opened too early.
- UI rebuild work can look correct in tests but regress scroll smoothness without trace/screenshot/profile checks.

## Verification

Minimum verification for this phase:

- `dart run slang`
- `dart run build_runner build --delete-conflicting-outputs`
- `dart format --output=none --set-exit-if-changed .`
- `flutter analyze`
- `flutter test`
- Focused unit tests for policy, cache, cancellation, lifecycle, and error mapping.
- At least one integration performance trace using Flutter `traceAction` for a high-traffic scrolling surface.
- Manual release/profile smoke on Android for startup, scrolling, video playback, background/foreground, and logout cache invalidation.
