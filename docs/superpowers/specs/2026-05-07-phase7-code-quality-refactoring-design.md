# Phase 7: Code Quality & Architectural Integrity

**Status:** DRAFT
**Date:** 2026-05-07
**Goal:** Fix real architectural violations, unify error handling, eliminate cross-feature coupling, and harden core infrastructure.

## Context

Phase 6 completed structural normalization (all 13 features have FULL directory compliance). However, a deep code analysis reveals that while the **directory structure** is clean, the **actual code** violates architecture rules in significant ways:

- **42 cross-feature imports** break the "features must NOT import from other features" rule
- **Domain entities in video feature** are hollow re-exports of data DTOs (no real domain/data separation)
- **14 `dataOrNull!` force-unwraps** will crash at runtime on API failures
- **Inconsistent error handling** across view models (3 different patterns)
- **Core infrastructure bugs** in pagination, audio, session management
- **Zero accessibility support** in shared widgets

This phase addresses code-level architecture, not directory structure.

## Problem Analysis

### P0: Cross-Feature Imports (42 violations)

The architecture rule states: "Features must NOT import from other features (use `core/contracts/` for shared types)."

**Reality:** 42 direct cross-feature imports exist:

| Importing Feature | Imported Feature | What's Imported | Count |
|---|---|---|---|
| video, home, favorites, history, profile, notification, live, to_view, dynamic | **auth** | `auth_view_model.dart` (user state) | 21 |
| video | **profile** | `feature_scope.dart` | 1 |
| dynamic | **video** | widgets (VideoCard, etc.) | 3 |
| dynamic | **search** | `topic_search_view_model.dart` | 2 |
| dynamic | **profile** | `recently_followed_view_model.dart` | 1 |
| home | **search** | `search_view_model.dart` | 1 |
| home | **to_view** | `to_view_view_model.dart` | 1 |
| home | **live** | `live_view_model.dart` | 1 |
| live | **auth** | domain + scope | 2 |
| live | **profile** | `live_room_view_model.dart` | 1 |
| notification | **profile** | view models | 2 |
| profile | **dynamic** | widgets | 2 |
| profile | **notification** | route | 1 |
| search | **dynamic** | page | 1 |
| favorites | **auth** | view model | 2 |

**Root cause:** No shared contract for user session state. Every feature needs to know "who is the current user?" and directly imports `auth`'s internal view model.

**Solution:** Extract shared contracts to `core/contracts/` and create cross-cutting providers.

### P1: Domain Layer Purity (Video Feature)

All 7 entity files in `video/domain/entities/` are one-line re-exports of data DTOs:

```dart
// domain/entities/video_detail.dart
export '../../data/dtos/video_detail_dto.dart';
```

The DTOs carry `@JsonKey`, `@JsonConverter`, `fromJson`/`toJson` — they are serialization models, not domain entities. The domain layer has zero independence from the data layer.

**Contrast:** `auth/domain/entities/user_entity.dart` is a proper plain Dart class with `copyWith`, `==`, `hashCode`, no JSON, no freezed.

**Impact:** Any DTO schema change ripples through the entire codebase. Domain testing is impossible since "entities" carry JSON serialization.

### P2: Inconsistent Error Handling

Three different patterns for handling `Result` objects:

**Pattern A — Explicit branching (good):**
```dart
result.when(
  success: (data) => state = state.copyWith(data: data),
  failure: (error) => state = state.copyWith(error: error),
);
```

**Pattern B — Silent swallowing (problematic):**
```dart
return result.dataOrNull ?? const <VideoModel>[];
// API failure → empty list, user sees no error
```

**Pattern C — Force unwrap (dangerous):**
```dart
final data = result.dataOrNull!; // Crash on API failure
```

Pattern C appears in **14 locations** across video, dynamic, and notification features.

### P3: Core Infrastructure Bugs

1. **Pagination:** `OffsetPagedAsyncNotifier.loadNextPage` does not update `state` when result is empty (lines 80-84). UI becomes stale.
2. **Audio handler:** Stream subscriptions in constructor are never stored — cannot be cancelled, potential memory leak.
3. **Certificate validation:** `dio_client.dart:43` sets `onBadCertificate = (_) => true` — accepts all certificates.
4. **Token interceptor:** Cookie refresh errors silently swallowed (lines 48-51).
5. **CSRF cache:** No TTL, depends on external invalidation call.

### P4: Pattern Inconsistencies

1. **`settings/feature_scope.dart`** — Uses manual `Provider` instead of `@riverpod` codegen (12/13 features use codegen).
2. **`home/route_entry.dart`** — Uses raw `export` instead of `buildXxxRoutePage()` functions.
3. **`home/data/home_feed_data_source.dart`** — Named `DataSource` instead of `RepositoryImpl`, doesn't use `RequestExecutorBinding`.
4. **Search view models** — Use manual `AsyncNotifier` instead of `@riverpod` codegen.

### P5: UI Quality

