# Legacy Culcul Refactoring Plan

Archived: 2026-06-05

This document was an early coarse refactoring plan. The active single source of
truth is `docs/architecture/app_architecture_refactor_plan.md`.

## Original Content

## Phase 1: Structural Changes (COMPLETED)

- [x] Rename `core/contracts/` → `core/models/`
- [x] Move `ui/theme/` → `core/theme/`
- [x] Merge `format_utils.dart` + `format_extensions.dart`
- [x] Inline `MediaRuntimeInitializer` (delete thin wrapper)
- [x] Merge `ui/assemblies/` → `ui/widgets/`

## Phase 2: Code Consolidation (IN PROGRESS)

### 2.1 Network Layer Interceptor Consolidation
Merge 6 interceptors into 3:
- `CsrfInterceptor` + `TokenInterceptor` + `WbiInterceptor` → `AuthInterceptor`
- `InFlightDedupInterceptor` (keep as-is, good dedup logic)
- `EndpointCacheOptionsInterceptor` + `NetworkQualityInterceptor` → `RequestPolicyInterceptor`

### 2.2 Migrate core/services to features
- `CommentService` → `features/video/video_api.dart` (or `features/dynamic/`)
- `RelationService` → `features/profile/profile_api.dart`
- `MediaService` → `core/utils/` (generic utility)

### 2.3 Flatten Feature Domain Layers
Remove empty `domain/` directories, move entities to feature root:
- `features/auth/domain/entities/` → `features/auth/`
- `features/favorites/domain/entities/` → `features/favorites/`
- etc.

### 2.4 Simplify Pagination System
- Merge `PagedListState` + `PagedListStateTransitions` into single file
- Simplify `ScrollLoadTrigger` (remove excessive logging)
- Keep `OffsetPagedAsyncNotifier` mixin (actively used)

### 2.5 Performance Optimization
- Simplify `RuntimePerformancePolicy` (reduce from 4 profiles to 2)
- Simplify `EndpointPolicy` (reduce configuration surface)
- Remove `PerformancePolicyController` static singleton pattern

## Phase 3: Model Cleanup (FUTURE)

### 3.1 Unify Model Definitions
- Audit `core/models/` vs `features/*/domain/entities/` for duplicates
- Ensure cross-feature models use freezed consistently
- Remove hand-written `==`, `hashCode`, `toString` boilerplate

### 3.2 Remove Dead Code
- Audit unused imports
- Remove unused utility functions
- Clean up empty files

## Phase 4: Performance & Polish (FUTURE)

### 4.1 Startup Optimization
- Review `main.dart` initialization sequence
- Ensure lazy loading where appropriate

### 4.2 Memory Optimization
- Review image caching strategy
- Ensure proper disposal in Riverpod providers

### 4.3 Build Optimization
- Review `build_runner` configuration
- Consider build caching strategies

## Success Criteria

1. All tests pass (`dart analyze` clean)
2. No duplicate model definitions
3. No empty domain/service layers
4. Reduced total lines of code by ~10-15%
5. Clearer feature boundaries
6. Consistent patterns across features
