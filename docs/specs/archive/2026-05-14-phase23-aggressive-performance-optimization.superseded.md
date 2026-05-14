> Superseded on 2026-05-14 by `docs/specs/phase24-architecture-source-of-truth-consolidation.md`.
> This was a performance-only draft without a matching plan. The new active phase prioritizes app/code/directory architecture and single-source ownership before adding more performance dependencies.

# Phase 23: Aggressive Performance Optimization Spec

## Status

Draft for review.

## Context

Phase 22 (Tasks 1-7) established the runtime performance policy infrastructure:
- `RuntimePerformancePolicy` with 4 profiles (interactive/balanced/constrained/background)
- `EndpointPolicy` per-request classification with 7 request classes
- Dio interceptor chain: dedup → policy → cache → retry → auth
- Profile/user cache migrated from SharedPreferences to Drift
- Scroll prefetch gated by runtime policy
- Lifecycle-aware socket/wakelock management
- 26 passing tests covering policy, cache, and power

Phase 22 Tasks 8-9 (build config + final verification) remain incomplete and will be absorbed into this phase.

This phase takes a more aggressive approach: replace custom implementations with battle-tested libraries, upgrade the network transport layer, optimize the image pipeline, and harden build/CI configuration. Breaking changes to internal APIs are acceptable — no backwards compatibility required.

## Current Stack Assessment

| Layer | Current | Issue |
|-------|---------|-------|
| Image caching | `extended_image` only | No dedicated cache manager, no progressive loading, no memory pressure response |
| HTTP cache | Custom `CacheInterceptor` + `dio_cache_interceptor` | Dual-layer complexity, custom key builder duplicates library logic |
| HTTP transport | `dio_http2_adapter` | HTTP/2 only, no platform-native optimization |
| JSON parsing | `BackgroundTransformer` (single isolate) | Bottleneck under concurrent responses |
| Concurrency | Custom `Semaphore` + `NetworkConcurrencyExecutor` | Reinvents `pool` package, no priority queue |
| Build config | Gradle parallel/caching not enabled | Slower builds than necessary |
| CI | 18% coverage threshold, no size budget | No regression detection |
| ProGuard | Broad keep rules (Hive, Gson) | Dead rules for removed dependencies |
| Image format | No WebP enforcement | Larger network payloads for thumbnails |
| Monitoring | `DevLogger` only (debug/profile) | No production performance visibility |

## Goals

1. **Network throughput**: Replace custom concurrency control with `pool` package; upgrade `dio_cache_interceptor` to latest (4.x) with single unified cache layer.
2. **Image pipeline**: Add `cached_network_image` for feed thumbnails with memory-pressure-aware eviction; keep `extended_image` only for zoomable/editable views.
3. **JSON decode performance**: Replace single `BackgroundTransformer` with parallel isolate pool for concurrent response decoding.
4. **Build speed**: Enable Gradle parallel execution, build caching, and configuration cache.
5. **App size**: Add `--split-debug-info` + `--obfuscate` for release; audit and remove dead ProGuard rules; enforce `--split-per-abi` for distribution.
6. **CI hardening**: Add APK size budget check, upgrade coverage threshold, add performance regression gate.
7. **Production monitoring**: Add lightweight performance tracing (startup time, network latency percentiles, frame drop rate) reportable via structured logs.
8. **Dependency cleanup**: Remove unused keep rules (Hive, Gson), audit transitive dependencies, pin all versions exactly.
9. **Platform-native transport** (stretch): Evaluate `cronet_http` (Android) for HTTP/3 + native caching as Dio transport adapter.

## Non-Goals

- No replacement of Dio, Riverpod, Retrofit, Drift, or go_router.
- No visual/UX redesign.
- No offline-first product mode.
- No migration away from `extended_image` for image viewing/editing.
- No custom rendering engine work (Impeller is already default).

## Proposed Architecture Changes

### 1. Image Pipeline Upgrade

```
Before:
  extended_image (all use cases) → custom memory management

After:
  cached_network_image (feed thumbnails, avatars, covers)
    └── flutter_cache_manager (disk cache, LRU eviction, max age)
  extended_image (zoomable image viewer, image editor only)
```

