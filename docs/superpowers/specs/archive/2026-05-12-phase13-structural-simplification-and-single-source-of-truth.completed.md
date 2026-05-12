# Phase 13: Structural Simplification & Single Source of Truth

**Status:** Completed and archived  
**Date:** 2026-05-12  
**Supersedes:** Phase 12 (completed)

## Problem Statement

After 12 phases of boundary normalization, the codebase has correct layering but excessive structural ceremony. The remaining debt is not about *where* code lives, but about *how much indirection* exists between intent and implementation. This manifests as:

1. Redundant provider wiring (3 files per feature where 1 suffices)
2. Duplicate model definitions (VideoModel exists in both `core/contracts/` and `features/video/domain/`)
3. Layer violations (DTOs living in `domain/entities/` in the video feature)
4. Dead code (deprecated files still present)
5. Over-sharded implementations (notification repo: 11 files for 1 class)
6. Repeated boilerplate (route transitions, provider re-exports)
7. Custom implementations where battle-tested packages exist

## Design Principles

- **Single Source of Truth**: Every concept has exactly one canonical definition
- **Minimal Indirection**: No file should exist solely to re-export or alias another
- **Generator-First**: If a code generator can produce it, don't hand-write it
- **Popular Libraries Over Custom Code**: Prefer well-maintained packages over bespoke implementations when they reduce surface area without adding coupling
- **Flat Over Nested**: Fewer files with clear names beat deep hierarchies

## Changes

### C1: Collapse Provider Wiring Indirection

**Current (per feature, 3 files):**
```
data/<name>_repository_impl.dart        → @riverpod provider + class
data/<name>_repository_entry.dart       → re-exports impl provider
application/<name>_repository_provider.dart → assigns data.xxxProvider to final
```

**Target (per feature, 1 file):**
```
data/<name>_repository_impl.dart        → @riverpod provider + class
feature_scope.dart                      → directly exports the generated provider
```

Delete all `*_repository_entry.dart` and `application/*_repository_provider.dart` files. Update `feature_scope.dart` to export directly from the impl's `.g.dart`. This removes ~26 files across 13 features.

### C2: Consolidate VideoModel to Single Definition

**Current:**
- `core/contracts/video_model_contract.dart` — shared contract with `VideoOwner`/`VideoStat`
- `features/video/domain/entities/video_model_dto.dart` — separate freezed class with `Owner`/`Stat`
- `core/data/network/dtos/video_model_contract_dto.dart` — typedef bridge

**Target:**
- `core/contracts/video_model_contract.dart` — the ONE definition (freezed, with JSON serialization)
- Video feature imports from `core/contracts/` like every other feature
- Delete the duplicate in `features/video/domain/entities/video_model_dto.dart`
- Delete the typedef bridge

### C3: Fix Video Feature DTO Layer Violation

**Current:** DTOs (`video_detail_dto.dart`, `play_url_dto.dart`, etc.) live in `domain/entities/` and are re-exported into `data/dtos/` via barrels.

**Target:** Move all `*_dto.dart` files from `domain/entities/` to `data/dtos/`. Remove the reverse re-export barrels. Domain entities should contain only pure domain models without serialization annotations.

### C4: Remove Dead Code

Delete:
- `lib/app/bootstrap/app_dependencies.dart` (typedef to AppRuntime, unused)
- `lib/app/bootstrap/provider_overrides.dart` (deprecated, delegates to root_overrides)
- `lib/core/utils/validation_utils.dart` (zero imports in codebase)

### C5: Simplify Notification Repository Sharding

**Current:** `notification_repository_impl.dart` + 10 `.part` files (cleanup_policy, feed_sync, local_read_store, message_send_helpers, message_send_service, message_support, message_support_helpers, message_sync, session_sync, stream_watchers).

**Target:** Consolidate into 3-4 focused files based on actual behavioral boundaries:
- `notification_repository_impl.dart` — core CRUD + sync
- `notification_messaging_service.dart` — send/receive message logic
- `notification_stream_manager.dart` — WebSocket/stream lifecycle

Use composition (separate classes) instead of `part` files. The repository impl delegates to these collaborators.

### C6: Route Transition Base Class

**Current:** Every `GoRouteData` subclass repeats:
```dart
@override
Page<void> buildPage(BuildContext context, GoRouterState state) =>
    SlideFromRightTransitionPage(child: build(context, state));
```

**Target:** Create `AppRouteData` base class in `app/router/` that provides the default transition. Routes only override `build()`. Special transitions override `buildPage()` explicitly.

### C7: Replace Custom Retry Interceptor with dio_smart_retry

**Current:** `lib/core/data/network/interceptors/retry_interceptor.dart` — hand-written exponential backoff with jitter.

**Target:** Replace with `dio_smart_retry` package (15k+ likes, actively maintained). Same behavior, zero maintenance burden. Keep `in_flight_dedup_interceptor.dart` (no package equivalent).

### C8: Clarify UI Directory Boundary

**Current:** Both `ui/compositions/` and `ui/widgets/` contain `comments/` and `users/` subdirectories.

**Target:** Rename `ui/compositions/` to `ui/assemblies/` and add a one-line doc comment in the barrel. The distinction:
- `widgets/` — atomic, reusable, feature-agnostic primitives (buttons, cards, inputs)
- `assemblies/` — composed units that combine multiple widgets for specific cross-feature use cases (feed cards, comment threads, user profiles)

### C9: Clean Archive File Suffixes

Rename files in archive that lack proper status suffixes:
- `shared-to-core-ui-ownership-normalization-roadmap.md` → `.completed.md`
- `shared-perf-ownership-normalization-design.md` → `.completed.md`
- `shared-contracts-ownership-normalization-design.md` → `.completed.md`
- `phase7-code-quality-refactoring.draft.md` → `.superseded.md`
- `phase7-code-quality-refactoring-design.draft.md` → `.superseded.md`

## Out of Scope

- Feature behavior changes (this is purely structural)
- New features or UI changes
- Test coverage expansion (separate concern)
- Performance optimization (already addressed in prior phases)

## Success Criteria

- Zero `*_repository_entry.dart` files remain
- Zero `application/*_repository_provider.dart` files remain
- VideoModel has exactly ONE freezed definition in `core/contracts/`
- No `*_dto.dart` files in any `domain/` directory
- Notification feature has ≤4 implementation files (down from 11)
- All route classes extend `AppRouteData` (except those with custom transitions)
- `dio_smart_retry` replaces custom retry interceptor
- `dart analyze` reports zero errors
- All existing tests pass
