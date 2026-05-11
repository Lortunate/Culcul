# Phase 12: Capability Facade Simplification & Generator-First Convergence

**Status:** ACTIVE
**Date:** 2026-05-12
**Goal:** Simplify Culcul's feature architecture by collapsing thin wrapper seams, shrinking redundant public surfaces, and standardizing on the repo's existing mainstream generator stack so the codebase becomes easier to read, easier to modify, and less repetitive.

## Why a New Phase

Phase 11 identified real seam drift, but it still treated architecture work mostly as seam policing. The repo's next bottleneck is broader:

- several feature facades are effectively empty wrappers over repository-entry providers
- `home` still injects a concrete data source directly into its facade
- `notification` still exposes a repository-shaped capability surface with a large pass-through API
- `dynamic`, `video`, `live`, and `search` still publish `presentation/**` internals through `*_public_contracts.dart`
- the repo already depends on popular modern tooling such as Riverpod Generator, Freezed, Json Serializable, Retrofit, and Drift, but many slices still hand-write glue that those tools can replace

The next phase should therefore optimize for simpler code first, not only stricter seam wording.

## Current Structural Problems

### P0: thin-wrapper seam inflation

Several application seams add naming layers without adding behavior:

- `auth`, `dynamic`, `favorites`, `history`, `live`, `ranking`, `search`, `settings`, `to_view`, and `video` each keep facade classes that mostly store repository dependencies and add little or no capability logic
- `home/application/home_facade.dart` depends on `HomeFeedDataSource` directly instead of a narrower capability port
- `notification/application/notification_facade.dart` has grown into a repository-shaped surface with many pass-through methods

This makes the feature tree look more layered than it really is, and it spreads responsibility across `feature_scope.dart`, `*_repository_provider.dart`, facade classes, and presentation models even when the behavior could be expressed in fewer, clearer seams.

### P1: public API still leaks implementation-shaped surfaces

The repo still publishes presentation internals as public feature contracts:

- `dynamic_public_contracts.dart`
- `video_public_contracts.dart`
- `live_public_contracts.dart`
- `search_public_contracts.dart`

These exports keep cross-feature usage coupled to widget or provider placement instead of capability intent.

### P1: generator-capable boilerplate remains hand-written

The current dependency stack already includes the tools the repo should prefer:

- Riverpod Generator for provider wiring and typed dependency composition
- Freezed and Json Serializable for immutable request, response, and state models
- Retrofit for API client contracts
- Drift for local persistence contracts

But many slices still keep hand-written provider-entry glue, repository wiring, or data-shape mapping that should be normalized toward these established patterns instead of growing more custom abstractions.

### P2: file sharding often exceeds behavior complexity

`video`, `notification`, and `dynamic` contain multiple `*_helpers.dart`, `*_workflows.dart`, `*.part`, and narrowly split view-model files. Some splitting is legitimate, but some of it is now preserving accidental structure rather than real behavioral boundaries.

## Target Architecture

### 1. Keep the top-level shape stable

Do not reopen another repo-wide bucket migration. The stable shape remains:

- `app/`
- `core/`
- `features/`
- `ui/`

### 2. Feature public surfaces must be capability-oriented

A feature's public API should expose only:

- route entrypoints
- explicit capability providers or capability services
- intentionally public contracts that are stable enough for cross-feature reuse

It should not expose `presentation/**`, `data/**`, or repository-implementation details as convenience exports.

### 3. Empty facades are not an acceptable resting state

If a feature facade adds no capability behavior, no orchestration, and no stabilizing contract, it should be removed or merged into a clearer provider or service entrypoint. A named seam is only worth keeping when it carries meaning.

### 4. Prefer generator-first implementations over hand-written glue

When a problem is already covered by the repo's mainstream stack, Phase 12 should choose that path first:

- Riverpod Generator over manual provider-entry boilerplate
- Freezed and Json Serializable over repetitive model and mapping shells
- Retrofit over ad hoc API contract shaping
- Drift over custom local persistence ceremony

The phase goal is not "introduce more libraries". The goal is "use the popular modern libraries already in the repo more consistently so custom glue shrinks".

### 5. Split files only when the behavior boundary is real

Large files should still be decomposed, but decomposition must follow cohesive responsibility rather than naming habits like `helpers`, `workflows`, or "one tiny wrapper per layer". Phase 12 should merge shards when the split obscures behavior instead of clarifying it.

## Success Criteria

1. `CLAUDE.md`, `docs/architecture/architecture-guide.md`, and the active spec/plan all point to the same Phase 12 baseline.
2. The former Phase 11 root spec/plan are archived as `superseded`, with an honest note that the simplification-first direction replaced the seam-only focus.
3. No active feature keeps an empty facade class whose only durable role is storing repository dependencies without capability behavior.
4. `home` and `notification` expose clearer capability-oriented seams with fewer pass-through layers.
5. `dynamic`, `video`, `live`, and `search` stop exporting `presentation/**` internals from public-contract surfaces.
6. At least one representative simplification pass replaces hand-written wiring with the repo's existing generator-first patterns and documents that preferred shape for future slices.
7. Verification tooling can detect wrapper regression, public-contract leaks, and implementation imports into active seam files.

## Non-Goals

- Another repo-wide boundary rebaseline
- Reorganizing `app/`, `core/`, `features/`, or `ui/` into new top-level buckets
- Switching away from Riverpod, Dio, GoRouter, Retrofit, or Drift
- Broad UI redesign work
- Large generated-file churn outside the slices touched by the approved plan

## Migration Strategy

1. Archive Phase 11 honestly as superseded-by-simplification.
2. Establish one truthful active baseline in `CLAUDE.md`, `architecture-guide.md`, and the new Phase 12 spec/plan.
3. Add architecture checks that fail on empty facades, public presentation exports, and repository-implementation leaks in active seam files.
4. Simplify the highest-value slices first: `home` and `notification`.
5. Apply the same simplification rules to lower-risk public-contract slices such as `dynamic`, `video`, `live`, and `search`.
6. Refresh the architecture guide only with verified end-state rules that future phases should preserve.
