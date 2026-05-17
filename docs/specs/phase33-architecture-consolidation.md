# Phase 33 Architecture Consolidation Spec

## Goal

Make the current app architecture easier to read and maintain by finishing the
remaining source-of-truth cleanup slices, deleting dead or duplicate code, and
keeping each concern owned by exactly one layer.

This phase is allowed to remove old compatibility shims and zero-value wrappers.
It must not preserve obsolete local APIs only for backwards compatibility.

## Current Baseline

- `lib/` is organized as `app/`, `core/`, `features/`, `ui/`, `i18n/`, and
  `protos/`.
- The project has 915 Dart files under `lib/` and 11 Dart tests.
- Active libraries already fit the target architecture: Riverpod 3,
  hooks_riverpod, go_router 17, Dio/Retrofit, Drift, Freezed, json_serializable,
  and build_runner.
- Phase 32 planning is complete. Its active docs are archived in this phase.
- Current guards already enforce core feature boundaries, domain/DTO separation,
  and centralized feedback usage.

## Open Cleanup Work

Phase 33 routes implementation through existing bd issues:

- `culcul-xoe`: standardize `ResourceApi` instantiation.
- `culcul-1iv`: remove ranking dead code and stale query/category names.
- `culcul-mt9`: extract shared `CommentService`.
- `culcul-phn`: unify notification/toast/feedback pattern.
- `culcul-3a4`: continue presentation-data boundary cleanup.
- `culcul-354`: update build_runner command docs for the removed flag.
- `culcul-xap` and `culcul-ojk`: reduce analyzer info debt after the
  architecture baseline.

## Impact Baseline

GitNexus impact was refreshed before this spec.

- `ResourceApi`: MEDIUM risk, 7 direct callers/importers, 34 total impacted
  symbols. Keep this as a focused network slice.
- `RankingCategory`: LOW risk, 2 direct importers, 4 total impacted symbols.
- `AppFeedbackContext`: HIGH risk, 22 direct importers, 69 total impacted
  symbols. Keep feedback cleanup as its own slice and do not mix it with other
  refactors.
- `rankingCategoriesV2` is not indexed as a symbol by GitNexus. Treat grep and
  architecture tests as the verification source for that value.

## Architecture Direction

### Routing Source

`app/router/` is the routing source of truth. Feature `route_entry.dart` files
may expose route entry points, but features must not duplicate route state or
path constants outside the app router.

### State Source

Riverpod is the only state source. New or rewritten mutable and async state
uses generated Notifier or AsyncNotifier classes when it owns behavior. Widgets
call behavior through `ref.read(provider.notifier).method()` and keep business
logic out of build methods.

Factory-only providers may remain simple generated provider functions when they
only wire dependencies.

### Network Source

Network clients are created by providers in `core/data/network/`. Repositories
and services must receive API clients from providers or constructors; they must
not instantiate `ResourceApi`, Dio clients, or Retrofit APIs ad hoc.

Endpoint paths have one source of truth. Shared endpoints belong in
`core/constants/api_constants.dart`; feature-specific endpoints stay inside the
owning feature API only when no other feature uses them.

### Comment Source

Comment contracts already live in `core/contracts/comment_contract.dart`.
Video and dynamic comment workflows must share a single comment service for the
common BiliBili reply endpoints. Article-specific cursor behavior remains in
the dynamic feature until it becomes shared by another feature.

### Feedback Source

`core/feedback/app_feedback.dart` is the only feature-facing feedback API.
Feature code must not call `ScaffoldMessenger.of` directly and must not add a
second toast/snackbar abstraction.

Because `AppFeedbackContext` is HIGH risk, changes here need a separate
review checkpoint and targeted architecture guard coverage.

### Ranking Source

Ranking category data has one source of truth. Remove stale names such as
`rankingCategoriesV2` when there is no active v1/v2 split. Do not add query
objects that only mirror simple parameters.

### Docs Source

Active docs live in `docs/specs/` and `docs/plans/`. Completed phase docs move
to the matching `archive/` directory with a `.completed.md` suffix. The Phase 30
application seam inventory remains at its current path because the architecture
guard still reads it.

## Boundaries

- `core/` may depend on packages, generated code, and shared contracts. It must
  not import `features/`.
- `ui/` stays feature-agnostic. It must not import feature internals.
- Feature `data/` owns Retrofit APIs, DTOs, local stores, and mappers.
- Feature `domain/` exists only for business behavior or durable contracts. It
  must not duplicate response-shaped DTOs.
- Feature `presentation/` owns widgets, pages, and view models. It may depend on
  feature application/domain code, `ui/`, and `core` contracts.
- Cross-feature application/domain imports must stay classified in the active
  seam inventory until the guard is replaced.

## Non-Goals

- No visual redesign.
- No navigation behavior rewrite.
- No backend API behavior change.
- No migration away from the existing mainstream stack unless a slice proves
  the existing library is the source of complexity.
- No compatibility wrappers for old local APIs.
- No movement of `docs/architecture/phase30-application-seam-inventory.md`
  without changing the guard in the same slice.

## Validation

Each implementation slice must run the smallest relevant verification first,
then the phase-level gates before close:

```bash
dart run build_runner build
flutter test test/architecture
flutter analyze --no-fatal-infos
```

Before any commit, run:

```text
gitnexus_detect_changes(scope: "all")
```

The removed build_runner conflict-output flag must not be used in new active
docs, plans, or scripts.

## Acceptance Criteria

- Phase 32 spec and plan are archived as completed docs.
- Phase 33 spec and plan are the only active phase docs under `docs/specs/` and
  `docs/plans/`.
- Every Phase 33 implementation target maps to a bd issue.
- High-risk feedback work is isolated from network/comment/ranking work.
- The plan uses modern Riverpod and go_router direction without adding new
  redundant abstractions.
- No app behavior changes are introduced by the docs/archive slice.
