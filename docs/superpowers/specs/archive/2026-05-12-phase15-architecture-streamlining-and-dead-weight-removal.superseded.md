# Phase 15: Architecture Streamlining & Dead Weight Removal

**Status:** Superseded after partial landing  
**Supersedes:** Phase 14 (completed)  
**Date:** 2026-05-12

> Superseded on 2026-05-12 by `docs/superpowers/specs/2026-05-12-phase16-guard-green-architecture-convergence.md`.
> Phase 15 landed substantial cleanup (`refactor(phase15): architecture streamlining and dead weight removal`), but it cannot be marked completed because `flutter test test/architecture --reporter compact` is red and `docs/architecture/architecture-guide.md` did not truthfully record Phases 13-15.

## Motivation

Phases 1–14 established correct boundaries, eliminated structural ceremony, modernized dependencies, and standardized model patterns. The codebase is architecturally sound but still carries:

1. **Duplicate model definitions** — Live feature has identical `LiveHistoryDanmakuModel` in both `data/dtos/` and `domain/entities/` (the DTO has JSON serialization, the domain entity is a stripped copy without it)
2. **Barrel file proliferation** — Multiple layers of re-export files (`live_entities.dart` → `live_entities_exports.dart` → `live_dtos.dart`) that add indirection without value
3. **Unused/redundant dependencies** — `pool` package used only in one file (replaceable with Dart's built-in `Semaphore` or simpler patterns), `encrypt` + `pointycastle` both used for RSA in auth (consolidate to one)
4. **Over-engineered performance infrastructure** — 7 perf logger files with custom event systems, used by ~29 files but only emit `developer.log` in debug/profile mode. The `NetworkConcurrencyExecutor` (200 LOC) wraps `pool` with verbose logging for a pattern used in 7 places
5. **Deprecated typedef still exported** — `WatchLaterActions` typedef in `watch_later_contract.dart`
6. **Hand-written equality in `AudioPlaybackSnapshot`** — Should use freezed for consistency
7. **Weak lint configuration** — Only base `flutter_lints` with no strict rules; no `build.yaml` for 7 code generators
8. **`UserProfileInfo` in contracts is a plain class** — Should be freezed for consistency with all other contracts

## Design Principles

- **Eliminate indirection that adds no behavior** — If a file only re-exports or typedefs, delete it and update imports
- **One model, one location** — DTOs with JSON live in `data/dtos/`; domain entities without JSON live in `domain/entities/`. Never both for the same shape
- **Simplify over abstract** — Replace `pool` + `NetworkConcurrencyExecutor` with a simple semaphore utility. Replace verbose perf loggers with a single lightweight tracing helper
- **Strict by default** — Enable strict analysis rules and add `build.yaml` for generator performance
- **Consolidate crypto** — One package for RSA operations, not two overlapping ones

## Changes

### C1: Collapse Live Feature Model Duplication

**Problem:** `lib/features/live/data/dtos/live_history_danmaku_model.dart` has the DTO with `fromJson`/`toJson`. `lib/features/live/domain/entities/live_history_danmaku_model.dart` has a domain entity copy without serialization but with extra typed sub-models (`LiveDanmakuMedal`, `LiveDanmakuTitle`, `LiveDanmakuUserLevel`).

**Solution:** Keep only the domain entity version (richer types), add `fromJson`/`toJson` to it. Delete the DTO duplicate. Update the mapper to use the unified model.

**Files affected:** ~9 files in `features/live/`

### C2: Eliminate Barrel File Chains

**Problem:** Multiple barrel files exist solely to re-export other barrels:
- `live_entities.dart` → exports `live_dtos.dart` + `live_entities_exports.dart`
- `live_entities_exports.dart` → exports 2 files
- `dynamic_entities_exports.dart` → exports 5 files
- `core_contracts.dart` → exports 11 files (acceptable as a public API surface)
- `core_perf.dart` → exports 7 files (no consumers import it)
- `core_network.dart`, `data.dart`, `core.dart` → nested barrel chains

**Solution:** 
- Delete `live_entities.dart`, `live_entities_exports.dart` — consumers import directly
- Delete `dynamic_entities_exports.dart` — consumers import directly
- Delete `core_perf.dart` — zero external consumers use this barrel
- Keep `core_contracts.dart` (legitimate public API surface)
- Flatten `core.dart` → `data.dart` → `core_network.dart` chain into direct imports

**Files affected:** ~30-40 import updates

### C3: Replace `pool` Package with Built-in Semaphore

**Problem:** The `pool` package is used only in `NetworkConcurrencyExecutor` for rate-limiting concurrent network calls. The executor is 200 LOC with verbose perf logging, used by 7 files.

**Solution:** Replace with a simple `Semaphore` class (~20 LOC) using Dart's `Completer`. Inline the concurrency pattern or provide a minimal `runConcurrent` utility without the perf logging overhead. Remove `pool` from pubspec.

**Files affected:** `network_concurrency_executor.dart` + 7 consumers

### C4: Consolidate Crypto Dependencies

**Problem:** `encrypt` and `pointycastle` are both used in `auth_repository_impl.dart` for RSA encryption. `crypto` is used in `wbi_helper_provider.dart` for MD5. Three packages for two operations.

**Solution:** Use only `pointycastle` for RSA (it's the underlying engine anyway) and `crypto` for hashing. Remove `encrypt` package which is just a wrapper around `pointycastle`.

**Files affected:** `auth_repository_impl.dart`, `auth_repository_impl.helpers.dart`

### C5: Simplify Performance Infrastructure

**Problem:** 7 perf logger files (`network_perf_logger.dart`, `video_perf_logger.dart`, `list_perf_logger.dart`, `feature_flow_perf_logger.dart`, `startup_perf_logger.dart`, `frame_timing_sampler.dart`, `performance_policy.dart`) each define their own event enums and static log methods. All ultimately call `developer.log()` in debug mode only.

**Solution:** 
- Keep `performance_policy.dart` + `frame_timing_sampler.dart` (they have real runtime behavior affecting UI rendering)
- Consolidate all other loggers into a single `dev_logger.dart` with a unified `DevLogger.log(category, event, fields)` API
- Remove individual logger files and their event enums
- The `NetworkConcurrencyExecutor` logging becomes optional/removed

**Files affected:** ~29 files that import perf loggers

### C6: Remove Deprecated Typedef and Stale Contracts

**Problem:** 
- `watch_later_contract.dart` contains only a deprecated typedef pointing to `WatchLaterPort`
- `UserProfileInfo` in `user_profile_lookup_contract.dart` is a plain class (should be freezed)

**Solution:** Delete `watch_later_contract.dart`, remove its export from `core_contracts.dart`. Convert `UserProfileInfo` to freezed.

**Files affected:** 2-3 files

### C7: Strengthen Analysis and Build Configuration

**Problem:** 
- `analysis_options.yaml` only uses base `flutter_lints` — no strict rules
- No `build.yaml` exists despite 7 active code generators

**Solution:**
- Add strict rules: `strict-casts`, `strict-raw-types`, `prefer_single_quotes`, `always_use_package_imports`, `avoid_dynamic_calls`
- Create `build.yaml` with `generate_for` filters to speed up builds
- Fix any new analysis warnings introduced by stricter rules

**Files affected:** Project-wide (analysis warnings), 2 new config files

### C8: Convert `AudioPlaybackSnapshot` to Freezed

**Problem:** `AudioPlaybackSnapshot` in `audio_playback_state_gate.dart` has hand-written `==` and `hashCode`. All other value objects in the project use freezed.

**Solution:** Convert to `@freezed` class. Keep `AudioPlaybackStateGate` as-is (it has mutable state and behavior).

**Files affected:** 1-2 files

## Out of Scope

- Feature-level refactoring (UI, business logic changes)
- New feature development
- Test coverage expansion (beyond what's needed to verify changes)
- Router or navigation changes
- State management migration

## Success Criteria

- Zero barrel-chain files (no file whose only purpose is re-exporting other files, except `core_contracts.dart`)
- Zero duplicate model definitions across DTO/domain layers
- `pool` and `encrypt` packages removed from pubspec
- All value objects use freezed (no hand-written equality)
- Strict analysis passes with zero warnings
- `build.yaml` present and generators scoped
- Perf infrastructure reduced from 7 files to 3
- All architecture tests still pass
