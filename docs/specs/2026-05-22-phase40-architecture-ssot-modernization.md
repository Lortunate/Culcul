# Phase 40 Architecture SSOT Modernization Spec

Status: Active architecture spec for Phase 40.

Issue tracking remains in `bd`. This document records product and architecture
decisions only; it is not a task tracker.

## Current Problem Analysis

The project is already on a modern Flutter stack: Dart 3.10+, Flutter 3.44,
hooks_riverpod/Riverpod code generation, go_router typed routes, Dio/Retrofit,
Freezed/json_serializable, Drift, Slang, and architecture guard tests. The
highest-value modernization is therefore not replacing the stack. The priority
is making ownership and dependency direction consistent.

Current problems found in the Phase 40 audit:

Current inventory baseline, refreshed on 2026-05-22 after the route-entry seam
slice:

- `lib` has 898 Dart files; 241 are generated outputs and 657 are authored
  source files.
- Feature size hotspots are `video`, `dynamic`, `notification`, `profile`, and
  `live`.
- Current path/name scan found 108 model/entity/domain-shaped files, 42 DTO
  files, 87 view-model files, 35 repository files, 16 provider files, and 9
  contract files.
- 84 authored files still contain JSON transport markers such as `fromJson`,
  `toJson`, or `Map<String, dynamic>`.
- 32 authored files still import another feature directly; remaining cases must
  move behind `route_entry.dart`, narrow contracts, or app-level composition.
- Exact duplicate class names are not the main risk; semantic duplication and
  transport ownership leakage are.

1. Feature boundaries are still inconsistent. There are many `presentation -> data`,
   `application -> data`, and `data -> application` imports, so layers are not
   reliably communicating through domain ports or feature composition.
2. `application/models` is overloaded. Some files are API response shapes or DTOs
   living in the application layer, which reverses data ownership and creates
   duplicate model concepts. Concrete offenders include dynamic response models,
   live room detail models, and video subtitle models.
3. Routing is moving in the right direction but is not fully sealed. `app/router`
   should own typed route construction, while feature pages receive callbacks.
   The first route-entry guard slice is complete, but Profile callback
   consolidation remains a separate test-backed slice because `UserProfileRoute`
   has CRITICAL GitNexus blast radius.
4. Session/auth state fans out through auth-specific providers. Features should
   depend on narrow session contracts or app composition rather than importing
   auth internals directly.
5. Endpoint source of truth is split between central constants and hard-coded
   Retrofit paths. Cache policy, request policy, and endpoint constants can drift.
6. Network decoding/error conversion has more than one expression path. Generic
   Dio failure conversion belongs in `RequestExecutor`/`AppError`; repositories
   should focus on feature DTO and domain mapping.
7. Some retained state and global runtime helpers may increase memory lifetime:
   many `@Riverpod(keepAlive: true)` family providers, static image prefetch
   queues, frame-timing callbacks, and runtime performance listeners need explicit
   lifetime review.
8. Search currently has a duplicate DTO/domain result hierarchy:
   `features/search/data/dtos/search_result.dart` mirrors
   `features/search/application/search_result.dart`, with mapper code preserving
   two similar concepts.
9. Bilibili link parsing is duplicated in dynamic and notification presentation
   widgets. The link target shape should have one parser while feature-specific
   opening callbacks stay local to routing/presentation.
10. Pagination and comment state have parallel implementations across
   `core/data/pagination`, UI comment assemblies, video replies, and dynamic
   comments. New list controllers should converge on one paging state model.
11. Live room and player lifecycle code has concrete retained-resource risks:
   room-scoped danmaku feeds are kept alive, live room initialization can write
   after disposal, live socket parsing can run heavy decode work on the UI
   isolate, and player build wiring is not clearly idempotent.
12. Article paragraph rendering recreates gesture recognizers during rebuilds,
    which is a measurable long-article rebuild hotspot.
13. No obvious unused Dart source file is safe to delete from import-graph evidence
    alone. Deletion must be based on ownership migration, not filename guesses.
14. Core contracts currently include JSON-enabled shared shapes. They have high
    blast radius and are not a first-slice migration target.
15. The previous `live` presentation dependency on `app/bootstrap` has been
    retired through the media runtime move into `core/runtime`; guards must keep
    feature and core code from reintroducing app-bootstrap imports.

## Recommended Directory Structure

The target stays feature-first and intentionally avoids empty service/manager/helper
layers.

```text
lib/
  main.dart
  app/
    app.dart
    bootstrap/
    router/
      app_routes.dart
      routes/
  core/
    contracts/
    data/
      network/
      storage/
    errors/
    perf/
    result/
    session/
  ui/
    theme/
    widgets/
    assemblies/
    ui.dart
  features/
    <feature>/
      <feature>.dart          # only when it exports a real public API
      route_entry.dart        # router-facing page builders only
      domain/
        entities/
        ports/
      application/
      data/
        dtos/
        mappers/
        remote/
        local/
      presentation/
        pages/
        widgets/
        view_models/
  i18n/
  protos/
```

