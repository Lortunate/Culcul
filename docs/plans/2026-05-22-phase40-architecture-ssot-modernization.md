# Phase 40 Architecture SSOT Modernization Plan

Status: Active execution plan for Phase 40.

Issue tracking remains in `bd`; this plan is the execution narrative and does
not replace bd issues.

## Execution Principles

- Preserve the existing dirty worktree route/feature UI decoupling changes.
- Prefer tightening current architecture over adding new abstractions.
- Run GitNexus impact analysis before editing any function, class, or method.
- Warn before modifying HIGH or CRITICAL risk symbols.
- Delete migrated compatibility paths immediately.
- Do not introduce empty services, managers, helpers, facades, or future-proof
  extension points.
- Use Riverpod generated providers for new or rewritten provider state.
- Use Context7 for library/framework/API documentation when a library decision
  is needed.

## Current Baseline

- Branch: `codex/phase40-architecture-ssot`.
- Current working tree already contains many uncommitted routing and feature UI
  changes. They are treated as in-progress Phase 40 work, not reverted.
- Main dependencies to keep: hooks_riverpod/Riverpod codegen, go_router builder,
  Dio/Retrofit, Freezed/json_serializable, Drift, Slang, media_kit.
- Active bd issues aligned with this plan include:
  - `culcul-ory`: Consolidate DTO and application model ownership.
  - `culcul-5t8`: Remove feature dependencies on app routing.
  - `culcul-38k`: Remove app bootstrap dependency from feature UI.
  - `culcul-ann`: Consolidate network decoding and error conversion.
  - `culcul-ep5`: Trim startup and global cache lifetime.
  - `culcul-3hh`: Consolidate app-feature runtime seams.
  - `culcul-6r8`: Normalize endpoint source of truth.
- Baseline architecture tests pass with `flutter test test/architecture
  --reporter compact` on 2026-05-22.
- `culcul-ory` is claimed for the first implementation slice.

## Phase 1: Documentation And Guard Baseline

Goal: make the active architecture target and safety rails unambiguous before
larger code movement.

Execution:

1. Update the active Phase 40 spec and plan with current audit findings.
2. Keep Phase 39 and older records archived; do not resurrect superseded docs as
   current guidance.
3. Inspect existing architecture tests and guards under `test/architecture` and
   `tool/architecture`.
4. Add or tighten guard coverage for:
   - feature presentation importing feature data;
   - feature data importing feature application;
   - feature internals imported by another feature;
   - feature UI importing `app/router/app_routes.dart`.
5. Record the Phase 40 audit cleanup targets in the spec before code movement:
   search result DTO/domain duplication, Bilibili link parsing duplication,
   parallel pagination/comment controller state, and live/player lifecycle risks.
6. Keep any migration allowlist explicit, narrow, and connected to bd work.
7. Treat generated Dart files as outputs; edit source and regenerate.

Validation:

```bash
flutter test test/architecture
flutter analyze --no-pub
```

## Phase 2: Routing And Feature Boundary Cleanup

Goal: finish the app-owned routing model already started in the worktree.

Execution:

1. Review route builder signatures in every `lib/features/*/route_entry.dart`.
2. Keep callback injection in `lib/app/router/routes/*.dart`.
3. Remove remaining feature UI imports of `app/router/app_routes.dart`.
4. Remove remaining direct `MaterialPageRoute` pushes from feature widgets when
   app-owned typed routes can provide callbacks.
5. Prefer simple typed callbacks over a new navigation service.

High-risk impact targets before edits:

- `router` in `lib/app/router/app_routes.dart` is CRITICAL risk.
- Route data classes in `lib/app/router/routes/*.dart` may have wide generated
  route impact.
- Large page/view-model edits in video, dynamic, notification, and profile need
  focused tests.

Validation:

```bash
flutter test test/architecture/architecture_route_ownership_guard_test.dart
flutter test test/features/video/presentation/detail/video_info_view_test.dart
flutter analyze --no-pub
```

## Phase 3: Session And Cross-Feature Access

Goal: reduce broad imports of auth/session internals and make cross-feature
runtime access explicit.

Execution:

1. Use `SearchPort` as the local template for narrow feature ports.
2. Start with smaller features before touching video/dynamic/notification.
3. Replace auth-internal feature imports with a narrow session contract where
   consumers only need current user/session facts.
4. Keep app-level composition responsible for wiring concrete implementations.
5. Delete temporary providers or shims after consumers move.

Impact targets before edits:

- `Auth` / `authControllerProvider` in `auth_controller.dart`.
- `currentUserProvider` and related session providers.
- Any contract in `core/contracts` that is consumed by many features.

