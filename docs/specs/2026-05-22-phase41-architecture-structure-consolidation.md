# Phase 41 Architecture Structure Consolidation Spec

Status: Active architecture spec for Phase 41.

Tracking issue: pending bd issue for this phase; related ready issues include
`culcul-ann`, `culcul-3hh`, `culcul-6r8`, `culcul-ep5`, `culcul-9py`,
`culcul-ddw`, `culcul-ed2`, and `culcul-96b`.

## Current Problem Analysis

Culcul already uses a modern Flutter stack: Riverpod 3 generated providers,
typed `go_router`, Dio/Retrofit, Freezed/JSON, Drift, Slang, and architecture
guard tests. Phase 41 should consolidate the architecture that exists instead
of introducing another layered framework.

The refreshed inventory shows 942 Dart files, including 659 authored files in
`lib/`. The largest authored areas are `features/video`, `features/dynamic`,
`features/notification`, `features/profile`, `features/live`, and
`features/search`.

Primary problems to address:

1. Some presentation code still imports same-feature data implementation files,
   which makes controller tests harder and hides repository ownership.
2. Cross-feature application/session access is still broader than needed.
3. Search, video, dynamic, live, and notification contain DTO-like runtime
   models or parallel result types that are not clearly owned by one layer.
4. Endpoint paths and request policies are partly centralized, but Retrofit
   APIs still carry hard-coded paths and local request behavior.
5. Generic network decoding and error conversion mostly belong to
   `RequestExecutor` and `AppError`, but local repositories still contain
   repeated conversion logic.
6. Startup and runtime performance debt remains around global keep-alive
   providers, cache lifetime, live socket parsing, and media controller
   lifecycle.
7. Utility/helper files exist in both `core` and feature presentation areas.
   They should stay only when they remove real duplication or express a domain
   rule that needs one source of truth.
8. Previous architecture phases are useful history, but only the current active
   spec and plan should guide new changes.

Context7 references consulted for current ecosystem direction:

- Flutter architecture guidance: treat the recommended layers as adaptable
  guidelines, keep UI rebuild scopes small, and place state consumers deep in
  the widget tree.
- Riverpod 3 guidance: keep `ProviderScope` at the root, prefer generated
  providers, model async state with `AsyncValue`, and use provider overrides
  for testing.
- `go_router` guidance: keep a declarative router source of truth through
  `MaterialApp.router` and typed route definitions.

## Recommended Directory Structure

The top-level source layout remains:

```text
lib/
  main.dart
  app/
  core/
  features/
  ui/
  i18n/
  protos/
```

The desired feature layout is:

```text
lib/features/<feature>/
  route_entry.dart
  <feature>.dart
  domain/
    entities/
    ports/
    value_objects/
  application/
    controllers/
    workflows/
    models/
  data/
    remote/
    local/
    dtos/
    mappers/
    repositories/
  presentation/
    pages/
    widgets/
    view_models/
```

Rules for this structure:

1. `route_entry.dart` is the app/router-facing seam for page builders.
2. `<feature>.dart` exists only when it exports a real public feature API.
3. `domain/entities` is for behavior-bearing domain types, not API response
   mirrors.
4. `application/models` is for runtime state models used by controllers or
   workflows, not DTOs.
5. `data/dtos` owns transport shapes and generated JSON mapping.
6. `data/repositories` owns implementation of feature repository ports.
7. `presentation/view_models` may depend on repository ports/providers, not
   concrete data implementation files.

## New Architecture

### Dependency Direction

Allowed direction:

```text
app -> feature route_entry/public API
presentation -> application/domain/ui/core contracts
application -> domain/core contracts/core result
data -> domain/core data/core errors
core -> no features
ui -> no features
```

Disallowed direction:

```text
core/ui -> features
feature presentation -> another feature presentation/data
feature presentation -> same feature data implementation
feature data -> feature presentation
```

### State Management

Riverpod generated `@riverpod` providers are the source of truth for new and
rewritten state. No handwritten `Provider`, `FutureProvider`, `StateProvider`,
`NotifierProvider`, or one-off wrapper provider should be added.

Widgets should read state and call controller/workflow methods. Business rules,
request sequencing, pagination, cancellation, and stale async protection belong
in generated controllers, application workflows, or repository methods.

`AsyncValue` is the default UI-facing shape for async state. Avoid parallel
loading/error fields unless a screen genuinely needs partial sub-state.

