# Phase 39 Architecture Modernization Plan

Tracking issue: `culcul-o9u`

## Status

Superseded architecture plan retained as the Phase 39 historical record.
Phase 40 is the active architecture execution plan.

## Current Baseline

- `flutter analyze --no-pub`: no issues.
- `flutter test test/architecture/architecture_boundary_guard_test.dart`: pass.
- `flutter test test/architecture/architecture_route_ownership_guard_test.dart`:
  pass.
- `lib/shared` is absent.
- Core/UI feature-internal import violations: 0.
- Private feature-to-feature data/presentation imports: 0.
- Runtime placeholder implementations: 0.
- Raw string route pushes: 0.
- Handwritten Riverpod provider declarations: 0.

The remaining value is structural consolidation and source-of-truth cleanup. Do
not add new layers, new libraries, or compatibility shims to create the
appearance of architecture progress.

## Recommended Directory Structure

```text
lib/
  app/                 bootstrap, runtime overrides, typed router, app shell
  core/                contracts, network, errors/result, storage, session, perf
  ui/                  design tokens, reusable widgets, assemblies
  features/
    <feature>/
      route_entry.dart
      data/            APIs, DTOs, repository implementations
      application/     generated providers, workflows, read/view models
      domain/          business entities and repository contracts only
      presentation/    pages, view models, widgets
  i18n/
  protos/
```

## Execution Principles

- Use `bd` for tracking remaining work.
- Keep one active architecture spec and one active plan.
- Before editing a function, class, or method, run GitNexus upstream impact
  analysis for that symbol and record the blast radius.
- Stop and report before editing when GitNexus reports HIGH or CRITICAL risk.
- Prefer deleting or merging low-value code over wrapping it.
- Avoid dependency upgrades in the same slice as structural moves.

## Phase 1: Active Documentation And Guard Baseline

Goal: make the architecture source of truth match the verified repo state.

Steps:

1. Update the active Phase 39 spec and this plan with the current analyzer and
   guard baseline.
2. Move Phase 30 architecture inventories from active docs to
   `docs/architecture/archive`.
3. Update `architecture-guide.md` and architecture guard references to the new
   archive paths.
4. Run:

```bash
flutter test test/architecture/architecture_boundary_guard_test.dart
flutter test test/architecture/architecture_route_ownership_guard_test.dart
flutter analyze --no-pub
```

Additional first-phase hardening:

- `tool/architecture/run_architecture_guards.sh` includes the route ownership
  guard.
- `make ci` runs the architecture guard script between analyze and tests.
- GitHub CI runs the same architecture guard script before coverage tests.
- The low-risk Dynamic public API seam stays at `features/dynamic/dynamic.dart`,
  while the `UserDynamicFeed` implementation lives under Dynamic presentation.

## Phase 2: Model And DTO Ownership

Goal: one model source per concept.

Approach:

1. Classify files currently under `features/*/application/models` as transport
   DTO, read/view model, command, or workflow state.
2. Move only when the target ownership is clear and all generated parts move with
   their source library.
3. Keep DTOs in `data/dtos`; keep read/view models in `application`; keep
   behaviorful domain concepts in `domain/entities`.
4. Do not create duplicate domain and DTO objects for the same concept unless the
   domain object owns behavior.

Verification:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze --no-pub
flutter test test/architecture/architecture_boundary_guard_test.dart
```

## Phase 3: Endpoint Source Of Truth

Goal: endpoint paths and generic network policy are not duplicated.

Approach:

1. Inventory `ApiConstants` and Retrofit annotations by feature.
2. Keep generic request execution, error mapping, and result policy in
   `RequestExecutor`, `AppError`, and `Result`.
3. Pick one endpoint ownership rule per feature and remove duplicates.
4. Avoid feature repositories reimplementing generic Dio error handling.

Verification:

```bash
flutter analyze --no-pub
flutter test test/core/data/network/request_executor_test.dart
```

## Phase 4: Startup And Runtime Lifetime

Goal: reduce first-frame startup work and unnecessary global lifetime.

Approach:

1. Keep only first-frame-critical work in `AppBootstrap.initialize`.
2. Keep cache/cookie/network warmup in deferred initialization when possible.
3. Review global caches and services for concrete ownership and disposal.
4. Measure with `FrameTimingSampler`-related tests or focused startup tests when
   touched.

Verification:

```bash
flutter analyze --no-pub
flutter test test/app/bootstrap/deferred_app_init_test.dart
```

## Phase 5: Low-Value Abstraction Cleanup

Goal: remove code that increases reading cost without owning policy.

Approach:

1. Review `service`, `manager`, `helper`, `utils`, `adapter`, and `facade` names
   only when usage evidence shows no real policy ownership.
2. Delete unused code only after import graph, analyzer, tests, and GitNexus
   impact analysis agree it is safe.
3. Merge one-call wrappers into their callers unless they enforce a reusable
   policy or break a real dependency cycle.

Verification:

```bash
flutter analyze --no-pub
flutter test
```

## Session Completion Gates

Before closing the issue or committing:

```bash
flutter analyze --no-pub
flutter test test/architecture/architecture_boundary_guard_test.dart
flutter test test/architecture/architecture_route_ownership_guard_test.dart
```

Run GitNexus `detect_changes(scope: "all", repo: "Culcul")` before commit.
Follow the project completion workflow for `bd dolt push` and `git push` once
the session's intended changes are ready to publish.
