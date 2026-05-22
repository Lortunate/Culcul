# Phase 41 Architecture Structure Consolidation Plan

Status: Active execution plan for Phase 41.

This plan executes the Phase 41 spec without adding product features or a
second architecture. Work is sliced so each change has a small blast radius,
GitNexus impact evidence, focused verification, and bd tracking.

## Execution Principles

1. Use bd for all tracking and follow-up work.
2. Keep old architecture docs in `docs/specs/archive` and `docs/plans/archive`.
3. Do not create markdown task checklists as issue tracking.
4. Before editing any function, class, or method, run GitNexus impact analysis
   upstream for the symbol and report direct callers, affected flows, and risk.
5. Stop and warn before HIGH or CRITICAL risk edits.
6. Prefer deleting or merging code over adding wrappers.
7. Add an architecture guard when a debt class is removed.
8. Run the narrowest useful tests first, then broaden based on impact.

## Current Baseline

Observed on 2026-05-22:

1. `lib/` contains 659 authored Dart files.
2. Top-level source folders are `app`, `core`, `features`, `ui`, `i18n`, and
   `protos`.
3. `lib/shared` is absent and must remain absent.
4. Feature folders are `auth`, `dynamic`, `favorites`, `history`, `home`,
   `live`, `notification`, `profile`, `ranking`, `search`, `settings`,
   `to_view`, and `video`.
5. `app/router` owns typed routes and imports feature `route_entry.dart` seams.
6. Direct handwritten Riverpod provider declarations were not found in the
   authored `lib` scan.
7. Direct feature `ScaffoldMessenger` use is blocked by feedback guards; the
   only current direct call is inside `core/feedback/app_feedback.dart`.
8. Existing ready issues already split major risk areas across network, route
   callbacks, endpoints, startup/cache, live socket parsing, and player
   lifecycle.

## Phase 1: Active Docs And Guard Baseline

Files:

1. Modify `docs/architecture/architecture-guide.md`.
2. Create `docs/specs/2026-05-22-phase41-architecture-structure-consolidation.md`.
3. Create `docs/plans/2026-05-22-phase41-architecture-structure-consolidation.md`.
4. Archive Phase 40 spec and plan under `docs/specs/archive` and
   `docs/plans/archive`.

Commands:

```bash
bash tool/architecture/run_architecture_guards.sh
flutter test test/architecture
```

Expected result:

1. Active guide points at Phase 41 only.
2. Phase 40 docs exist only under archive with `.superseded.md`.
3. Architecture tests pass or expose exact debt to carry into bd.

## Phase 2: App-Feature Runtime Seams

Related issue: `culcul-3hh`.

Goal:

Move broad cross-feature application/session access behind explicit runtime
contracts only where there is real product value. Remove one-call adapter seams
that only hide imports.

Candidate files:

1. `lib/core/session/**`
2. `lib/features/auth/**`
3. Feature `route_entry.dart` files.
4. Controllers that currently read auth/session providers directly.

Execution:

1. Query GitNexus for the exact seam symbol.
2. Run upstream impact on each edited symbol.
3. Replace concrete cross-feature imports with approved contracts or keep the
   import if it is the simplest honest ownership.
4. Add or update architecture guard coverage for the removed pattern.

Verification:

```bash
flutter test test/architecture
make analyze
```

## Phase 3: Routing Callback Consolidation

Related issue: `culcul-9py`.

Goal:

Consolidate duplicated app-owned route callback construction without changing
profile route behavior.

Candidate files:

1. `lib/app/router/routes/app_social_routes.dart`
2. `lib/features/profile/route_entry.dart`
3. `test/architecture/architecture_route_ownership_guard_test.dart`

Risk rule:

`UserProfileRoute` has previously shown CRITICAL impact. Do not fold it into a
low-risk cleanup. Use a dedicated test slice and stop before code edits if
GitNexus reports HIGH or CRITICAL risk again.

Verification:

```bash
flutter test test/architecture/architecture_route_ownership_guard_test.dart
make analyze
```

## Phase 4: Model And DTO Ownership

Goal:

Give each model concept one owning layer and delete duplicates after callers
move.

Candidate files:

1. `lib/features/search/data/dtos/search_result.dart`
2. `lib/features/search/application/search_result.dart`
3. `lib/features/video/presentation/detail/video_detail_state.dart`
4. `lib/features/video/presentation/comments/comment_reply_state.dart`
5. `lib/features/live/presentation/view_models/live_room_state.dart`
6. Feature DTO folders under `data/dtos`.

Execution:

1. Classify each candidate as transport DTO, application runtime model, visual
   state, or true domain entity.
2. Keep exactly one definition per concept.
3. Remove mapper layers that only copy identical fields without policy.
4. Add guard coverage if a repeated anti-pattern can be expressed reliably.

Verification:

```bash
flutter test test/architecture/architecture_domain_dto_guard_test.dart
make analyze
```

## Phase 5: Network, Error, And Endpoint Consolidation

Related issues: `culcul-ann` and `culcul-6r8`.

Goal:

Make `RequestExecutor`, `AppError`, `Result`, `DioClient`, `ApiConstants`, and
`EndpointPolicy` the generic network source of truth.

Candidate files:

1. `lib/core/data/network/request_executor.dart`
2. `lib/core/errors/app_error.dart`
3. `lib/core/data/network/api_constants.dart`
4. `lib/core/data/network/endpoint_policy.dart`
5. Feature Retrofit APIs under `lib/features/**/data/*_api.dart`
6. Feature repository implementations under `lib/features/**/data/*repository_impl*.dart`

Execution:

1. Start with a repository whose GitNexus impact is LOW or MEDIUM.
2. Move generic decode/error conversion into the shared path.
3. Leave feature-specific validation in the repository.
4. Normalize repeated endpoint path strings and policy metadata.
5. Delete obsolete local helpers immediately after migration.

Verification:

```bash
flutter test test/architecture
make analyze
```

## Phase 6: Startup And Runtime Performance

Related issues: `culcul-ep5`, `culcul-ddw`, `culcul-ed2`, and `culcul-96b`.

Goal:

Reduce startup work and runtime retention only where there is evidence of real
cost or lifecycle risk.

Candidate files:

1. `lib/main.dart`
2. `lib/app/bootstrap/**`
3. `lib/core/perf/frame_timing_sampler.dart`
4. `lib/core/data/network/dio_client.dart`
5. `lib/features/live/**`
6. `lib/features/video/presentation/player/**`

Execution:

1. Keep critical bootstrap minimal.
2. Defer non-critical init after first frame.
3. Audit keep-alive provider families and remove unnecessary retention.
4. Add cancellation/request-token checks around live async work.
5. Make player controller lifecycle idempotent.
6. Move heavy socket parsing off the UI path only when the threshold is clear.

Verification:

```bash
flutter test test/app/bootstrap/deferred_app_init_test.dart
make analyze
```

## Dependency And Tooling Follow-Up

Use package changes only when they remove real code or align with the existing
popular stack. Do not add dependencies during architecture cleanup unless the
same slice deletes more local complexity than it adds.

Potential checks:

1. `flutter pub deps`
2. `dart run build_runner build --delete-conflicting-outputs`
3. `dart run slang`
4. `dart format --output=none --set-exit-if-changed .`

## First Directly Executable Refactor Steps

The first code slice after this documentation update should be low-risk and
guardable:

1. Claim or create the bd issue for Phase 41 documentation and first slice.
2. Run `flutter test test/architecture`.
3. Select the smallest target from `culcul-3hh`, `culcul-ann`, or `culcul-6r8`
   after GitNexus impact analysis.
4. Edit only the selected slice.
5. Run its focused tests and architecture guards.
6. Run `make analyze`.
7. Run GitNexus detect changes before commit.