### Routing

`lib/app/router` is the only route graph owner. Feature code exports route
builders through `route_entry.dart` and does not import app route definitions.

Route callback construction should be consolidated in app-owned route helpers
where impact is low. Symbols with HIGH or CRITICAL GitNexus impact, especially
profile route callbacks, require a dedicated slice with focused tests.

### Data And Models

Every concept has exactly one authoritative definition:

1. Shared app contracts live in `core/contracts`.
2. Transport responses live in feature `data/dtos`.
3. Runtime controller state lives in `application/models` or presentation
   state files when it is purely visual.
4. Domain entities exist only when they carry business behavior.
5. Generated types are authoritative; do not copy generated protobuf, Drift,
   Freezed, JSON, or route output into handwritten layers.

### Network, Errors, And Endpoints

`DioClient`, `RequestExecutor`, `ApiConstants`, `EndpointPolicy`, `AppError`,
and `Result` are the generic network/error source of truth.

Repositories should focus on feature mapping and feature-specific validation.
They should not repeat generic Dio exception handling, response decoding,
request deduplication, retry, cache policy, or status-code mapping.

Endpoint paths should be referenced from one source when practical. Retrofit
limitations may require literals in annotations, but repeated string values and
policy metadata should still be normalized through named constants.

### Performance

Phase 41 performance work is architecture-led:

1. Do less during `main` and defer non-critical init after first frame.
2. Avoid unbounded keep-alive provider families.
3. Keep heavy live socket decode and compressed packet parsing away from the
   UI-critical path where measurements justify it.
4. Make media controller ownership explicit and idempotent.
5. Keep Riverpod consumers scoped to the smallest widget subtree that needs
   the value.
6. Remove memory caches that duplicate repository, Drift, HTTP cache, or
   Riverpod cache behavior.

## Specs

Acceptance criteria for the phase:

1. Active docs point only at Phase 41, and Phase 40 docs are archived.
2. `lib/shared` remains absent.
3. `core` and `ui` import no `features` code.
4. Feature presentation does not import other feature data or presentation
   internals.
5. New or rewritten providers use generated Riverpod only.
6. No runtime placeholder providers, `TODO()`, or `UnimplementedError` remain
   in production code.
7. Each migrated concept has one source of truth and one owning layer.
8. Each code slice has GitNexus impact analysis before symbol edits.
9. Architecture guard tests cover each newly enforced rule.
10. Codegen, analyze, and focused tests pass for touched areas.

Non-goals:

1. No new product features.
2. No replacement of the current Flutter/Riverpod/go_router stack.
3. No compatibility shims after callers are migrated.
4. No empty service/manager/helper abstractions.
5. No broad live/player/profile edits without a dedicated risk slice.

## Delete, Merge, Or Archive Inventory

Archive:

1. `docs/specs/2026-05-22-phase40-architecture-ssot-modernization.md`
2. `docs/plans/2026-05-22-phase40-architecture-ssot-modernization.md`

Merge or delete after impact analysis:

1. Same-feature presentation imports of concrete data repositories.
2. Duplicate search transport/application result naming.
3. DTO-shaped state/read models that only mirror transport responses.
4. Repeated endpoint path literals and duplicated cache metadata.
5. Local generic request decoding/error conversion outside the network policy.
6. Utility files that only forward to a single function or hide obvious code.
7. Provider wrappers that exist only to call one repository method.
8. Unbounded keep-alive provider families and duplicate in-memory caches.

Keep:

1. `app/core/features/ui/i18n/protos` top-level layout.
2. Generated route, Riverpod, Drift, Freezed, JSON, Retrofit, Slang, and
   protobuf outputs.
3. Feature-local helpers that express real feature rules and have multiple
   callers.
4. App-level `route_entry.dart` seams and approved public APIs.

## First Phase Direct Execution

The first executable phase is deliberately narrow:

1. Archive Phase 40 docs and make Phase 41 the active architecture source.
2. Create or claim the bd issue that tracks the Phase 41 execution slice.
3. Run architecture tests to lock the current baseline.
4. Pick one low-risk code slice with clear ownership and focused tests.
5. Run GitNexus impact analysis for every target symbol before editing.
6. Add or tighten the guard that prevents the cleaned debt from returning.
7. Run focused tests, architecture guards, `make analyze`, and codegen only if
   generated inputs changed.