Directory rules:

- `app/` owns process startup, root overrides, app shell, and typed navigation.
- `core/` owns shared infrastructure and narrow contracts; it must not import
  `features/`.
- `ui/` owns reusable visual primitives and approved UI assemblies; it must not
  import `features/`.
- A feature owns its own data/application/domain/presentation code.
- Feature public seams stay small: `route_entry.dart` for router composition and
  `<feature>.dart` only for real product APIs.
- Generated files stay next to their source files and are not hand-maintained.

## New Architecture

### Dependency Direction

- `presentation -> application/domain/ui`
- `application -> domain/core contracts`
- `data -> domain/core network`
- `app -> features route_entry/public APIs`
- `core/ui -> no features`

Temporary exceptions must be covered by architecture guard allowlists with an
owning bd issue. Exceptions are removed as soon as the migration lands.

### State Management

Riverpod generated providers are the state-management source of truth. New or
rewritten state uses `@riverpod`, `Notifier`, or `AsyncNotifier`. Widget code
delegates business mutations to controllers/notifiers rather than duplicating
workflow logic.

`keepAlive: true` is not a default. Family providers that cache per-user, per-room,
or list data need either auto-dispose behavior or a documented retention reason.

### Routing

`go_router` typed routes in `lib/app/router` are the navigation source of truth.
Feature pages and widgets do not import `app/router/app_routes.dart` and do not
construct cross-feature routes directly. They receive explicit callbacks from
route composition or use a narrow feature/domain port when navigation is not the
right abstraction.

The current dirty worktree already contains route callback migrations across
home, dynamic, notification, profile, search, video, ranking, settings, history,
favorites, live, and to_view. Phase 40 should finish and verify that direction,
not introduce a competing routing abstraction.

### Data And Models

DTOs live in `data/dtos`. Domain entities live in `domain/entities` only when
they carry product meaning or behavior. If a domain type merely mirrors a DTO
and adds no value, merge it instead of maintaining two concepts.

Shared cross-feature models live in `core/contracts` only when they are truly
shared contracts. They are high-blast-radius and require impact analysis before
shape changes.

### Network, Errors, And Endpoints

`DioClient`, `RequestExecutor`, `Result`, and `AppError` are the generic network
and error policy path. Repositories own endpoint-specific DTO/domain mapping,
not generic Dio failure conversion.

Endpoint paths and cache policy must have one source of truth. Central constants
and hard-coded Retrofit annotations must not disagree. Duplicate or unused
constants are deleted after callers are migrated.

### Performance

Performance work targets measured lifetime and rebuild cost:

- Prefer lazy builders and const constructors where applicable.
- Avoid synchronous heavy JSON decode on UI-critical paths unless profiling
  proves isolate overhead is worse.
- Review global/static listeners and queues for teardown and hot-restart safety.
- Avoid unbounded retained provider families.

## Specs

Phase 40 succeeds when:

1. Active architecture docs have one visible source of truth for Phase 40.
2. Superseded architecture/spec/plan documents are under `docs/**/archive`.
3. Feature UI no longer imports `app/router/app_routes.dart`.
4. Feature UI no longer performs raw cross-feature route construction where app
   route composition can inject callbacks.
5. Architecture guards block new `presentation -> data` imports unless explicitly
   allowlisted during migration.
6. Architecture guards block new `data -> application` imports unless explicitly
   allowlisted during migration.
7. API-shaped `application/models` are moved to `data/dtos` or merged into
   domain entities when the domain type has real value.
8. Shared endpoint constants and Retrofit annotations have a single owner.
9. Generic network error conversion has one implementation path.
10. Session/auth access from features is through a narrow contract or composition
    API, not broad auth internals.
11. Runtime provider retention is reviewed for `keepAlive: true` families.
12. Static caches/listeners have explicit lifecycle cleanup or documented app-wide
    lifetime.
13. No empty service/manager/helper/facade is introduced.
14. No compatibility shim remains after callers migrate.
15. No dead implementation is archived under `lib/archive`.
16. `flutter analyze --no-pub` stays clean.
17. Focused architecture tests pass.
18. GitNexus `detect_changes(scope: "all", repo: "Culcul")` is run before commit.
19. `culcul-ory` has at least one completed DTO ownership migration pattern with
    generated code refreshed and tests proving the new boundary.
20. `app/router` imports only feature `route_entry.dart` or deliberate feature
    public APIs, not files under `presentation/**`.
21. Feature presentation does not import `app/bootstrap/**`.

## Executed DTO Ownership Patterns

Video subtitles and live side-data models are the current low-risk migration
examples:

- Video subtitle transport parsing lives in `features/video/data/dtos`, while
  `features/video/application/models/subtitle.dart` is a JSON-free runtime model.
- Live danmu WebSocket connection info transport parsing lives in
  `features/live/data/dtos`, while
  `features/live/application/models/live_danmu_info_model.dart` is a JSON-free
  runtime model consumed by socket/presentation code.
