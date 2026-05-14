# Phase 27 Architecture Simplification Spec

## Status

Active on 2026-05-14.

Supersedes:

- `docs/specs/archive/2026-05-14-phase26-application-seam-hardening.completed.md`

## Context

Phases 1–26 established clean boundaries, eliminated barrel chains, enforced feature scope seams, and consolidated source-of-truth. The architecture is well-guarded and violation-free.

However, the codebase still carries complexity from its evolutionary history:

1. **Bootstrap over-layering** — `BootstrapCoordinator`, `AppRuntime` value object, three mutable-global provider initializers, and `DeferredAppInitController` (91 lines for one task) add indirection without value. A flat `main()` with Riverpod `overrideWithValue` would be shorter and clearer.

2. **Dead infrastructure** — `EndpointConcurrencyLane` enum is defined but never consumed at runtime. `RequestExecutorBinding` mixin is a thin pass-through that hides `RequestExecutor` capabilities.

3. **Pass-through application commands** — Some `application/` layer files (e.g., `favorite_folder_commands.dart`) are pure delegation to the repository with no business logic, adding a hop without value.

4. **Misleading naming** — The custom `CacheInterceptor` is not a cache; it translates endpoint policies into cache options for `DioCacheInterceptor`. The name causes confusion.

5. **Notification repository god-facade** — The notification repository uses 7 helper classes with circular back-references to the parent. The helpers should be independent services injected via Riverpod, not manually wired through constructor back-refs.

6. **Redundant dependencies** — Explicit `riverpod` alongside `hooks_riverpod` (which re-exports it), `crypto` + `pointycastle` overlap, `uuid` for trivial v4 generation.

7. **`verifyRootOverrides` startup cost** — Creates and disposes a full `ProviderContainer` on every cold start in production to verify one override. Wasteful.

## Goals

1. Flatten the bootstrap layer: single `AppBootstrap.initialize()` returning `List<Override>`, no coordinator, no `AppRuntime`, no mutable globals.
2. Remove dead infrastructure: `EndpointConcurrencyLane`, `RequestExecutorBinding`.
3. Eliminate pass-through application commands where the presentation layer can call the repository directly.
4. Rename `CacheInterceptor` → `EndpointCacheOptionsInterceptor` for clarity.
5. Refactor notification repository helpers into independent Riverpod-managed services, breaking circular references.
6. Remove redundant dependencies (`riverpod` explicit listing, audit `crypto`/`pointycastle` overlap).
7. Remove or debug-gate `verifyRootOverrides`.
8. Simplify `DeferredAppInitController` to a post-frame callback or minimal class.

## Non-Goals

- No feature-level behavior changes.
- No new features or UI changes.
- No routing restructure (go_router_builder is earning its keep).
- No changes to the performance/runtime adaptive system (it has 10+ active consumers).
- No changes to core contracts or feature scope seam patterns.
- No domain layer removal (entities carry real computed properties).

## Success Criteria

- [ ] `BootstrapCoordinator` and `AppRuntime` deleted; bootstrap is a single function returning overrides.
- [ ] Three mutable-global provider files in `core/bootstrap/providers/` replaced with direct `overrideWithValue`.
- [ ] `DeferredAppInitController` reduced to ≤15 lines or a post-frame callback.
- [ ] `EndpointConcurrencyLane` enum removed from `endpoint_policy.dart`.
- [ ] `RequestExecutorBinding` mixin removed; repositories use `RequestExecutor` directly.
- [ ] At least one pass-through application command file removed (favorites).
- [ ] `CacheInterceptor` renamed to `EndpointCacheOptionsInterceptor`.
- [ ] Notification repository helpers refactored to independent services with explicit dependencies (no circular `repo` back-ref).
- [ ] `verifyRootOverrides` removed or gated behind `kDebugMode`.
- [ ] Redundant `riverpod` dependency removed from pubspec.yaml.
- [ ] `crypto`/`pointycastle` usage audited; one removed if overlap confirmed.
- [ ] All architecture guards still pass.
- [ ] `flutter analyze` clean, app builds and runs.
- [ ] Source file count reduced by ≥5 files.

## Risks

- **Notification refactor scope** — The 7-helper decomposition touches a complex real-time system (WebSocket, DB sync, message send). Must be done carefully with existing behavior preserved.
- **RequestExecutorBinding removal** — Many repositories use this mixin. The migration is mechanical but touches many files.
- **Bootstrap flattening** — Must ensure initialization order is preserved (cookie jar before Dio client, cache store before interceptors).

## Approach

Execute in dependency order: dead code removal first (safe, no behavior change), then bootstrap flattening (isolated to app layer), then notification refactor (highest risk, last).
