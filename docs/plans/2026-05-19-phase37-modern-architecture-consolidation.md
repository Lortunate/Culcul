# Phase 37 Modern Architecture Consolidation Plan

## Operating Rules

- Spec: `docs/specs/2026-05-19-phase37-modern-architecture-consolidation.md`.
- Epic: `culcul-2fi`.
- Follow-up tasks: `culcul-de4`, `culcul-h21`, `culcul-57b`, `culcul-dg8`.
- Use `bd` for tracking. Do not add markdown TODO trackers.
- Run GitNexus impact before editing any function, class, or method.
- Stop and report before editing HIGH or CRITICAL risk symbols.
- Use Context7 before changing library APIs for Flutter, Riverpod, go_router,
  Drift, Dio, Retrofit, or build_runner.
- Delete obsolete code after callers move. Do not leave compatibility shims.
- Run `gitnexus_detect_changes(scope: "all")` before commit.

## Phase 1: Planning Surface And One Low-Risk Code Slice

Goal: establish one active architecture source and prove the cleanup approach
with a small low-risk shim deletion.

Steps:

1. Archive superseded Phase 36 and stale Phase 32 active docs.
2. Create Phase 37 spec and plan.
3. Update `docs/architecture/architecture-guide.md` active pointers.
4. Remove the `WatchLaterPort` compatibility chain after moving its single
   caller to the real application provider.
5. Regenerate Riverpod output if provider files are deleted.
6. Run analyzer and focused architecture tests.
7. Run GitNexus detect changes.

Expected code removals:

- `lib/core/contracts/watch_later_port.dart`
- `lib/features/to_view/application/watch_later_adapter.dart`
- `lib/features/to_view/application/watch_later_port_provider.dart`
- `lib/features/to_view/application/watch_later_port_provider.g.dart`

Expected caller change:

- `lib/features/home/presentation/widgets/home_video_actions.dart`

Expected controller move:

- `lib/features/to_view/presentation/view_models/to_view_view_model.dart`
- `lib/features/to_view/application/to_view_list_controller.dart`

## Phase 2: Application And Core Boundary Reduction

Goal: keep `core/` to primitives with behavior.

Steps:

1. Audit `core/contracts` and classify each contract as real boundary, generated
   model source, or removable compatibility seam.
2. Move feature-owned contracts back into their owning feature or delete them.
3. Collapse one-call application adapters into direct provider calls where the
   dependency is explicit and acyclic.
4. Keep override-only bootstrap providers only for startup-created resources.

## Phase 3: Network And Error Source Of Truth

Goal: one request execution and error mapping path.

Steps:

1. Audit repositories for ad hoc Dio try/catch and duplicate `AppError` mapping.
2. Route generic request execution through `RequestExecutor`.
3. Keep feature-specific mapping only for feature DTO/domain conversion.
4. Add focused tests for any request path whose error behavior changes.

## Phase 4: Feature DTO/State Consolidation

Goal: one source for each feature concept.

Steps:

1. Start with `notification`, `dynamic`, `video`, and `live`.
2. Delete handwritten duplicates around generated DTOs.
3. Keep domain-free response DTOs in `data/dtos`.
4. Keep UI state in presentation view models, not in DTO folders.
5. Update call sites and regenerate code per slice.

## Phase 5: Runtime Performance Cleanup

Goal: reduce startup work, rebuild scope, and repeated computation.

Steps:

1. Audit `main.dart` and `app/bootstrap` for synchronous startup work.
2. Keep non-critical initialization in deferred startup.
3. Replace broad widget watches with narrower selectors where profiling or code
   review shows avoidable rebuilds.
4. Remove unnecessary in-memory caches whose data already lives in Riverpod,
   Drift, Dio cache, or shared preferences.

## Verification

Run after each code slice:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test test/architecture
flutter test
```

If a command cannot run in the environment, record the exact blocker and do not
claim success for that gate.