- Live gold rank and guard list transport parsing live in `features/live/data/dtos`,
  while their application models remain the JSON-free read models used by live
  room state and header rendering.
- Dynamic publish response and image upload transport parsing live in
  `features/dynamic/data/dtos/dynamic_publish_response_dto.dart`, and the old
  `DynamicPublishData`/`DynamicUploadImageData` application response shapes are
  retired.
- `LiveApi.getDanmuInfo` returns a DTO; `LiveRepositoryImpl.getDanmuInfo` is the
  single mapper from DTO to application model.
- `LiveApi.getOnlineGoldRank` and `LiveApi.getGuardList` also return DTOs; their
  repository methods are the only DTO-to-application mapping points.
- The architecture guard list marks all migrated application model files as
  JSON-free so future `fromJson`, `toJson`, and `JsonKey` reintroduction fails
  focused tests.

The next similar low-risk candidates should move outside live unless another
small live response shape is needed for a local change: favorites folder,
history entry, and to_view DTO/entity duplication remain good `culcul-ory`
follow-ups.

## Delete, Merge, Or Archive Inventory

Archive documentation, not runtime code:

- Keep Phase 40 spec/plan and `docs/architecture/architecture-guide.md` active.
- Keep Phase 39 and older superseded phase docs under `docs/specs/archive` and
  `docs/plans/archive`.
- Do not create `lib/archive`. Old implementation code is deleted after migration.

Delete after migration:

- Duplicate/unused endpoint constants such as duplicate `nav`/`userInfo` and
  unused cookie endpoint constants after auth refresh ownership is confirmed.
- `lib/core/data/network/api_response_decoder.dart` if its behavior is merged
  into `RequestExecutor` or a private manual-Dio adapter.
- Low-value wrappers/adapters/facades that only forward one call and no longer
  enforce policy.
- Architecture guard allowlist entries immediately after the covered migration.
- Compatibility route or provider shims after all callers move.
- Non-route feature barrels after consumers move to `route_entry.dart` or a named
  public contract.

Merge candidates:

- Endpoint paths and request/cache policy into one endpoint source of truth.
- DTO/domain pairs where the domain entity is a field-for-field mirror without
  behavior, starting with smaller features such as favorites, history, and to_view.
- Repeated manual network result/error conversion into `RequestExecutor`/`AppError`.
- Auth/session read access into a narrow session contract for feature consumers.
- Search result DTO/domain mirror hierarchies into one source of truth.
- Dynamic and notification Bilibili URL parsing into one shared parser/target
  contract with feature-owned navigation callbacks.
- Comment/reply/favorites/list pagination flows onto one paging state model and
  one set of state transition helpers.
- API-shaped `application/models` into `data/dtos`, starting with the smallest
  provable case before touching dynamic response or core contracts.
- Notification/dynamic navigation target parsing out of `presentation/widgets`
  into named feature contracts or app-owned route composition.

Do not delete yet:

- `media_kit_libs_video`, `sqlite3_flutter_libs`, `protobuf`, `fixnum`, or `intl`
  solely because they have no direct Dart imports; they are native/codegen/runtime
  support candidates and require platform validation.
- Large generated files; they are codegen output, not architecture duplication.

## First Phase Direct Execution

Completed first executable boundary slice:

1. Update active Phase 40 docs with the current audit findings.
2. Cut the low-risk app bootstrap leak first: move media runtime initialization
   to `core/runtime` and guard against future `core` or feature imports of
   `app/bootstrap`.
3. Cut the low-risk notification route leak: move notification navigation parsing
   out of `presentation/widgets` and guard `app/router` so it only imports
   feature `route_entry.dart` public APIs.
4. Defer Profile callback consolidation because GitNexus reports
   `UserProfileRoute` as CRITICAL blast radius; split it into a dedicated test
   slice before editing.

Next executable slice:

1. Refresh Phase 40 docs and bd notes so completed work is not listed as
   immediate work.
2. Choose one remaining low-risk ownership seam:
   - Profile route callback consolidation under `culcul-9py`, after impact
     review and focused route tests;
   - DTO/application model continuation under `culcul-ory`, starting with the
     smallest mirror model still carrying transport ownership;
   - network response/error consolidation under `culcul-ann`, starting with a
     single repository path and `RequestExecutor` tests.
3. Add or tighten a failing architecture/unit test for the selected seam before
   editing production code.
4. Run focused tests, architecture guards, `flutter analyze --no-pub`, and
   GitNexus `detect_changes(scope: "all", repo: "Culcul")`.
5. Fix format/codegen drift after the boundary moves, then run focused
   architecture tests.
6. Use `culcul-ory` for the next owned data slice after the boundary work is
   green; start with a low-risk DTO/model mirror and regenerate code.
7. Run `flutter analyze --no-fatal-infos`, architecture guards, focused feature
   tests, and GitNexus `detect_changes(scope: "all", repo: "Culcul")`.
8. Use `bd` to close or update the corresponding issues after validation.