1. **Zero `Semantics` wrappers** in 30+ shared widgets — screen readers get no meaningful announcements.
2. **Hardcoded English** in `AppSearchBar` (`'Search videos...'`).
3. **`AppNetworkImage`** extends `ConsumerWidget` but never uses `ref` — unnecessary overhead.
4. **`AppClickable`** has 4 deprecated parameters still wired into build.
5. **`FollowButton`** wraps single `Text` in unnecessary `Row`.

### P6: Missing Contracts

Shared types that cross feature boundaries should live in `core/contracts/`:

1. **User session state** — Currently accessed via `auth_view_model.dart` directly (21 imports).
2. **Video model** — `core/contracts/video_model_contract.dart` exists but video feature's domain re-exports DTOs instead.
3. **Comment model** — `core/contracts/comment_contract.dart` exists, video domain re-exports it (acceptable).
4. **Navigation actions** — `to_view`, `live` view models imported by `home` for action buttons.

## Design

### 1. Cross-Feature Decoupling (P0)

**New contracts in `core/contracts/`:**

```
core/contracts/
  user_session_contract.dart    # UserSession interface (uid, isLoggedIn, avatar, name)
  nav_action_contract.dart      # Navigation action types (openVideo, openProfile, etc.)
```

**New providers in `core/`:**

```
core/session/
  current_user_provider.dart    # Provides UserSession? from auth state
  nav_action_provider.dart      # Provides navigation callbacks
```

**Migration:** Replace all 21 `auth_view_model.dart` imports with `core/session/current_user_provider.dart`. Replace cross-feature navigation imports with `core/session/nav_action_provider.dart`.

### 2. Video Domain Purity (P1)

Create proper domain entities separate from DTOs:

```
video/domain/entities/
  video_detail_entity.dart      # Plain class, no JSON, no freezed
  play_url_entity.dart          # Plain class
  player_info_entity.dart       # Plain class
  related_video_entity.dart     # Plain class
  subtitle_entity.dart          # Plain class
  video_mapping.dart            # DTO → Entity extensions (in data layer)
```

Move `video_mapping.dart` from domain to `data/`. Add mapping functions in `data/video_repository_impl.dart`.

### 3. Error Handling Unification (P2)

**Standard pattern:** All view models use `result.when()` with explicit success/failure branches.

**Eliminate `dataOrNull!`:** Replace all 14 force-unwraps with proper error handling.

**Eliminate silent swallowing:** Replace `result.dataOrNull ?? []` with error state propagation.

**Add `CancelAppError` check** to all view models that handle cancellable operations.

### 4. Core Bug Fixes (P3)

1. **Pagination:** Update `state` in empty-result path of `loadNextPage`.
2. **Audio handler:** Store `StreamSubscription` objects, add `dispose()` method.
3. **Certificate validation:** Gate behind `kDebugMode`.
4. **Token interceptor:** Log refresh failures, add cooldown.
5. **CSRF cache:** Add TTL or tie to cookie lifecycle.

### 5. Pattern Standardization (P4)

1. **Settings:** Convert `feature_scope.dart` to use `@riverpod` codegen.
2. **Home route_entry:** Convert to `buildXxxRoutePage()` function pattern.
3. **Home data source:** Rename to `HomeRepositoryImpl`, add `RequestExecutorBinding`.
4. **Search view models:** Convert to `@riverpod` codegen (lower priority).

### 6. Accessibility (P5)

Add `Semantics` wrappers to key interactive widgets:
- `AppClickable` — `semanticsLabel`
- `FollowButton` — `semanticsLabel` (following/not following state)
- `AppAvatar` — `semanticsLabel` (user name)
- `AppSearchBar` — `semanticsLabel`, `semanticsHint`
- `AppNetworkImage` — `semanticsLabel` (image description)

### 7. Dead Code Cleanup (P5)

- Remove deprecated parameters from `AppClickable`
- Fix `AppNetworkImage` to extend `StatelessWidget`
- Remove unnecessary `Row` from `FollowButton`
- Remove commented-out imports
- Address or remove TODO comments

## Out of Scope

- Video feature decomposition (~120 files, controls/, danmaku/ sub-engines)
- Search view model codegen migration (large effort, low impact)
- Golden tests / integration tests (separate initiative)
- `core/utils/` subdirectory splitting (keep flat, already has barrel)

## Verification

```bash
flutter analyze                    # No new warnings
flutter test                       # All tests pass
flutter test test/architecture/    # Architecture guards pass (cross-feature import count → 0)
make ci                            # Full CI pipeline passes
```

## Effort

Large. ~50-60 files modified across 4 features + core. Highest risk is cross-feature decoupling (touches many files). Domain entity extraction in video is medium risk. Error handling unification is low risk but tedious.

## Risk Mitigation

- **Feature flags:** None needed — all changes are internal refactoring.
- **Rollback:** Each task is independently committable. If a task breaks tests, revert that commit.
- **Testing:** Run `flutter test` after each task. Architecture guard tests verify cross-feature imports are eliminated.
- **Incremental delivery:** Tasks are ordered by dependency (contracts first, then consumers).
