# Phase 36 Aggressive Architecture Cleanup Spec

## Status

Active.

This is the only active architecture cleanup spec for Phase 36.

Tracking:

- `culcul-rg4`: Phase 36 aggressive architecture cleanup.
- Child work items: `culcul-4ir`, `culcul-rzy`, `culcul-psp`, `culcul-fpl`.

Supersedes older Phase 35 architecture cleanup direction. Do not mix Phase 35
rules into new work.

## Current App Boundary

Culcul is a Flutter media/content app. Current product boundaries are:

- auth/session and current user state.
- home, search, ranking, history, favorites, watch-later style content lists.
- video playback/detail, dynamic/article detail, live content.
- profile/social/notification flows.
- settings, theme, localization, app shell, routing.

No new product features belong in this phase.

## Current Problems

Current audit signals:

- `lib/` has about 890 tracked source/generated files.
- Largest feature areas: `video` 144 files, `dynamic` 106 files,
  `notification` 88 files, `profile` 69 files, `live` 66 files.
- Naming smells in current scan: 169 `model*` files, 30 `dto*` files,
  3 `entity*` files, 49 `repository_impl*` files, 114 `view_model*` files,
  8 mapper files, 6 helper files, 7 util files, 239 generated Dart files.
- Some presentation code imports data DTOs directly, which weakens feature
  boundaries and makes model ownership unclear.
- Some repository implementations are split into many partial helper/service
  files, especially notification and video, raising reading cost.
- Cross-cutting concepts already exist but must stay singular: contracts,
  app errors, typed results, app feedback, route ownership, storage keys,
  network/cache policy, runtime performance policy.

## Architecture Goals

- Keep every concept owned by exactly one source of truth.
- Reduce source count by deleting dead wrappers and compatibility seams.
- Make directory ownership obvious from the path.
- Prefer concrete implementations over interfaces when there is one
  implementation.
- Keep feature internals feature-owned and private unless another feature has a
  proven need.
- Use current Flutter/Riverpod/go_router/Drift practices already present in the
  dependency set instead of adding new architectural frameworks.
- Improve startup, rebuild, cache, stream, and media resource behavior by
  removing unnecessary work first.

## Directory Structure

Target macro structure:

```text
lib/
  main.dart
  app/
    app.dart
    bootstrap/
    router/
    runtime/
    shell/
  core/
    contracts/
    data/
      network/
      pagination/
    errors/
    feedback/
    perf/
    result/
    services/
    session/
    storage/
  features/
    <feature>/
      data/
        api/
        dtos/
        local/
        repositories/
      application/
        providers/
        controllers/
      presentation/
        pages/
        widgets/
        view_models/
      domain/
        entities/
        policies/
  ui/
    theme/
    widgets/
    responsive/
  i18n/
  protos/
```

Rules:

- `domain/` is optional. Use it only for behavior or policy that is not a DTO.
- `data/local/` owns feature Drift tables, DAOs, persistence adapters, and
  migrations.
- `data/dtos/` owns remote payload shapes.
- `application/` owns Riverpod providers and coordination that is not UI.
- `presentation/` owns pages, widgets, and view models.
- `core/` and `ui/` must not import from `features/`.
- A feature must not import another feature's `data/` or `presentation/`.

## Data Flow

Default flow:

```text
UI widget
  -> generated Riverpod provider/view model
  -> feature repository or feature use case
  -> API client / Drift DAO / platform service
  -> DTO or local row
  -> shared contract or feature state
  -> AsyncValue / Result
  -> UI
```

Exceptions must be local, documented in the owning feature, and justified by
lower complexity.

## State Management

- Root state is installed through `ProviderScope` in `main.dart`.
- New or rewritten providers use generated `@riverpod`.
- Mutable state uses generated `Notifier`.
- Async mutable state uses generated `AsyncNotifier`.
- One-shot reads use provider functions or repositories, not ad hoc global
  singletons.
- UI handles `AsyncValue` directly for loading/error/data states.
- Provider aliases are not allowed unless they replace duplicated ownership and
  are removed in the same phase.

## Error Handling

- `AppError` is the single app error hierarchy.
- `Result` is the single typed result wrapper.
- UI feedback goes through `AppFeedback`.
- Repositories convert network/storage/platform failures at the boundary.
- Presentation code must not duplicate error mapping strings or retry policy.

## Configuration

- `ApiConstants` owns API constants.
- `storage_keys.dart` owns persisted key names.
- Runtime policy lives under `core/runtime` and `core/perf`.
- Feature-specific constants stay in the owning feature when they are not shared.

## Persistence

- Shared preference keys have one owner in `core/storage`.
- Drift database access is feature-owned unless the data is cross-feature.
- DAOs are preferred for non-trivial queries.
- Local read caches must have explicit lifecycle and eviction rules.
- Do not add memory caches unless profiling shows repeated expensive work.

## Performance Targets

- Startup work after `runApp` is deferred when it is not required for first
  paint.
- Lists avoid broad provider watches that rebuild whole pages.
- Image/cache and media resources are disposed at feature lifecycle boundaries.
- Stream providers expose the narrowest useful stream.
- JSON parsing and heavy transforms use existing compute helpers only when they
  remove measurable main-isolate work.
- Prefer deleting repeated computation over adding caches.

## Removed Or Forbidden

- No compatibility shims for removed internal APIs.
- No export-only barrels that hide ownership.
- No empty service, manager, helper, adapter, facade, or utils layer.
- No duplicate DTO/model/entity definitions for the same payload.
- No repository interface with one implementation unless tests or platform
  substitution prove value.
- No feature public seam without a concrete cross-feature caller.
- No markdown task tracking. Use `bd`.

## Archive Strategy

- Superseded specs and plans move to `docs/specs/archive/` and
  `docs/plans/archive/`.
- Old code is not archived in `lib/`. If it has no caller, delete it.
- If a temporary archive is required for human review, put it under
  `archive/phase36/<date>/` with a deletion issue in `bd`.
- Generated files are regenerated, not hand-edited or archived.

## Validation

Every code slice must run:

- GitNexus impact before editing any function, class, or method.
- Context7 before changing Flutter, Riverpod, go_router, Drift, Dio, Retrofit,
  Freezed, Slang, or build_runner API usage.
- `dart run build_runner build --delete-conflicting-outputs` when generated
  inputs change.
- `dart format` or the Dart MCP formatter for touched Dart files.
- `flutter analyze` or Dart MCP analyze.
- Focused tests for touched feature paths.
- Architecture guards.
- GitNexus `detect_changes(scope: "all")` before commit.

## Acceptance Criteria

- The active spec and plan are current and linked from architecture docs.
- Every touched concept has one owner and no compatibility copy.
- Removed files have no imports or generated references.
- Analyzer, architecture guards, and focused tests pass.
- GitNexus change detection reports only intended symbols and flows.
- Work is committed and pushed before the session is closed.