Validation:

```bash
flutter test test/architecture
flutter analyze --no-pub
```

## Phase 4: Model And DTO Ownership

Goal: each business concept has one source of truth.

Execution:

1. Inventory `application/models` that are actually API response shapes.
2. Move API-shaped types to `data/dtos` with mappers to domain only when the
   domain type adds real value.
3. Merge DTO/domain mirror pairs where domain entities have no behavior.
4. Keep high-blast-radius shared contracts stable until small features prove the
   migration pattern.
5. Regenerate code when Freezed/json_serializable source changes.

Initial lower-risk candidates:

- video subtitle transport model migration from `application/models` to
  `data/dtos` is complete and guarded;
- live danmu info transport model migration from `application/models` to
  `data/dtos` is complete and guarded;
- live gold rank and live guard list are the next low-risk live DTO ownership
  candidates; both are complete and guarded;
- favorites folder DTO/entity duplication;
- history entry DTO/entity duplication;
- to_view DTO/entity duplication.

High-risk targets to defer until guards are stable:

- `VideoModel` and comment contracts under `core/contracts`;
- dynamic response models;
- video detail models.
- live room detail models.

Validation:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test test/architecture
flutter analyze --no-pub
```

## Phase 5: Network, Error, And Endpoint Consolidation

Goal: one network policy path and one endpoint source of truth.

Execution:

1. Impact-check `DioClient`, `RequestExecutor`, and endpoint constants before
   edits.
2. Keep generic Dio failure conversion in `RequestExecutor`/`AppError`.
3. Move repeated response decoding/error conversion out of repositories.
4. Normalize endpoint constants and Retrofit annotations so cache policy and path
   strings cannot drift.
5. Delete duplicate/unused endpoint constants after all references move.

High-risk targets:

- `DioClient` is HIGH risk.
- `RequestExecutor` is HIGH risk.
- endpoint policy providers may affect cache/network behavior globally.

Validation:

```bash
flutter test test/architecture
flutter analyze --no-pub
```

## Phase 6: Startup And Runtime Performance

Goal: reduce retained memory and long-lived global work without changing product
behavior.

Execution:

1. Review `@Riverpod(keepAlive: true)` family providers and remove keepAlive when
   there is no product reason for retaining keyed data.
2. Start with room-scoped live danmaku feed retention and live room/player
   lifecycle idempotency before touching global network or media policy.
3. Add lifecycle cleanup or documented app-wide lifetime for static queues and
   listeners.
4. Keep synchronous live socket JSON decode only if profiling confirms it is the
   better hot-path tradeoff.
5. Move article paragraph recognizer churn behind stable widget lifecycle if the
   first performance slice reaches dynamic article rendering.
6. Clean local ignored artifacts only as workspace hygiene, not as source changes.
7. Avoid replacing mature dependencies just for novelty.

Validation:

```bash
flutter analyze --no-pub
flutter test
```

## Dependency And Tooling Follow-Up

Keep current main stack. Candidate follow-ups:

- Add `riverpod_lint` and `custom_lint` after current architecture changes are
  stable.
- Consider low-risk package upgrades: `connectivity_plus`, `easy_refresh`,
  `image_picker`.
- Defer `dio_cache_interceptor` v4 migration because it likely changes file-store
  ownership.
- Defer `pointycastle` major upgrade until auth crypto tests exist.
- Simplify Slang codegen only after confirming `build_runner` fully covers the
  current translation workflow.

## First Directly Executable Refactor Steps

Immediate execution order:

1. Update Phase 40 documentation.
2. Inspect current architecture guards and route ownership tests.
3. Add red architecture guards for two low-risk boundary leaks:
   `core/features -> app/bootstrap` and `app/router -> feature internals`.
4. Move media runtime initialization to `lib/core/runtime` while leaving
   first-frame scheduling in `lib/app/bootstrap`.
5. Move notification navigation parsing/target ownership to
   `lib/features/notification/application` and keep app router consumption
   through `notification/route_entry.dart`.
6. Defer Profile route callback consolidation because `UserProfileRoute` has a
   CRITICAL GitNexus impact report; plan it as a separate test-backed slice.
7. Run the focused architecture and notification/media tests.
8. Run format cleanup, then architecture guards and `flutter analyze --no-pub`.
9. Run GitNexus `detect_changes(scope: "all", repo: "Culcul")`.
10. Update/close bd issues that this slice completes.
11. Use `culcul-ory` for the next DTO/model ownership slice only after this
    boundary baseline is green.
