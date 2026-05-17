# Phase 36 Aggressive Architecture Cleanup Spec

## Status

Active.

Supersedes:

- `docs/specs/archive/2026-05-17-phase35-architecture-simplification.superseded.md`

Implementation plan:

- `docs/plans/2026-05-18-phase36-aggressive-architecture-cleanup.md`

Tracking:

- `culcul-rg4`: Phase 36 aggressive architecture cleanup.
- Child tasks: `culcul-4ir`, `culcul-dhm`, `culcul-rzy`, `culcul-psp`,
  `culcul-fpl`.

## Context

Phase 35 was intentionally conservative. The current product goal is more
aggressive: simplify the app architecture, remove compatibility layers, delete
dead code, collapse redundant abstractions, and improve runtime performance
without preserving old local APIs.

Current audit:

- Active branch: `codex/phase34-architecture-modernization`.
- GitNexus was refreshed before this spec: `9414` nodes, `20870` edges, `187`
  flows.
- `lib/` contains about `680` hand-written Dart files and `246` generated Dart
  files.
- Existing tests are small for the source size: `14` Dart test files, with
  architecture guards under `test/architecture`.
- Phase 35 docs referenced bd issues that are no longer open. Phase 36 uses
  `culcul-rg4` and its child tasks instead of stale identifiers.

Current top-level shape remains the intended macro architecture:

```text
lib/
  app/       app shell, bootstrap, router, root composition
  core/      infrastructure, contracts, cross-feature services
  features/  feature-owned data/application/presentation code
  ui/        reusable UI primitives and approved UI public API
```

Phase 36 may aggressively reorganize directories inside those boundaries. It
must not reintroduce `lib/shared/`.

## Goals

- Make Phase 36 the only active architecture source of truth.
- Archive Phase 35 as superseded.
- Rebuild bd tracking with a Phase 36 epic and concrete implementation tasks.
- Keep exactly one real owner for every shared concept.
- Remove dead code, zero-value wrappers, alias providers, export-only barrels,
  duplicate DTO/model definitions, and compatibility shims.
- Simplify feature internals, even when this breaks old local imports.
- Improve startup, rebuild behavior, memory pressure, cache behavior, and
  database/query cost where evidence shows a bottleneck.
- Keep modern packages and generated APIs when they reduce code or risk.

## Non-Goals

- Do not rewrite the app from scratch.
- Do not replace working popular packages with custom infrastructure.
- Do not preserve old local import paths through compatibility files.
- Do not add repository interfaces, service wrappers, or provider aliases unless
  they own a real runtime boundary.
- Do not split files only to reduce line count.
- Do not weaken analyzer rules to hide debt.
- Do not regenerate protobuf output unless `.proto` sources change and the
  tool path is documented.

## Architecture Direction

### Macro Boundaries

- `app/` owns app startup, root providers, router, and shell composition.
- `core/` owns cross-feature contracts, errors, result types, network policy,
  persistence infrastructure, feedback, and shared services.
- `features/<name>/` owns its own API clients, DTOs, mappers, local persistence,
  providers, view models, and UI.
- `ui/` owns reusable design-system widgets only.

### Feature Shape

Feature directories should use only the layers they need. Example target shape
for `video`:

```text
features/video/
  data/            API clients, DTOs, mappers, local stores
  application/     feature state owners and use-case coordinators
  presentation/    pages, widgets, controllers/view models
  video.dart       optional public API only when consumers need it
  route_entry.dart router-facing seam
```

`domain/` is optional. Add or keep it only when there is behavior that is not a
DTO, not UI state, and not persistence mapping.

### Single Sources Of Truth

- `AppError` is the single error hierarchy.
- `Result` is the single typed result wrapper.
- `AppFeedback` is the only feature-facing feedback API.
- Shared cross-feature endpoint logic belongs in one core service owner.
- Shared UI primitives live in `ui/`; feature-specific widgets stay in the
  owning feature.
