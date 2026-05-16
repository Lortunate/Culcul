# Phase 32 Source-of-Truth Consolidation Spec

Status: active draft
Created: 2026-05-16
Tracking: `culcul-zpy`

## Goal

Reduce architecture surface area by removing duplicate models, duplicate error
hierarchies, dead files, parameter-only DTOs, and direct infrastructure
construction. The app should keep one true source for each concept and use
modern Riverpod/provider boundaries instead of local ad hoc wrappers.

## Current Baseline

- Flutter/Dart app with Dart SDK `^3.10.7`.
- Main libraries already in use: Riverpod 3, hooks, go_router 17,
  go_router_builder, retrofit, Drift, slang, Freezed, and json_serializable.
- GitNexus index refreshed on 2026-05-16: 9,277 nodes, 20,621 edges,
  179 flows. Optional proto grammar is unavailable; Dart graph is usable.
- Existing architecture guards enforce:
  - No cross-feature presentation imports.
  - No cross-feature data implementation imports.
  - Presentation code must not import same-feature data implementations.
  - Cross-feature application/domain imports must be classified in the Phase 30
    seam inventory.
  - `core` and `ui` must not import feature internals.
  - Domain entities must not contain DTO or response-shaped code.
  - Domain entities must not import feature data DTOs.
  - Feature code must not call `ScaffoldMessenger.of` directly.
- The repository currently has no active `docs/specs/*.md` or
  `docs/plans/*.md` pair. The only architecture document is
  `docs/architecture/phase30-application-seam-inventory.md`, which is still
  read by `test/architecture/architecture_boundary_guard_test.dart`.

## Non-Goals

- Do not redesign UI screens or navigation behavior.
- Do not replace established libraries already in the project.
- Do not preserve deprecated compatibility shims when they only keep old local
  abstractions alive.
- Do not move the Phase 30 inventory path until the guard test is updated in
  the same code slice.
- Do not modify existing dirty user files: `AGENTS.md`, `CLAUDE.md`, or
  `.claude/skills/gitnexus/gitnexus-cli/SKILL.md`.

## Architecture Direction

### Error Source

`AppError` becomes the single app error type. `AppException` and
`exceptions.dart` are removed. Throwing code uses `AppError` factories directly,
and UI feedback continues through the central feedback implementation.

Success means there is one error hierarchy, one feedback path, and no feature
code bypassing `lib/core/feedback/app_feedback.dart`.

### Domain Source

Domain entities own business rules. Data DTOs own response shape and JSON. DTOs
must not duplicate domain behavior such as progress calculation. Mappers convert
from response shape to domain shape at the data/application boundary.

Immediate target: remove `hasProgress` and `progressRatio` from
`ToViewModelDto` because `ToViewEntry` is the domain source.

### Query Source

Query objects that only bundle method parameters are removed. Repository methods
should expose named parameters when no reusable domain concept exists.

Immediate target: inline `FavoriteFolderListQuery` and
`FavoriteFolderResourcesQuery`, then delete the query file and generated parts.

### Infrastructure Source

Network API clients come from providers. Repositories must not instantiate
`ResourceApi` directly. This keeps Dio, cookie, retry, cache, and endpoint
policy wiring in one source.

Immediate target: standardize `video_repository_impl.dart` and
`danmaku_repository_impl.dart` on `resourceApiProvider` or
`basicResourceApiProvider`, whichever matches current endpoint policy.

### Dead Code Source

Dead files and deprecated aliases are deleted rather than wrapped. Lists with a
v2 replacement keep only the active version.

Immediate target: delete `PageQuery` and remove `rankingCategories` when only
`rankingCategoriesV2` is used.

### Boundary Inventory Source

The existing Phase 30 inventory remains the active guard fixture until Phase 32
updates the guard. Phase 32 should then rename or replace it with a current
source such as `docs/architecture/active-application-seams.md` and update
`architecture_boundary_guard_test.dart` in the same change.

## Implementation Constraints

- Use bd for tracking. Phase 32 planning issue is `culcul-zpy`; implementation
  tasks reuse existing ready issues.
- Run `gitnexus_impact` before editing any function, class, or method.
- If impact risk is HIGH or CRITICAL, stop and report blast radius before
  editing.
- Run `gitnexus_detect_changes(scope: "all")` before any commit.
- Keep generated files consistent through build_runner when models or providers
  change.
- Use Git Bash for shell commands on Windows.

## Phase 32 Implementation Issues

Primary:

- `culcul-i2u`: Merge `AppException` into `AppError`.

Parallel-safe follow-up slices after the error merge:

- `culcul-8os`: Inline `FavoriteQueries` parameter objects.
- `culcul-f47`: Remove duplicated `ToViewModelDto` business logic.
- `culcul-28y`: Flatten `SearchTrendingKeyword`.
- `culcul-xoe`: Standardize `ResourceApi` instantiation.
- `culcul-1iv`: Remove `PageQuery` and stale `rankingCategories`.

Dependent after `culcul-i2u`:

- Comment service extraction.
- Unified notification/toast pattern.

## Validation

Minimum gates for the planning slice:

```bash
git status --short
bd show culcul-zpy --json
```

Minimum gates for implementation slices:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test test/architecture
flutter analyze --no-fatal-infos
```

If a slice does not touch generated code, build_runner may be skipped only after
confirming no `part` file, Freezed model, Riverpod generator, Retrofit API,
go_router route, or Drift database definition changed.

## Spec Self-Review

- No placeholders remain.
- The spec is scoped to source-of-truth consolidation, not UI redesign.
- The active Phase 30 inventory is not moved without the guard update.
- Every implementation target maps to a bd issue.
- Existing user dirty files are excluded from this phase.
