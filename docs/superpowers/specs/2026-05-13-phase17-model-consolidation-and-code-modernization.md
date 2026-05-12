# Phase 17: Model Consolidation & Code Modernization

**Status:** Active  
**Date:** 2026-05-13  
**Supersedes:** Phase 16 (completed — guard-green baseline achieved)

## Problem Statement

The architecture is structurally sound (Phase 16 guards pass), but the codebase carries accumulated redundancy that hurts readability and maintainability:

1. **Duplicate video models**: `ProfileVideoOwner`/`ProfileVideoStats` are field-for-field identical to core `VideoOwner`/`VideoStat`. `RankingVideo` is a flattened subset of `VideoModel`. Three representations of the same domain concept exist.
2. **Duplicate user models**: `UserCardModel` and `UserProfileInfo` overlap heavily (mid, name, avatar). `ProfileRelationUser` uses plain classes without freezed or equality.
3. **Hand-written value objects**: 9 files contain manual `copyWith`/`==`/`hashCode` implementations that should use freezed (error-prone, verbose, no sealed exhaustiveness).
4. **Hand-written Riverpod providers**: ~12 feature-level providers use legacy `Provider`/`FutureProvider`/`AsyncNotifierProvider` constructors instead of `@riverpod` code generation.
5. **Dead indirection layers**: 3 re-export files in `data/dtos/` that just point back to domain entities. `runtime_dependencies.dart` adds a watch-only layer over bootstrap providers.
6. **Stale tracking**: 3 Phase 8 issues remain `in_progress` but are superseded by later phases.

## Target State

1. **Single video model hierarchy**: Features reuse `VideoOwner` and `VideoStat` from `core/contracts/`. `ProfileVideo` and `RankingVideo` compose core types instead of duplicating them.
2. **Unified user contract**: One `UserCard` contract covers the common (mid, name, face) triple. Feature-specific extensions compose it.
3. **All value objects use freezed**: Zero hand-written `copyWith`/`==`/`hashCode` (except `ThemeExtension` which requires manual `lerp`).
4. **All feature providers use @riverpod**: Generated providers with proper lifecycle, type safety, and IDE navigation.
5. **No dead indirection**: No re-export-only files pointing to a single source. No double-layer provider wrappers.
6. **Clean issue tracker**: Stale issues superseded, only active work tracked.

## Design Principles

- **Compose, don't duplicate**: If two models share fields, one should contain or extend the other.
- **Generated over hand-written**: freezed for data, @riverpod for providers — less code, fewer bugs, better tooling.
- **Delete over deprecate**: No backward-compat shims. Remove dead code immediately.
- **Single source of truth**: Every concept has exactly one canonical definition.
- **Incremental verification**: Each task independently passes `flutter test` and `build_runner`.

## Verification

- `flutter test test/architecture --reporter compact` passes.
- `dart run build_runner build --delete-conflicting-outputs` succeeds with no errors.
- `dart analyze` reports no new warnings.
- No hand-written `copyWith` methods remain (except ThemeExtension).
- No duplicate Owner/Stat/UserCard definitions across features.

## Scope Boundaries

**In scope:**
- Model consolidation (video, user)
- Freezed migration for all value objects
- @riverpod migration for feature providers
- Dead indirection removal
- Issue tracker cleanup

**Out of scope:**
- Routing changes (go_router_builder already working)
- New feature development
- UI/widget refactoring
- Dependency version upgrades (unless required by migration)
