# Phase 14: Dependency Modernization & Model Consistency — Implementation Plan

**Spec:** `docs/superpowers/specs/2026-05-12-phase14-dependency-modernization-and-model-consistency.md`  
**Status:** Active  
**Estimated effort:** 6 tasks, ~30 file deletions, ~50 file modifications

---

## Task 1: Dependency Hygiene (C4)

**Goal:** Remove dead packages, pin versions, fix misplaced dependencies.

**Steps:**
1. Remove from `pubspec.yaml` dependencies:
   - `flutter_staggered_grid_view: ^0.7.0`
   - `flutter_spinkit: ^5.2.2`
2. Verify `flutter_riverpod` usage:
   - Grep for `flutter_riverpod` imports in `lib/` and `test/`
   - If only in `test/`, leave in dev_dependencies (correct)
   - If in `lib/`, move to dependencies
3. Pin dev dependencies:
   - `go_router_builder: any` → resolve current version and pin
   - `retrofit_generator: any` → resolve current version and pin
4. Evaluate `encrypt` vs `pointycastle`:
   - Find all usages of `encrypt` package in `lib/`
   - If `pointycastle` alone can cover the use case, remove `encrypt`
   - If both are needed, document why
5. Run `flutter pub get` to verify resolution
6. Run `dart analyze`

**Files modified:** 1 (`pubspec.yaml`)  
**Risk:** LOW — dependency removal with zero code changes (unused packages)

---

## Task 2: Remove Zero-Value Indirection (C2)

**Goal:** Delete files that only typedef, re-export, or alias without transformation.

**Steps:**
1. Delete `lib/core/data/network/dtos/comment_contract_dto.dart`:
   - Grep all imports of this file
   - Replace with direct imports of `core/contracts/comment_contract.dart`
   - Update import sites to use the original type names (drop `Dto` suffix)
2. Delete `lib/features/favorites/data/dtos/favorite_dtos.dart`:
   - Find all importers
   - Replace with direct imports of the actual DTO files
3. Delete `lib/features/favorites/data/dtos/index.dart`:
   - Find all importers (likely just `favorite_dtos.dart` which is also being deleted)
   - Replace remaining imports with direct file references
4. Delete `lib/features/live/domain/entities/live_room_model.dart`:
   - Grep for `LiveRoomModel` usage across codebase
   - Replace all with `LiveRoomSummary` (the actual type from core/contracts)
   - Update imports to point to `core/contracts/`
5. Delete `lib/features/video/data/dtos/video_model_dto.dart`:
   - Find all importers
   - Replace with direct import of `core/contracts/video_model_contract.dart`
6. Run `dart analyze` and fix any remaining import issues

**Files deleted:** 5  
**Files modified:** ~15-20 (import updates)  
**Risk:** LOW — mechanical import replacement, no behavior change

---

## Task 3: Fix Live Feature DTO/Domain Inversion (C1)

**Goal:** Collapse the inverted live feature model layer into a single, correctly-placed DTO layer.

**Steps:**
1. Audit `lib/features/live/domain/entities/` — list all files and their content:
   - Identify which are freezed classes with `@JsonKey`/`fromJson` (these are actually DTOs)
   - Identify which are pure domain models (no serialization)
2. For each file that has serialization annotations:
   - Move from `domain/entities/` to `data/dtos/`
   - Update all imports across the feature
3. Delete re-export stubs in `data/dtos/` that pointed to domain:
   - `live_anchor_info_model.dart`, `live_danmaku_model.dart`, `live_danmu_info_model.dart`
   - `live_gold_rank_model.dart`, `live_guard_list_model.dart`, `live_play_url_model.dart`
   - `live_room_detail_model.dart`, `live_room_model.dart`, `live_recommend_response.dart`
4. Resolve `live_history_danmaku_model.dart` duplication:
   - Keep the typed domain version (with `LiveDanmakuMedal`, `LiveDanmakuTitle`, etc.)
   - Update the DTO version to be a proper JSON-parsing layer that maps to the domain model
   - OR if no domain logic exists, keep only the DTO version with proper typing
5. If `domain/entities/` becomes empty, delete the directory
6. Update `feature_scope.dart` and any cross-feature imports
7. Run `build_runner build --delete-conflicting-outputs`
8. Run `dart analyze`

**Files deleted:** ~9 (re-export stubs)  
**Files moved:** ~8 (domain → data/dtos)  
**Risk:** MEDIUM — live feature has many models; careful import tracking needed

