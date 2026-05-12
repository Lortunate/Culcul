# Phase 18: Architecture Simplification & Single Source of Truth

**Status:** Active  
**Date:** 2026-05-13  
**Supersedes:** Phase 17 (partially landed — remaining tasks absorbed here)

## Problem Statement

Phase 17 landed the highest-value model consolidations (ProfileVideoOwner/Stats removal, runtime_dependencies elimination, 6 freezed migrations, partial @riverpod migration). However, the codebase still carries structural debt that makes it harder to read, navigate, and maintain than necessary:

1. **19 barrel/re-export files** violate the "no barrel-chain files except core_contracts.dart" rule. Developers must trace through indirection to find actual definitions.

2. **Model duplication persists** in three areas:
   - `ToViewOwnerModelDto`/`ToViewStatModelDto` duplicate core `VideoOwner`/`VideoStat`
   - `FavoriteOwner` duplicates core `VideoOwner` (identical fields: mid, name, face)
   - `OfficialVerify`/`VipInfo` defined in 3 places (profile DTO, relation_user_contract, comment_contract)
   - `UserProfile` DTO → `ProfileUser` domain entity mapping is a 1:1 field copy with zero transformation

3. **Hand-written value objects** remain in 3 files (PlaybackSnapshot, PublishDynamicUiState, FavFolderDetailState) plus 4 plain classes in `dynamic_content_entities.dart` that lack freezed entirely.

4. **Hand-written providers** (~8-12 remaining) use legacy patterns instead of `@riverpod` code generation.

5. **Thin abstractions add no value**: 4 repository interfaces (7 lines each, single method, single implementation) exist purely for "clean architecture" ceremony. The interface/impl split for `UserProfile`→`ProfileUser` with a no-op mapper is pure overhead.

6. **Confusing typedef aliases**: `typedef Owner = VideoOwner` and `typedef Stat = VideoStat` in core contracts create two names for the same thing.

7. **Dead code**: `NotificationImageUploader` abstract class is never referenced outside its own file.

8. **DTO barrel files** in every feature's `data/dtos/` directory (video_dtos.dart, live_dtos.dart, etc.) re-export 3-9 files each — these are the most common import targets and create unnecessary indirection.

## Target State

1. **Zero barrel files** except `core_contracts.dart` and `ui/ui.dart` (public API surface). All imports point directly to the defining file.

2. **Single source of truth for every model**: One `OfficialVerify`, one `VipInfo`, one `VideoOwner`. Features import from core contracts. DTOs that are structurally identical to domain models are eliminated — use the domain model directly with `fromJson`.

3. **All value objects use freezed**: Zero hand-written `copyWith`/`==`/`hashCode` (except ThemeExtension).

4. **All feature providers use @riverpod**: Generated providers with proper lifecycle.

5. **No ceremony-only abstractions**: Repository interfaces removed where there's only one implementation and no testing benefit beyond what the impl itself provides. The DTO→domain mapper pattern removed where the mapping is 1:1 field copy.

6. **No dead code**: Every file, class, and method is reachable from the app's entry point or tests.

7. **No confusing aliases**: One name per concept, no typedefs that just rename.

## Design Principles

- **Direct over indirect**: Import the source, not a re-export. Call the impl, not an interface with one implementor.
- **Eliminate, don't consolidate**: If two things are identical, delete one — don't create a third "unified" version.
- **Generated over hand-written**: freezed for data, @riverpod for providers.
- **Flat over nested**: If a feature's `domain/` layer adds nothing (no business logic, no multiple impls), collapse it into `data/`.
- **Pragmatic layering**: Keep interface/impl split only where it enables testing or polymorphism. A repository that wraps a single API call with no logic doesn't need an interface.

## Scope

**In scope:**
- Barrel file elimination (all 19 files)
- Model deduplication (VideoOwner, OfficialVerify, VipInfo, UserProfile/ProfileUser)
- Remaining freezed migrations (3 view model states + dynamic_content_entities)
- Remaining @riverpod migrations
- Thin abstraction removal (single-method/single-impl repository interfaces)
- No-op mapper elimination
- Dead code removal
- Typedef alias removal

**Out of scope:**
- Routing changes
- New feature development
- UI/widget refactoring
- Dependency version upgrades (unless required)
- Core session providers (justified by override-at-bootstrap pattern)

## Verification

- `dart run build_runner build --delete-conflicting-outputs` — no errors
- `dart analyze` — no new warnings
- `flutter test test/architecture --reporter compact` — all pass
- `flutter test` — full test suite passes
- `grep -r "typedef.*=" lib/core/contracts/` returns only type aliases with genuine semantic value
- No file in `lib/features/*/data/dtos/` is a pure re-export barrel
- No file in `lib/features/*/domain/entities/` is a pure re-export barrel

## Risk Assessment

- **Architecture tests may need updating**: Removing repository interfaces changes the import graph. Tests that assert "domain/ does not import data/" may need adjustment if we collapse layers.
- **Generated code churn**: Each freezed/riverpod migration touches `.g.dart` and `.freezed.dart` files. Run build_runner after each logical unit, not in batch.
- **API response coupling**: Eliminating DTOs that are 1:1 with domain models means the domain model now carries `@JsonKey` annotations. This is acceptable — the "pure domain" ideal adds no value when the mapping is identity.
