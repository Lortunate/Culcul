# Phase 38 Architecture SSOT And Startup Performance Spec

## Status

Active architecture refactor spec. This spec supersedes Phase 37 and keeps the
Phase 37 top-level architecture boundary.

Superseded reference:

- `docs/specs/archive/2026-05-19-phase37-modern-architecture-consolidation.superseded.md`
- `docs/plans/archive/2026-05-19-phase37-modern-architecture-consolidation.superseded.md`

## Current Problem Analysis

The project no longer needs a broad top-level directory migration. The current
`lib/` shape already matches the intended boundary:

- `app/`, `core/`, `features/`, `ui/`, `i18n/`, and `protos/` exist.
- `lib/shared/`, top-level `data/`, top-level `domain/`, and top-level
  `presentation/` are absent.
- `core/` and `ui/` do not import `features/`.
- Feature-to-feature imports do not cross into another feature's private
  `data/**` or `presentation/**` trees.

The remaining architecture problems are inside the valid boundaries:

- `features/` dominates the codebase: current scan found 642 handwritten Dart
  files and 235 generated Dart files under `lib/`; the largest handwritten
  clusters are `video`, `dynamic`, `notification`, `profile`, and `live`.
- 34 feature-to-feature imports remain through `application/**` or public root
  feature seams. This is allowed only when it represents a real product seam,
  but the auth/profile/session seam still needs consolidation.
- DTOs leak outside data layers: audit found 77 non-data files importing
  `data/dtos`, concentrated in `dynamic`, `live`, `video`, and `profile`.
- `RequestExecutor` is the network error/result source of truth. It has high
  blast radius, so Phase 38 must not rewrite it while cleaning feature code.
- Startup still waits before `runApp` for resources that are not all
  first-frame critical: `SharedPreferences`, temp dir, documents dir,
  `PersistCookieJar`, and `FileCacheStore`.
- Bottom navigation in the mobile shell still has a performance-policy opt-out
  and should be normalized to the default adaptive behavior.
- Router setup is correct but broad: `app_routes.dart` imports all feature
  `route_entry.dart` files and the generated route graph is large. Router work
  must be isolated from state/data cleanup.
- Dynamic route ownership drift exists in notification route parts, but
  `DynamicDetailRoute` impact is high and must stay in a dedicated route
  migration slice.
- Player internals are high risk. `PlayerController` has high impact and must
  not be mixed into Phase 38 startup or DTO cleanup slices.
- Tooling is mostly healthy, but the workspace is already dirty and CI appears
  stale: `.github/workflows/ci.yml` pins an older Flutter version than the
  current lockfile requires.

## Recommended Directory Structure

Keep the top-level structure stable and reduce complexity within it:

```text
lib/
  main.dart
  app/
    app.dart
    bootstrap/        # first-frame startup and deferred app initialization
    router/           # typed go_router source of truth and generated routes
    runtime/          # root overrides and app runtime wiring
    shell/            # root shell composition
  core/
    bootstrap/        # startup-owned provider resources only
    constants/        # app-wide constants with real cross-feature use
    contracts/        # shared contract models with one source of truth
    data/
      network/        # DioClient, RequestExecutor, endpoint policy
      pagination/     # reusable paging primitives
    errors/           # AppError hierarchy
    feedback/         # AppFeedback
    hooks/            # reusable Flutter hook primitives
    perf/             # startup/frame/performance instrumentation
    result/           # Result
    runtime/          # lifecycle/performance policies
    services/         # real platform/app services, not feature adapters
    session/          # app-level session lifecycle contracts
    storage/          # cross-feature storage primitives only
    utils/            # audited, high-value utilities only
  features/
    <feature>/
      route_entry.dart
      data/           # API, DTOs, local DB, mappers, repositories
      domain/         # entities only when they carry business meaning
      application/    # generated providers, controllers, workflows
      presentation/   # pages/widgets/view-specific state only
  ui/
    assemblies/
    responsive/
    theme/
    widgets/
  i18n/
  protos/
```

No `shared/` directory, no feature-owned compatibility shims in `core/`, and no
empty service/manager/helper layers.

## New Architecture

Phase 38 architecture is a consolidation of the current design, not a new
parallel architecture.

- `app/` owns startup, root overrides, router, first-frame/deferred init, and
  shell composition.
- `core/` owns only cross-feature primitives with runtime value:
  `AppError`, `Result`, `RequestExecutor`, `DioClient`, feedback, session
  lifecycle contracts, bootstrap resources, and platform services.
- `features/<feature>` owns feature DTOs, repositories, mapping, state,
  workflows, UI, and route entry points.
- `ui/` owns reusable widgets and visual primitives. It must not encode feature
  business rules.
- Riverpod source of truth is generated `@riverpod` providers. Mutable or async
  state belongs in generated `Notifier` or `AsyncNotifier` classes.