- Shared contracts live in `core/contracts/`; feature DTOs stay under the
  owning feature `data/dtos/`.
- Network configuration flows through the existing Dio/request policy path.
- Local database ownership is explicit per feature; Drift accessors are kept
  only when they own real queries or streams.

### Modern API Defaults

- Riverpod: use generated `@riverpod` providers. Mutable state uses `Notifier`;
  async state uses `AsyncNotifier`. Widgets call notifier methods instead of
  carrying business logic.
- go_router: keep typed/generated routes through `go_router_builder`; route
  files are grouped by app navigation boundary, not by pass-through wrappers.
- Drift: keep generated, type-safe access. Prefer `drift_flutter` connection
  setup and reactive streams where they reduce manual cache/state code.
- Freezed/json_serializable/retrofit/slang: keep generated code where it is the
  source of truth. Delete hand-written duplicates around generated APIs.

## Workstreams

### WS-1: Phase Rollover And Tracking

Archive Phase 35 spec and plan as superseded. Create Phase 36 spec and plan.
Update `CLAUDE.md` and `docs/architecture/architecture-guide.md`. Create a bd
epic plus child tasks for the implementation workstreams.

### WS-2: Source-Of-Truth Consolidation

Audit and consolidate comment APIs, app feedback, errors/results, network/cache
policy, route definitions, provider owners, and local database owners. Delete
compatibility files after callers move.

### WS-3: Feature Directory Cleanup

For each large feature, normalize internal directories to the approved feature
shape. Collapse empty or pass-through `domain/`, `application/`, service, or
repository layers. Keep only boundaries that carry behavior or testing value.

### WS-4: Dead Code And Wrapper Removal

Remove unused helpers, alias providers, export-only barrels, empty adapters,
no-op services, duplicate mappers, TODO stubs, and placeholder runtime seams.
Every removal must be backed by search or GitNexus evidence.

### WS-5: Performance Cleanup

Profile and optimize startup work, provider lifetime, list rebuilds, image/cache
pressure, Drift queries, stream granularity, and media/player resource cleanup.
Prefer deleting unnecessary work over adding new caches.

### WS-6: Quality And Guard Rails

Expand architecture guards where Phase 36 adds a rule. Keep validation focused:
codegen, architecture tests, analyzer, and targeted feature tests. Add tests
before risky behavior changes.

## Hard Rules

- `lib/shared/` must stay absent.
- `core/` and `ui/` must not import `features/`.
- A feature must not import another feature's `data/**` or `presentation/**`.
- No new barrel-chain files. Keep only approved public surfaces.
- No compatibility shims for removed internal APIs.
- No `UnimplementedError`, `TODO()`, or no-op runtime implementations.
- No new hand-written Riverpod providers for state that should be generated.
- No new repository interface unless at least two implementations, mockability,
  or a runtime boundary requires it.
- Run GitNexus impact before editing any function, class, or method.
- Warn before proceeding if impact is HIGH or CRITICAL.
- Run GitNexus detect changes before committing.

## Validation

Run the smallest relevant gate for each implementation slice, then phase gates:

```bash
dart run build_runner build --delete-conflicting-outputs
bash tool/architecture/run_architecture_guards.sh
flutter analyze --no-fatal-infos
```

Before code commits:

```bash
npx gitnexus analyze
gitnexus_detect_changes(scope: "all")
```

Before ending a work session with changes:

```bash
git pull --rebase
bd dolt push
git push
git status
```

## Acceptance Criteria

- Phase 35 spec and plan are archived as superseded.
- `CLAUDE.md` and `docs/architecture/architecture-guide.md` point to Phase 36.
- Only one active spec exists under `docs/specs/`.
- Only one active plan exists under `docs/plans/`.
- New bd epic and child tasks exist for Phase 36.
- Each code slice removes or simplifies a real source surface, not just moves
  files.
- Architecture guards and analyzer pass after each completed slice.
- No new duplicate source-of-truth definitions are introduced.
