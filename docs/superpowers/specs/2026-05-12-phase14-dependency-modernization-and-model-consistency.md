# Phase 14: Dependency Modernization & Model Consistency

**Status:** Active  
**Date:** 2026-05-12  
**Supersedes:** Phase 13 (completed)

## Problem Statement

Phase 13 eliminated structural ceremony at the feature-scope level. Phase 14 targets the remaining inconsistencies that hurt readability and maintainability:

1. **Live feature architecture inversion** — Domain entities contain JSON serialization (`@JsonKey`, `fromJson`), while `data/dtos/` is a facade of single-line re-exports pointing back to domain. The separation provides zero value and confuses the layer boundary.
2. **Zero-value indirection files** — Typedef-only files (17 aliases in `comment_contract_dto.dart`), redundant barrel chains (`favorite_dtos.dart` → `index.dart` → actual files), and alias typedefs (`LiveRoomModel` = `LiveRoomSummary`).
3. **Unmaintained storage dependency** — Hive is effectively abandoned upstream. The project already uses Drift for structured data; simple KV storage should migrate to `shared_preferences`.
4. **Unused and unpinned dependencies** — Dead packages inflate the dependency tree; unpinned versions (`any`) break reproducible builds.
5. **Inconsistent model style** — Some domain entities use freezed, others are hand-written with manual `copyWith`. No technical reason for the divergence.

## Design Principles

- **One Style, One Tool**: If freezed is the project standard for data classes, use it everywhere — no hand-written alternatives.
- **Remove What Adds Nothing**: A typedef, re-export, or wrapper that doesn't transform, validate, or abstract is dead weight.
- **Modern Defaults**: Prefer actively maintained packages with large community adoption.
- **Pin Everything**: Reproducible builds require exact version constraints on all dependencies.

## Changes

### C1: Fix Live Feature DTO/Domain Inversion

**Current:**
- `features/live/domain/entities/*.dart` — freezed classes WITH `fromJson`, `@JsonKey` (serialization in domain)
- `features/live/data/dtos/*.dart` — single-line re-exports pointing to domain entities
- `features/live/data/dtos/live_history_danmaku_model.dart` — DIFFERENT implementation from domain version (genuine duplication)

**Target:**
- `features/live/data/dtos/*.dart` — freezed classes with JSON serialization (the actual DTOs)
- `features/live/domain/entities/*.dart` — pure domain models (no serialization annotations), OR eliminated entirely if the DTO IS the domain model (common in read-heavy features)
- Resolve `live_history_danmaku_model.dart` duplication: keep the typed domain version, make the DTO version a proper mapper

**Decision:** Since the live feature is read-heavy with no domain logic transformations, collapse to a single model layer in `data/dtos/` and delete the empty `domain/entities/` re-export stubs. The "domain entity" IS the DTO — pretending otherwise adds files without value.

### C2: Remove Zero-Value Indirection

**Files to delete or inline:**

| File | Reason |
|------|--------|
| `core/data/network/dtos/comment_contract_dto.dart` | 17 typedefs mapping `XxxDto` → `Xxx` with zero transformation |
| `features/favorites/data/dtos/favorite_dtos.dart` | Re-exports `index.dart` (one level of pointless indirection) |
| `features/favorites/data/dtos/index.dart` | Re-exports 2 actual files (replace with direct imports at call sites) |
| `features/live/domain/entities/live_room_model.dart` | `typedef LiveRoomModel = LiveRoomSummary` — use `LiveRoomSummary` directly |
| `features/video/data/dtos/video_model_dto.dart` | Single-line re-export of `video_model_contract.dart` |

**Action:** Delete these files. Update all import sites to reference the actual source directly.

### C3: Migrate Hive → shared_preferences

**Current Hive usage (6 files):**
- Settings storage (theme, locale, preferences)
- User info cache (logged-in user card)
- Auth session data (tokens, cookies)

**Target:**
- Simple KV (settings, preferences) → `shared_preferences` (actively maintained, 10k+ likes, platform-native)
- Structured cache (user info) → Drift (already in project, proper schema + migrations)
- Auth tokens → `flutter_secure_storage` for sensitive data, or keep in cookie_jar (already managed by dio_cookie_manager)

**Packages to add:** `shared_preferences: ^2.5.0`, `flutter_secure_storage: ^9.2.0`  
**Packages to remove:** `hive: ^2.2.3`, `hive_flutter: ^1.1.0`

### C4: Dependency Hygiene

**Remove unused packages:**
- `flutter_staggered_grid_view: ^0.7.0` — zero imports in codebase
- `flutter_spinkit: ^5.2.2` — zero imports in codebase

**Pin unpinned dev dependencies:**
- `go_router_builder: any` → pin to specific version
- `retrofit_generator: any` → pin to specific version

**Move misplaced dependency:**
- `flutter_riverpod: ^3.3.1` — currently in dev_dependencies, verify if used only in tests (correct) or also in lib/ (needs to move to dependencies)

**Evaluate redundancy:**
- `encrypt: ^5.0.3` + `pointycastle: ^3.9.1` — both are crypto packages. If `encrypt` wraps `pointycastle`, keep only what's needed.

### C5: Standardize Domain Entities on Freezed

**Current inconsistency:**
- Live feature: freezed entities (with serialization — to be fixed by C1)
- Favorites feature: hand-written `FavoriteFolder` with manual `copyWith`
- History feature: hand-written entities
- Most other features: freezed

**Target:** All domain entities and DTOs use freezed. Benefits:
- Consistent `copyWith`, `==`, `hashCode`, `toString`
- JSON serialization via `@JsonSerializable` on freezed classes
- Immutability guaranteed by default
- Less hand-written code to maintain

Convert remaining hand-written entities to freezed.

### C6: Migrate wbi_helper_provider to @Riverpod

**Current:** `lib/core/data/network/providers/wbi_helper_provider.dart` uses hand-written `Provider<T>((ref) => ...)` syntax.

**Target:** Use `@Riverpod` annotation for consistency with the rest of the codebase. This is the last hand-written provider that isn't an intentional "override port".

## Out of Scope

- Feature behavior changes
- New features or UI changes
- Test coverage expansion
- Performance optimization
- Notification feature (already simplified in Phase 13)
- Route or navigation changes

## Success Criteria

- Zero re-export stubs in `features/live/data/dtos/`
- Zero typedef-only files that don't transform data
- Hive fully removed from pubspec.yaml and all imports
- Zero unused packages in pubspec.yaml
- All dev dependencies pinned to specific versions
- All domain entities use freezed (no hand-written `copyWith`)
- `dart analyze` reports zero errors
- All existing tests pass
- `flutter build` succeeds