---

## Task 4: Standardize Entities on Freezed (C5)

**Goal:** Convert remaining hand-written domain entities to freezed.

**Steps:**
1. Identify all hand-written entity classes:
   - `lib/features/favorites/domain/entities/favorite_folder.dart`
   - `lib/features/history/domain/entities/` (check all files)
   - Any other non-freezed entities
2. For each hand-written entity:
   - Convert to freezed syntax (`@freezed class Xxx with _$Xxx { ... }`)
   - Add `part '<filename>.freezed.dart';`
   - Add `part '<filename>.g.dart';` if JSON serialization needed
   - Remove manual `copyWith`, `==`, `hashCode`, `toString` implementations
3. Run `build_runner build --delete-conflicting-outputs`
4. Fix any type mismatches from the conversion
5. Run `dart analyze` and all tests

**Files modified:** ~5-10  
**Risk:** LOW — freezed generates equivalent behavior; tests catch regressions

---

## Task 5: Migrate Hive → shared_preferences + flutter_secure_storage (C3)

**Goal:** Replace unmaintained Hive with modern, maintained alternatives.

**Steps:**
1. Add to `pubspec.yaml`:
   - `shared_preferences: ^2.5.0`
   - `flutter_secure_storage: ^9.2.0` (if auth tokens are stored in Hive)
2. Audit all Hive usage (6 files):
   - Map each Hive box to its replacement:
     - Settings/preferences → `shared_preferences`
     - Auth tokens/sensitive data → `flutter_secure_storage`
     - Structured user cache → Drift (already available)
3. Create migration layer:
   - On first launch after update, read from Hive → write to new storage → delete Hive box
   - This ensures no data loss for existing users
4. Implement new storage adapters:
   - `lib/core/data/local/preferences_store.dart` (wraps shared_preferences)
   - `lib/core/data/local/secure_store.dart` (wraps flutter_secure_storage)
5. Update all consumers to use new adapters
6. Remove Hive initialization from bootstrap
7. Remove from `pubspec.yaml`: `hive: ^2.2.3`, `hive_flutter: ^1.1.0`
8. Delete any Hive-specific adapter/type files
9. Run full test suite

**Files added:** 2-3 (new storage adapters + migration)  
**Files modified:** ~10-15  
**Files deleted:** ~3-5 (Hive adapters)  
**Risk:** HIGH — storage migration affects all users; requires migration path and thorough testing

---

## Task 6: Migrate wbi_helper_provider to @Riverpod (C6)

**Goal:** Last hand-written provider → generated.

**Steps:**
1. Open `lib/core/data/network/providers/wbi_helper_provider.dart`
2. Convert from `final wbiHelperProvider = Provider<WbiHelper>((ref) => ...)` to:
   ```dart
   @Riverpod(keepAlive: true)
   WbiHelper wbiHelper(Ref ref) => WbiHelper(...);
   ```
3. Run `build_runner build`
4. Update any imports that referenced the old provider name (if naming changes)
5. Run `dart analyze`

**Files modified:** 1-2  
**Risk:** LOW — mechanical conversion

---

## Execution Order

```
Task 1 (dependency hygiene)     ─┐
Task 2 (zero-value indirection)  ├─ Independent, can run in parallel
Task 6 (wbi_helper provider)    ─┘
         │
         ▼
Task 3 (live feature inversion)  ─── Depends on Task 2 (LiveRoomModel removal)
         │
         ▼
Task 4 (freezed standardization) ─── After Task 3 (live entities may change)
         │
         ▼
Task 5 (Hive migration)          ─── Last, highest risk, most testing needed
```

Tasks 1, 2, 6 are independent and can be executed in parallel.  
Task 3 depends on Task 2 (LiveRoomModel typedef removal).  
Task 4 follows Task 3 (live entities settle before standardizing).  
Task 5 is last because it's the highest-risk change requiring migration logic.

---

## Validation Gate

After all tasks:
```bash
dart analyze                              # Zero errors
dart run build_runner build               # Generated code consistent
flutter test                              # All tests pass
flutter build apk --debug                 # Build succeeds
```

## Post-Completion

1. Update `docs/architecture/architecture-guide.md` to reflect:
   - Storage: shared_preferences + flutter_secure_storage + Drift (no Hive)
   - Model standard: all entities use freezed
   - No typedef/re-export indirection files
2. Update `CLAUDE.md` to reference Phase 14 as active/completed
3. Archive this plan with `.completed` suffix
