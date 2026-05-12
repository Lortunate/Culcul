# Phase 15 Plan: Architecture Streamlining & Dead Weight Removal

**Spec:** `docs/superpowers/specs/2026-05-12-phase15-architecture-streamlining-and-dead-weight-removal.md`  
**Date:** 2026-05-12

## Execution Order

Tasks are ordered by dependency and risk. Tasks 1-4 are independent and can be parallelized. Tasks 5-7 depend on earlier tasks. Task 8 is last (project-wide impact).

---

## Task 1: Remove Deprecated Typedef and Fix Plain Class (C6)

**Risk:** LOW  
**Effort:** 15 min

### Steps
1. Delete `lib/core/contracts/watch_later_contract.dart`
2. Remove `export 'watch_later_contract.dart'` from `core_contracts.dart`
3. Grep for any remaining imports of `watch_later_contract.dart` — update to `watch_later_port.dart`
4. Convert `UserProfileInfo` in `user_profile_lookup_contract.dart` to freezed
5. Run `dart run build_runner build --delete-conflicting-outputs`
6. Verify tests pass

---

## Task 2: Convert AudioPlaybackSnapshot to Freezed (C8)

**Risk:** LOW  
**Effort:** 15 min

### Steps
1. Add `@freezed` annotation to `AudioPlaybackSnapshot` in `audio_playback_state_gate.dart`
2. Remove hand-written `==` and `hashCode`
3. Add `part` directive for generated file
4. Run code generation
5. Verify `audio_handler.dart` (sole consumer) still compiles

---

## Task 3: Consolidate Crypto Dependencies (C4)

**Risk:** LOW  
**Effort:** 30 min

### Steps
1. Read `auth_repository_impl.helpers.dart` to understand RSA usage pattern
2. Replace `encrypt` package usage with direct `pointycastle` RSA calls:
   - `RSAPublicKey` parsing from PEM
   - `PKCS1Encoding(RSAEngine())` for encryption
3. Remove `encrypt` from `pubspec.yaml`
4. Run `flutter pub get`
5. Verify auth login flow compiles and tests pass

---

## Task 4: Collapse Live Feature Model Duplication (C1)

**Risk:** MEDIUM  
**Effort:** 45 min

### Steps
1. Compare `data/dtos/live_history_danmaku_model.dart` vs `domain/entities/live_history_danmaku_model.dart`
2. Keep domain entity version (has typed sub-models: `LiveDanmakuMedal`, `LiveDanmakuTitle`, `LiveDanmakuUserLevel`)
3. Add `fromJson`/`toJson` generation (`part 'live_history_danmaku_model.g.dart'`, `@JsonKey` annotations)
4. Delete `data/dtos/live_history_danmaku_model.dart` and its generated files
5. Update `live_dtos.dart` barrel to remove the deleted export
6. Update `live_api.dart` and `live_room_mapper.dart` imports
7. Run code generation and verify

---

## Task 5: Eliminate Barrel File Chains (C2)

**Risk:** MEDIUM  
**Effort:** 1-2 hours  
**Depends on:** Task 4 (live barrel changes)

### Steps
1. **Delete `live_entities.dart`** — find all importers, replace with direct imports to `live_dtos.dart` files and `live_history_danmaku_model.dart`
2. **Delete `live_entities_exports.dart`** — replace imports with direct paths
3. **Delete `dynamic_entities_exports.dart`** — replace with direct imports to `comment_contract.dart`, `dynamic_extension.dart`, `dynamic_response.dart`, `dynamic_content_entities.dart`, `emote_response.dart`
4. **Delete `core_perf.dart`** — no external consumers (verify with grep)
5. **Flatten `core.dart` → `data.dart` → `core_network.dart`** chain:
   - Find all consumers of `import 'package:culcul/core/core.dart'`
   - Replace with specific imports (e.g., `app_error.dart`, `request_executor.dart`, etc.)
   - Delete `core.dart` and `data.dart` barrel files
6. Run `dart analyze` to catch any broken imports
7. Update architecture tests if they reference deleted files

---

## Task 6: Replace `pool` Package — Simplify Concurrency (C3)

**Risk:** MEDIUM  
**Effort:** 1 hour  
**Depends on:** Task 5 (perf logger references may shift)

