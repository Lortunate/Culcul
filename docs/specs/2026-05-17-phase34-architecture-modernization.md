# Phase 34 Architecture Modernization Spec

## Status

Active.

Supersedes:

- `docs/specs/archive/2026-05-16-phase31-architecture-excellence.superseded.md`
- `docs/specs/archive/2026-05-17-phase33-architecture-consolidation.superseded.md`

Implementation plan:

- `docs/plans/2026-05-17-phase34-architecture-modernization.md`

Tracking issue:

- `culcul-fgn`: Phase 34 source-of-truth docs and archive update.

## Context

The app already uses the target top-level shape:

```text
lib/
  app/       app shell, bootstrap, router
  core/      infrastructure and cross-feature contracts
  features/  feature-owned data/application/presentation code
  ui/        reusable design-system and shared UI primitives
```

Current local audit before Phase 34:

- `lib/shared/`: absent.
- `core/` or `ui/` importing `features/`: 0.
- Cross-feature imports of another feature's `presentation/` or `data/`: 0.
- Feature presentation imports of feature `data/` or `protos/` from package imports: 0.
- Direct `ScaffoldMessenger.of`: only in `lib/core/feedback/app_feedback.dart`.
- Approved export-only files: `lib/core/contracts/core_contracts.dart` and `lib/ui/ui.dart`.

The remaining problem is not a broad directory rewrite. It is source-of-truth
cleanup: old active docs conflict with newer work, stale bd issues still point
at Phase 21/31 names, and several code slices still have duplicate models,
parameter wrappers, ad hoc API construction, or large mixed-responsibility
files.

## External Direction

Current docs checked through Context7:

- Flutter app architecture recommends clear separation between UI and data
  layers, with views, view models, repositories, and services owning distinct
  interfaces and boundaries.
- Riverpod 3 favors generated `@riverpod` providers plus `Notifier` and
  `AsyncNotifier` for mutable or async state. Widgets should call behavior via
  `ref.read(provider.notifier).method()` rather than owning business logic.
- go_router remains the routing source for deep linking, redirects, nested
  navigators, and shell routes. This project already uses generated typed
  routing, so routing should only change when a route boundary is broken.

## Goals

- Make Phase 34 the only active architecture source of truth.
- Archive superseded Phase 31 and Phase 33 docs.
- Close or supersede stale cleanup items through bd, not markdown task lists.
- Remove duplicate source definitions and no-value wrappers.
- Prefer modern generated Riverpod, typed go_router, Freezed 3, Dio/Retrofit,
  Drift, and Slang patterns already present in the project.
- Keep code easy to navigate: smaller focused files, direct imports, one real
  owner for every shared concept.

## Non-Goals

- Do not reintroduce `lib/shared/`.
- Do not add compatibility shims for removed local APIs.
- Do not add interfaces unless they enable mocking, polymorphism, or a real
  boundary.
- Do not rewrite go_router or Riverpod setup only for style.
- Do not regenerate protobuf Dart output unless `.proto` sources change and a
  documented protobuf tool path is added.

## Workstreams

### WS-1: Planning Source Of Truth

Archive Phase 31 and Phase 33 docs as superseded. Update `CLAUDE.md` and the
architecture guide to point at Phase 34 only.

### WS-2: Stale Branch Decision

Resolve `culcul-bgr` before code-heavy slices. Either merge useful commits from
old worktree branches with tests passing, or supersede the branches with an
explicit reason.

### WS-3: Duplicate And Wrapper Removal

Route these through existing bd issues:

- `culcul-i2u`: merge `AppException` into `AppError`.
- `culcul-8os`: inline `FavoriteFolderListQuery` and
  `FavoriteFolderResourcesQuery`.
- `culcul-f47`: fix `ToViewModelDto` business logic duplication.
- `culcul-28y`: flatten `SearchTrendingKeyword`.
- `culcul-1iv`: remove `PageQuery` and stale ranking category symbols.

### WS-4: API And Network Source

Route through `culcul-xoe`. Repositories and services must receive API clients
from providers or constructors. They must not instantiate `ResourceApi`, Dio
clients, or Retrofit APIs ad hoc.

### WS-5: Large File Decomposition

Route through `culcul-878`. Split only files where a new file owns real
behavior. Do not create part files, wrappers, barrels, or aliases that only move
complexity around.

Initial candidates from line-count audit:

- `lib/features/notification/data/notification_repository_impl.dart`
- `lib/features/video/presentation/detail/video_detail_view_model.dart`
- `lib/features/video/presentation/comments/video_comments_view_model.dart`
- `lib/features/video/data/video_repository_impl.dart`
- `lib/features/live/presentation/view_models/live_socket_service.dart`
- `lib/core/services/audio_handler.dart`
- `lib/core/services/comment_service.dart`

### WS-6: Analyzer Debt

Route through `culcul-xap` and `culcul-ojk`. Reduce info-level lint debt without
hiding analyzer rules and without adding new warnings.

## Hard Rules

- `app/`, `core/`, `features/`, and `ui/` stay as the top-level code shape.
- `core/` and `ui/` must not import `features/`.
- A feature must not import another feature's `presentation/` or `data/`
  internals.
- Shared contracts live in `core/contracts/`; feature-local DTOs live under the
  owning feature `data/dtos/`.
- `AppError` is the single error hierarchy.
- `core/feedback/app_feedback.dart` is the only feature-facing feedback API.
- Avoid new barrel files. Keep only `core_contracts.dart` and `lib/ui/ui.dart`
  as approved public export surfaces.
- New Riverpod work uses generated providers with `Notifier`/`AsyncNotifier`
  when state owns behavior.
- Simple features may omit `domain/` and `application/` when those directories
  would only pass calls through.

## Validation

Run the smallest relevant gate for each slice, then the phase gates:

```bash
dart run build_runner build
flutter test test/architecture --reporter compact
flutter analyze --no-fatal-infos
```

Before any commit that changes code, run GitNexus detection:

```text
gitnexus_detect_changes(scope: "all")
```

## Acceptance Criteria

- `CLAUDE.md` and `docs/architecture/architecture-guide.md` point to Phase 34.
- Phase 31 and Phase 33 spec/plan files are archived as superseded.
- Only one active spec exists under `docs/specs/`.
- Only one active plan exists under `docs/plans/`.
- Every implementation slice maps to a bd issue.
- No new generated-provider, route, contract, or feedback source-of-truth
  duplicates are introduced.
- Architecture tests pass after any code slice.
