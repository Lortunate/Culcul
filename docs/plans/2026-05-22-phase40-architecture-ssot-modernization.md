# Phase 40 Architecture SSOT Modernization Plan

Date: 2026-05-22

Tracking issue: `culcul-pe9`

This plan executes the Phase 40 spec in bounded, reviewable slices. `bd`
remains the issue tracker; this document describes execution order, verification
gates, and ownership boundaries.

## Execution Principles

- Make one source of truth before moving callers.
- Delete dead compatibility paths as soon as callers migrate.
- Do not add a facade, service, manager, helper, or utility unless it removes a
  verified duplicate policy or cycle.
- Before editing any Dart symbol, run GitNexus upstream impact analysis for the
  symbol and report the blast radius.
- Stop before edits if GitNexus reports HIGH or CRITICAL risk.
- Prefer existing modern stack: generated Riverpod, typed go_router routes,
  Dio/Retrofit, Freezed/JSON, Drift, Slang.
- Avoid adding dependencies unless an existing implementation is materially
  worse than a mature, popular package.

## Phase 1: Active Documentation And Guard Baseline

Goal: make architecture intent match the verified repository state before code
moves start.

Steps:

1. Create or claim a `bd` parent issue for Phase 40 execution, with child issues
   for routing, data/model ownership, network/error consolidation, and startup
   performance.
2. Update `docs/architecture/architecture-guide.md` so Phase 40 is the only
   active architecture source.
3. Mark Phase 39 docs superseded after this spec/plan is accepted.
4. Reconcile duplicate archive artifacts for Phase 30 and Phase 32.
5. Add or update documentation guard coverage for stale active phase links.
6. Re-run:
   `flutter analyze`
   `bash tool/architecture/run_architecture_guards.sh`

First-phase output:

- Active guide points to Phase 40 spec and plan.
- No active doc points to archived phase files as current work.
- Guard baseline remains green.

## Phase 2: Routing And Feature Boundary Cleanup

Goal: remove app-route coupling from feature internals.

Steps:

1. Run GitNexus impact analysis on selected route symbols before edits.
2. Convert `SearchTopicItem` away from raw `MaterialPageRoute`.
3. Remove feature imports of `app/router/app_routes.dart` feature by feature.
4. For same-feature routes, expose route locations through that feature's
   `route_entry.dart`.
5. For cross-feature routes, push route decisions up to app composition or use a
   narrow feature public route contract.
6. Tighten route ownership guard after each converted slice.

Verification:

- Feature imports of `app/router/app_routes.dart`: 0.
- Raw `MaterialPageRoute` in features: 0.
- Route ownership guard passes.
- Focused navigation/widget tests pass for changed features.

## Phase 3: Session And Cross-Feature Access

Goal: stop using auth internals as a shared state bus.

Steps:

1. Analyze `auth_session_providers.dart` with GitNexus before edits.
2. Decide whether shared session state belongs in `core/session` or a narrow
   `features/auth/auth.dart` public API based on actual callers.
3. Move only product-real session concepts: current user, auth status, and
   session refresh policy.
4. Replace broad `features/** -> auth/application/**` imports with the chosen
   public source.
5. Delete obsolete auth application re-export paths.

Verification:

- Cross-feature imports into auth internals are removed.
- No new generic service shell is introduced.
- Auth/session tests and analyzer pass.

## Phase 4: Model And DTO Ownership

Goal: keep API shapes in data and application state JSON-free.

Steps:

1. Start with video, dynamic, and live because the audit found DTO leaks there.
2. Move JSON DTO families from `application/models` to `data/dtos`.
3. Keep mapping in `data/mappers` or repository implementations when it is
   feature-local.
4. Return application-ready models from repository/application boundaries.
5. Delete generated JSON surfaces from application models after callers move.

Verification:

- Application imports of `data/dtos`: 0, unless explicitly documented.
- DTOs with `fromJson`/`toJson` live under `data/dtos`.
- Build runner output is regenerated and inspected.
- Focused feature tests pass.

## Phase 5: Network, Error, And Config Consolidation

Goal: one execution path for network results and error conversion.

Steps:

1. Analyze `RequestExecutor`, `ApiResponseDecoder`, `AppError`, and
   `ErrorHandler` with GitNexus before edits.
2. Merge `ApiResponseDecoder` behavior into `RequestExecutor` or a private
   manual-Dio adapter.
3. Add one `Result` unwrap or async adapter and replace repeated
   failure-throw conversions.
4. Move shared API base URLs and endpoint ownership into `ApiConstants` or the
   existing endpoint policy provider.
5. Delete `ErrorHandler` if the UI widget remains its only caller.

Verification:

- Generic network decoding has one owner.
- Generic error conversion has one owner.
- Endpoint constants are not duplicated.
- Existing network/repository tests pass or are added where missing.

## Phase 6: Startup And Runtime Performance

Goal: remove feature UI dependency on app bootstrap and trim long-lived runtime
state.

Steps:

1. Analyze `DeferredAppInitController`, media service/provider symbols, and
   live player widget dependencies with GitNexus before edits.
2. Move media readiness behind a core media provider or app-owned bootstrap
   policy.
3. Remove `app/bootstrap` imports from feature code.
4. Review `keepAlive` providers and mutable global caches; keep only those with
   clear runtime value.
5. Move expensive synchronous parsing or repeated computation away from widget
   builds.

Verification:

- Feature imports of `app/bootstrap/**`: 0.
- Startup guard or focused startup tests pass where available.
- Analyzer, architecture guards, and focused live/media tests pass.

## First Directly Executable Refactor Steps

These are the first steps to run after design approval:

1. Create or claim the Phase 40 `bd` issue.
2. Update `docs/architecture/architecture-guide.md` to point at Phase 40.
3. Mark Phase 39 spec/plan superseded or archive them.
4. Add documentation guard coverage for active phase links.
5. Run analyzer and architecture guards.
6. Run GitNexus `detect_changes(scope: "all", repo: "Culcul")`.
7. Then start the routing slice with `SearchTopicItem` because it is concrete,
   visible, and lower risk than a broad app-router migration.
