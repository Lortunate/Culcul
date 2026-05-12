# Phase 13: Structural Simplification — Implementation Plan

**Spec:** `docs/superpowers/specs/2026-05-12-phase13-structural-simplification-and-single-source-of-truth.md`  
**Status:** Active  
**Estimated effort:** 6 tasks, ~26 file deletions, ~40 file modifications

---

## Task 1: Collapse Provider Wiring Indirection (C1)

**Goal:** Remove the 2-file indirection layer between repository implementations and feature scopes.

**Steps:**
1. For each of the 13 features:
   - Identify the generated provider symbol in `data/<name>_repository_impl.g.dart`
   - Update `feature_scope.dart` to export directly from the impl (or its `.g.dart`)
   - Delete `data/<name>_repository_entry.dart`
   - Delete `application/<name>_repository_provider.dart` (if it only re-assigns)
   - If `application/` directory becomes empty, delete it
   - If `application/` contains facades with real logic, keep those files
2. Update all imports across the codebase that referenced the deleted files
3. Run `dart analyze` and fix any breakage
4. Run `build_runner` to ensure generated code is consistent

**Files deleted:** ~26 (2 per feature × 13 features)  
**Risk:** LOW — purely mechanical re-export elimination

---

## Task 2: Consolidate VideoModel & Fix DTO Layer (C2 + C3)

**Goal:** Single VideoModel definition; DTOs in correct layer.

**Steps:**
1. Audit `core/contracts/video_model_contract.dart` vs `features/video/domain/entities/video_model_dto.dart`:
   - Map field-by-field differences
   - Identify which features import which definition
2. Unify on the `core/contracts/` definition:
   - If the video feature needs extra fields, extend or compose rather than duplicate
   - Update all video-feature imports to use `core/contracts/video_model_contract.dart`
3. Move remaining DTOs from `features/video/domain/entities/` to `features/video/data/dtos/`:
   - `video_detail_dto.dart`, `play_url_dto.dart`, `player_info_dto.dart`, `subtitle_dto.dart`, `related_video_dto.dart`
4. Remove re-export barrels in `features/video/data/dtos/` that pointed back to domain
5. Run `build_runner build --delete-conflicting-outputs`
6. Run `dart analyze` and all tests

**Risk:** MEDIUM — VideoModel is used across many features; careful field mapping needed

---

## Task 3: Remove Dead Code & Simplify Notification (C4 + C5)

**Goal:** Delete confirmed dead files; restructure notification from 11 files to ≤4.

**Steps:**
1. Delete dead code:
   - `lib/app/bootstrap/app_dependencies.dart`
   - `lib/app/bootstrap/provider_overrides.dart`
   - `lib/core/utils/validation_utils.dart`
   - Verify no imports reference these (grep first)
2. Restructure notification repository:
   - Read all 10 part files to understand behavioral groupings
   - Create `notification_messaging_service.dart` (message send/receive)
   - Create `notification_stream_manager.dart` (WebSocket/stream lifecycle)
   - Move relevant code from part files into these new collaborator classes
   - Update `notification_repository_impl.dart` to delegate to collaborators
   - Delete all `.part` files
   - Update `part` directives
3. Run tests for notification feature specifically

**Risk:** MEDIUM — notification restructuring requires understanding behavioral boundaries

---

## Task 4: Route Transition Base Class (C6)

**Goal:** Eliminate repeated `buildPage` boilerplate across ~15 route classes.

**Steps:**
1. Create `lib/app/router/app_route_data.dart`:
   ```dart
   abstract class AppRouteData extends GoRouteData {
     const AppRouteData();
     
     @override
     Page<void> buildPage(BuildContext context, GoRouterState state) =>
         SlideFromRightTransitionPage(child: build(context, state));
   }
   ```
2. Update all route classes in `lib/app/router/routes/` to extend `AppRouteData` instead of `GoRouteData`
3. Remove their individual `buildPage` overrides (keep only those with non-default transitions)
4. Run `dart analyze`

**Risk:** LOW — mechanical replacement, easy to verify

---

## Task 5: Replace Custom Retry with dio_smart_retry (C7)

**Goal:** Replace hand-written retry interceptor with maintained package.

**Steps:**
1. Add `dio_smart_retry: ^7.0.1` to `pubspec.yaml`
2. Update `lib/core/data/network/dio_client.dart` (or wherever interceptors are added):
   - Replace `RetryInterceptor` with `RetryInterceptor` from `dio_smart_retry`
   - Configure same behavior: exponential backoff, jitter, retry on 5xx + timeout
3. Delete `lib/core/data/network/interceptors/retry_interceptor.dart`
4. Run network-related tests
5. Run `dart analyze`

**Risk:** LOW — well-tested package, same behavior

---

## Task 6: UI Directory Clarification & Archive Cleanup (C8 + C9)

**Goal:** Rename compositions → assemblies; fix archive suffixes.

**Steps:**
1. Rename `lib/ui/compositions/` to `lib/ui/assemblies/`
2. Update the barrel in `lib/ui/ui.dart` to reference `assemblies/`
3. Update all imports across the codebase (`ui/compositions/` → `ui/assemblies/`)
4. Rename archive files with missing suffixes:
   - `shared-to-core-ui-ownership-normalization-roadmap.md` → add `.completed`
   - `shared-perf-ownership-normalization-design.md` → add `.completed`
   - `shared-contracts-ownership-normalization-design.md` → add `.completed`
   - `phase7-code-quality-refactoring.draft.md` → rename to `.superseded`
   - `phase7-code-quality-refactoring-design.draft.md` → rename to `.superseded`
5. Run `dart analyze`

**Risk:** LOW — rename + import updates

---

## Execution Order

```
Task 1 (provider wiring)     ─┐
Task 4 (route base class)     ├─ Independent, can run in parallel
Task 5 (dio_smart_retry)      │
Task 6 (UI rename + archive)  ─┘
         │
         ▼
Task 2 (VideoModel + DTOs)    ─── Depends on Task 1 (feature_scope changes)
         │
         ▼
Task 3 (dead code + notification) ─── Last, most complex restructuring
```

Tasks 1, 4, 5, 6 are independent and can be executed in parallel.  
Task 2 should follow Task 1 (both touch feature_scope.dart).  
Task 3 is last because notification restructuring is the most complex.

---

## Validation Gate

After all tasks:
```bash
dart analyze                    # Zero errors
dart run build_runner build     # Generated code consistent
flutter test                    # All tests pass
```

## Post-Completion

1. Update `docs/architecture/architecture-guide.md` to reflect new structure
2. Update `CLAUDE.md` to reference Phase 13 as active/completed
3. Archive this plan with `.completed` suffix