Benefits:
- `cached_network_image` has built-in placeholder/error/progress widgets
- `flutter_cache_manager` provides configurable disk cache size limits and automatic eviction
- Memory pressure handling via `PaintingBinding.instance.imageCache` size limits
- Progressive JPEG/WebP decode support

### 2. Network Cache Simplification

```
Before:
  CacheInterceptor (custom key builder, TTL resolution)
    → DioCacheInterceptor (actual cache read/write)
    → 7-day maxStale

After:
  DioCacheInterceptor 4.x (single layer)
    → EndpointPolicy provides CacheOptions per request
    → Custom CacheKeyBuilder (strip volatile params only)
    → Per-endpoint maxStale from EndpointPolicy
    → No separate custom interceptor
```

### 3. Concurrency Control Upgrade

```
Before:
  Custom Semaphore + NetworkConcurrencyExecutor
  Custom NetworkConcurrencyProfiles (upload: 3, enrich: 4, backgroundSync: 2)

After:
  package:pool (Dart official, 6.24M downloads)
    → Pool per EndpointConcurrencyLane
    → Priority queue support (interactive > background)
    → Automatic resource cleanup on timeout
```

### 4. JSON Decode Parallelism

```
Before:
  BackgroundTransformer → single compute() call per response

After:
  Isolate pool (2-4 workers based on platform core count)
    → Concurrent JSON decode for parallel responses
    → Reuse warm isolates (avoid spawn overhead)
    → Fallback to sync decode for small payloads (<4KB)
```

### 5. Build & Release Optimization

```
Gradle:
  + org.gradle.parallel=true
  + org.gradle.caching=true
  + org.gradle.configuration-cache=true
  + android.enableR8.fullMode=true

Release flags:
  + --split-debug-info=build/debug-info
  + --obfuscate
  + --split-per-abi (for distribution builds)
  + --tree-shake-icons

ProGuard cleanup:
  - Remove Hive rules (not used)
  - Remove Gson rules (not used, using json_serializable)
  - Tighten Flutter keep rules
```

### 6. CI Enhancement

```
+ APK size budget (warn if arm64 APK exceeds 35MB)
+ Coverage threshold increase (18% → 25%)
+ flutter test --reporter=github (better PR annotations)
+ Optional manual workflow for performance profiling
+ Dependency audit step (outdated/vulnerable packages)
```

## Libraries to Add

| Package | Version | Purpose | Justification |
|---------|---------|---------|---------------|
| `cached_network_image` | ^3.4.1 | Feed image caching | 6.9k likes, industry standard, memory-pressure-aware |
| `flutter_cache_manager` | ^3.4.1 | Disk cache backend | Required by cached_network_image, configurable LRU |
| `pool` | ^1.5.2 | Concurrency control | Dart official, 6.24M downloads, replaces custom semaphore |
| `sentry_flutter` | ^9.20.0 | Production monitoring | 1.0k likes, auto performance tracing, crash reporting |

## Libraries to Remove (if unused)

Audit and remove if confirmed unused:
- Any Hive-related transitive dependencies
- Any Gson-related native dependencies

## Risk

| Risk | Mitigation |
|------|-----------|
| `cached_network_image` + `extended_image` cache conflict | Configure separate cache managers, shared disk budget |
| `pool` API differs from custom Semaphore | Adapter pattern during migration, test coverage |
| R8 full mode breaks reflection | Run full integration test after enabling |
| `sentry_flutter` adds SDK size (~2MB) | Acceptable for production visibility gains |
| Isolate pool startup cost | Lazy init after first frame, warm during deferred init |

## Success Criteria

- Feed scroll: 0 dropped frames in 60fps profile trace (10s scroll)
- Cold start: < 1.5s to first meaningful paint (release mode, mid-range device)
- APK size: arm64 release < 30MB (currently unknown baseline)
- Network: P95 response time < 800ms for interactive reads on WiFi
- Memory: Peak RSS < 350MB during heavy feed scrolling
- Build: Full clean build < 3 minutes (CI)
- Tests: 40+ passing tests covering all policy/cache/concurrency paths

## Verification

- `dart format --output=none --set-exit-if-changed .`
- `flutter analyze`
- `flutter test`
- `flutter build apk --release --split-per-abi --split-debug-info=build/debug-info --obfuscate`
- APK size check (arm64)
- Manual profile-mode scroll test on physical device
- Sentry dashboard verification (if integrated)