### Steps
1. Create `lib/core/data/network/semaphore.dart` — a simple async semaphore (~20 LOC):
   ```dart
   class Semaphore {
     final int maxCount;
     int _current = 0;
     final _waiters = <Completer<void>>[];
     
     Semaphore(this.maxCount);
     
     Future<void> acquire() async { ... }
     void release() { ... }
   }
   ```
2. Simplify `NetworkConcurrencyExecutor`:
   - Remove all `NetworkPerfLogger` calls (move to Task 7)
   - Replace `Pool` with `Semaphore`
   - Reduce from 200 LOC to ~60 LOC
3. Remove `pool` from `pubspec.yaml`
4. Run `flutter pub get`
5. Verify all 7 consumers still work

---

## Task 7: Simplify Performance Infrastructure (C5)

**Risk:** MEDIUM  
**Effort:** 1-2 hours  
**Depends on:** Task 6 (concurrency executor perf logging removed)

### Steps
1. **Keep:** `performance_policy.dart` (runtime UI behavior), `frame_timing_sampler.dart` (feeds performance_policy)
2. **Create** `lib/core/perf/dev_logger.dart`:
   ```dart
   class DevLogger {
     static void log(String category, String event, [Map<String, Object?>? fields]) {
       if (!kDebugMode && !kProfileMode) return;
       developer.log('$category.$event ${_formatFields(fields)}', name: category);
     }
   }
   ```
3. **Delete** individual loggers:
   - `network_perf_logger.dart` → callers use `DevLogger.log('network', ...)`
   - `video_perf_logger.dart` → callers use `DevLogger.log('video', ...)`
   - `list_perf_logger.dart` → callers use `DevLogger.log('list', ...)`
   - `feature_flow_perf_logger.dart` → callers use `DevLogger.log('flow', ...)`
   - `startup_perf_logger.dart` → callers use `DevLogger.log('startup', ...)`
4. Update all ~29 consumer files to use `DevLogger`
5. Delete `core_perf.dart` barrel (already done in Task 5)
6. Verify no regressions

---

## Task 8: Strengthen Analysis and Build Configuration (C7)

**Risk:** HIGH (may surface many warnings)  
**Effort:** 2-3 hours  
**Depends on:** All other tasks (clean baseline needed)

### Steps
1. **Create `build.yaml`:**
   ```yaml
   targets:
     $default:
       builders:
         freezed:
           generate_for:
             include: ["lib/**"]
             exclude: ["lib/protos/**"]
         json_serializable:
           generate_for:
             include: ["lib/**"]
             exclude: ["lib/protos/**"]
         riverpod_generator:
           generate_for:
             include: ["lib/**"]
   ```
2. **Update `analysis_options.yaml`:**
   - Add `strict-casts: true` and `strict-raw-types: true` under `analyzer > language`
   - Add rules: `always_use_package_imports`, `prefer_single_quotes`, `avoid_dynamic_calls`, `unawaited_futures: error`
   - Add `prefer_const_constructors`, `prefer_const_declarations`
3. Run `dart analyze` — fix all new warnings
4. Run full test suite to verify no behavioral changes
5. Run `dart run build_runner build --delete-conflicting-outputs` to verify generators work with new `build.yaml`

---

## Verification Checklist

After all tasks:
- [ ] `dart analyze` — zero warnings
- [ ] `flutter test` — all tests pass
- [ ] `flutter build apk --debug` — builds successfully
- [ ] No barrel-chain files remain (except `core_contracts.dart`)
- [ ] `pool` and `encrypt` removed from pubspec.yaml
- [ ] Perf infrastructure: 3 files (down from 7)
- [ ] Architecture tests pass
- [ ] `git diff --stat` shows net negative LOC

## Risk Summary

| Task | Risk | Reason |
|------|------|--------|
| T1 | LOW | Isolated deletion + simple freezed conversion |
| T2 | LOW | Single file, one consumer |
| T3 | LOW | Crypto swap, well-contained |
| T4 | MEDIUM | Model merge requires mapper updates |
| T5 | MEDIUM | Many import path changes, but mechanical |
| T6 | MEDIUM | Concurrency pattern change, 7 consumers |
| T7 | MEDIUM | 29 files touched, but all changes are import + call-site |
| T8 | HIGH | Project-wide analysis changes, may surface latent issues |