- Widgets may call notifier methods, but must not own business workflows.
- go_router source of truth remains typed route data under `app/router` plus
  feature `route_entry.dart` files.
- Network source of truth remains `RequestExecutor` + `AppError` + `Result`;
  feature repositories keep only feature mapping and endpoint-specific logic.
- Data DTOs are transport/local persistence types. Presentation/application may
  use DTOs only when the feature explicitly promotes that DTO as the feature's
  contract. Otherwise, introduce one application/domain read model and delete
  duplicate DTO-shaped models.
- Startup has two phases:
  - First-frame bootstrap: only resources required before rendering, currently
    `WidgetsFlutterBinding`, locale setup, system UI style, and
    `SharedPreferences`.
  - Deferred/lazy resources: network cookie/cache stores, media services,
    prefetch queues, and other non-first-frame resources.

## Specs

1. Preserve current top-level architecture boundaries.
2. Keep only one active architecture spec and one active plan.
3. Archive superseded architecture specs/plans instead of keeping multiple
   active drafts.
4. Keep `core/contracts` as the only shared contract model location.
5. Remove DTO leakage from presentation/application feature by feature.
6. Keep generic network error/result policy centralized in `RequestExecutor`.
7. Do not refactor `RequestExecutor` and `PlayerController` in the same phase.
8. Split startup resources so first frame does not wait on network cache/cookie
   filesystem setup.
9. Keep feature route public API narrow: `route_entry.dart` plus explicitly
   justified root feature seams.
10. Do not introduce unused dependencies, unused extension points, placeholder
    services, or compatibility shims.
11. Update architecture baselines when file counts or guard fixtures change.
12. Run architecture guards and GitNexus change detection before commit.

## Delete, Merge, Or Archive List

Archive now:

- `docs/specs/2026-05-19-phase37-modern-architecture-consolidation.md`
- `docs/plans/2026-05-19-phase37-modern-architecture-consolidation.md`

Keep for now:

- `docs/architecture/phase30-application-seam-inventory.md`, because
  architecture guards still reference it.
- `docs/architecture/phase30-presentation-data-inventory.md`, because it is
  baseline evidence referenced by the architecture guide.
- `core/contracts`, because it is the current shared model source of truth.

Merge or delete in follow-up slices:

- DTO-shaped presentation/application state in `video`, `dynamic`, and `live`.
- Search duplicate names around `data/dtos/search_result.dart` and
  `application/search_result.dart`.
- Inline API base URL literals in `search_api.dart` and `auth_api.dart`.
- Dynamic route ownership drift in `app_notification_routes.dart`.
- One-call feature action adapters that only forward to another provider.
- Utility files that do not show real shared value after reference audit.

Do not touch in Phase 38 first slice:

- `RequestExecutor` internals.
- `PlayerController` internals.
- Dynamic route movement; `DynamicDetailRoute` has high impact and needs its
  own route migration slice.
- Generated route graph shape beyond necessary codegen.

## First Phase Direct Refactor Steps

1. Archive Phase 37 active docs and activate this Phase 38 spec/plan.
2. Update `architecture-guide.md` with Phase 38 as the only active source and
   refresh file-count baseline.
3. Run GitNexus impact analysis for startup symbols before edits:
   `main`, `AppBootstrap`, `cacheStore`, `cookieJar`, `sharedPreferences`,
   and `DioClient` if network wiring changes.
4. Split bootstrap resources:
   - keep `SharedPreferences` override before `runApp`;
   - move `PersistCookieJar` and `FileCacheStore` creation out of
     first-frame bootstrap;
   - preserve provider APIs unless impact analysis shows a low-risk migration.
5. Normalize shell visual effects to the default performance policy unless a
   dedicated UX reason justifies an opt-out.
6. Do not move dynamic routes in this first slice; the ownership drift is real
   but the route impact is high enough to isolate.
7. Add focused startup/provider tests for lazy network resources if provider
   behavior changes.
8. Run codegen if Riverpod provider signatures change.
9. Run focused architecture/startup tests, then broaden to analyze/test based on
   blast radius.
10. Create or update bd issues for remaining DTO/SSOT/router/player follow-up
    work.

## Acceptance Criteria

- Exactly one active architecture spec and one active architecture plan exist.
- Phase 37 active docs are archived as superseded.
- `architecture-guide.md` points to Phase 38.
- First-frame bootstrap no longer performs avoidable network cache/cookie
  filesystem setup.
- No `lib/shared/` directory or shared compatibility shim is introduced.
- No new `TODO()`, `UnimplementedError`, empty service/manager/helper, or
  unused dependency is introduced.
- GitNexus impact is reported before code edits.
- Architecture guards and relevant tests pass or blockers are documented with
  exact command output.
