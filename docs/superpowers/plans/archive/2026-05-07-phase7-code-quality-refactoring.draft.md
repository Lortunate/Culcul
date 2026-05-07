# Phase 7: Code Quality & Architectural Integrity — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Spec:** `docs/superpowers/specs/2026-05-07-phase7-code-quality-refactoring-design.md`
**Date:** 2026-05-07

## Execution Order

Contracts first (no behavior change), then cross-feature decoupling (high impact), then domain purity (medium risk), then error handling (tedious but safe), then core fixes (low risk), then UI polish (low risk).

---

## Part A: Shared Contracts & Providers

### Task 1: Create UserSession contract and provider

**Goal:** Eliminate 21 cross-feature imports of `auth_view_model.dart` by extracting the shared concept ("who is the current user?") into `core/contracts/`.

**Files:**
- Create: `lib/core/contracts/user_session_contract.dart`
- Create: `lib/core/session/current_user_provider.dart`
- Modify: `lib/core/contracts/core_contracts.dart` (add export)

- [ ] **Step 1: Define UserSession contract**

Create `lib/core/contracts/user_session_contract.dart`:

```dart
/// Minimal user session state needed by features outside auth.
/// Features should depend on this contract, not on auth's internal view models.
abstract interface class UserSession {
  int get uid;
  bool get isLoggedIn;
  String? get avatarUrl;
  String? get nickname;
}
```

- [ ] **Step 2: Create CurrentUserProvider**

Create `lib/core/session/current_user_provider.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:culcul/core/contracts/user_session_contract.dart';

/// Provides the current user session. Returns null if not logged in.
/// Backed by auth's state at bootstrap time via ProviderScope override.
final currentUserProvider = Provider<UserSession?>((ref) {
  throw UnimplementedError('Must be overridden at bootstrap');
});
```

- [ ] **Step 3: Add to barrel export**

Add `export 'contracts/user_session_contract.dart';` to `lib/core/contracts/core_contracts.dart`.

- [ ] **Step 4: Wire up in main.dart**

In `lib/main.dart`, add `currentUserProvider` override that reads from `auth_view_model_provider` and adapts to `UserSession`.

- [ ] **Step 5: Verify**

Run: `flutter analyze lib/core/`
Expected: No errors

- [ ] **Step 6: Commit**

```bash
git add lib/core/contracts/ lib/core/session/ lib/main.dart
git commit -m "feat(core): add UserSession contract and currentUserProvider"
```

---

### Task 2: Create NavigationAction contract

**Goal:** Eliminate cross-feature imports of view models used only for navigation (e.g., `to_view_view_model.dart` imported by `home` for "add to watch later" action).

**Files:**
- Create: `lib/core/contracts/navigation_action_contract.dart`
- Modify: `lib/core/contracts/core_contracts.dart`

- [ ] **Step 1: Define navigation action types**

Create `lib/core/contracts/navigation_action_contract.dart`:

```dart
/// Actions that cross feature boundaries for navigation/interaction.
/// Features emit these; the app shell or router handles them.
abstract interface class VideoActions {
  Future<void> addToWatchLater(String bvid);
  Future<void> removeFromWatchLater(String bvid);
}
```

- [ ] **Step 2: Create provider**

Create provider in `core/session/` or as part of the contract file.

- [ ] **Step 3: Commit**

```bash
git add lib/core/contracts/
git commit -m "feat(core): add NavigationAction contract for cross-feature actions"
```

---

## Part B: Cross-Feature Decoupling

### Task 3: Migrate auth-dependent features to UserSession contract

**Goal:** Replace all 21 `auth_view_model.dart` cross-feature imports with `core/session/current_user_provider.dart`.

**Files to modify (21 files):**
- `lib/features/video/presentation/widgets/info/uploader_section.dart`
- `lib/features/home/presentation/widgets/home_app_bar.dart`
- `lib/features/favorites/presentation/pages/favorites_page.dart`
- `lib/features/favorites/presentation/pages/favorite_detail_page.dart`
- `lib/features/favorites/presentation/view_models/favorites_view_model.dart`
- `lib/features/history/presentation/pages/history_page.dart`
- `lib/features/profile/presentation/pages/profile_page.dart`
- `lib/features/profile/presentation/view_models/profile_view_model.dart`
- `lib/features/profile/presentation/widgets/profile_app_bar.dart`
- `lib/features/profile/presentation/widgets/profile_menu.dart`
- `lib/features/profile/presentation/widgets/relation_user_item.dart`
- `lib/features/profile/presentation/widgets/user_profile_buttons.dart`
- `lib/features/profile/presentation/widgets/user_profile_info.dart`
- `lib/features/notification/presentation/pages/chat_page.dart`
- `lib/features/notification/presentation/pages/notification_page.dart`
- `lib/features/notification/presentation/view_models/notification_owner_uid_provider.dart`
- `lib/features/live/presentation/widgets/live_header.dart`
- `lib/features/to_view/presentation/pages/to_view_page.dart`
- `lib/features/to_view/presentation/view_models/to_view_view_model.dart`
- `lib/features/dynamic/presentation/pages/dynamic_page.dart`
- `lib/features/dynamic/presentation/view_models/recently_followed_view_model.dart`

- [ ] **Step 1: Batch migrate auth imports (profile feature — 8 files)**

For each file, replace:
```dart
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
```
with:
```dart
import 'package:culcul/core/session/current_user_provider.dart';
```

Update usage from `ref.watch(authViewModelProvider)` to `ref.watch(currentUserProvider)`. Adapt field access to `UserSession` interface.

- [ ] **Step 2: Batch migrate auth imports (favorites, history — 4 files)**

Same pattern as Step 1.

- [ ] **Step 3: Batch migrate auth imports (notification, live, to_view — 5 files)**

Same pattern.

- [ ] **Step 4: Batch migrate auth imports (video, home, dynamic — 4 files)**

Same pattern.

- [ ] **Step 5: Verify**

Run: `flutter analyze`
Run: `flutter test`
Expected: No errors, all tests pass

- [ ] **Step 6: Update architecture guard test**

Update `test/architecture/` to verify cross-feature import count dropped to 0 for auth.

- [ ] **Step 7: Commit**

```bash
git add lib/features/
git commit -m "refactor: migrate all features from auth_view_model to UserSession contract"
```

---

### Task 4: Decouple remaining cross-feature imports

**Goal:** Eliminate remaining ~21 cross-feature imports (video↔profile, dynamic↔video, dynamic↔search, home↔live, etc.).

**Files:** Various (see spec P0 table for full list)

- [ ] **Step 1: Audit remaining cross-feature imports**

Run grep to find all remaining `import.*features/` in features/:
```bash
grep -rn "import 'package:culcul/features/" lib/features/ | grep -v "^lib/features/.*/import.*features/\1/"
```

- [ ] **Step 2: Migrate dynamic→video widget imports**

`dynamic` imports `video` widgets (VideoCard, etc.). These should be in `ui/widgets/` if shared, or `dynamic` should use its own card widget.

Check if `video_card/` in `ui/widgets/` already exists. If so, update `dynamic` to import from `ui/` instead of `features/video/`.

- [ ] **Step 3: Migrate dynamic→search imports**

`dynamic` imports `search` view models. Extract shared search contract to `core/contracts/` or use `currentUserProvider` pattern.

- [ ] **Step 4: Migrate home→live/to_view imports**

`home` imports `live` and `to_view` view models for action buttons. Use `NavigationAction` contract from Task 2.

- [ ] **Step 5: Migrate notification→profile imports**

`notification` imports `profile` view models. Extract shared user info to `UserSession` contract.

- [ ] **Step 6: Verify architecture guards**

Run: `flutter test test/architecture/`
Expected: Zero cross-feature import violations

- [ ] **Step 7: Commit**

```bash
git add lib/features/
git commit -m "refactor: eliminate all remaining cross-feature imports"
```

---

## Part C: Domain Layer Purity

### Task 5: Create proper domain entities for video feature

**Goal:** Replace hollow DTO re-exports with genuine domain entities.

**Files:**
- Create: `lib/features/video/domain/entities/video_detail_entity.dart`
- Create: `lib/features/video/domain/entities/play_url_entity.dart`
- Create: `lib/features/video/domain/entities/player_info_entity.dart`
- Create: `lib/features/video/domain/entities/related_video_entity.dart`
- Create: `lib/features/video/domain/entities/subtitle_entity.dart`
- Modify: `lib/features/video/domain/entities/video_model.dart` (replace re-export)
- Modify: `lib/features/video/domain/entities/video_detail.dart` (replace re-export)
- Modify: `lib/features/video/domain/entities/play_url.dart` (replace re-export)
- Modify: `lib/features/video/domain/entities/player_info.dart` (replace re-export)
- Modify: `lib/features/video/domain/entities/related_video.dart` (replace re-export)
- Modify: `lib/features/video/domain/entities/subtitle.dart` (replace re-export)
- Move: `lib/features/video/domain/entities/video_mapping.dart` → `lib/features/video/data/video_mapping.dart`

- [ ] **Step 1: Create VideoDetailEntity**

Read `lib/features/video/data/dtos/video_detail_dto.dart` to understand the fields. Create a plain Dart class:

```dart
class VideoDetailEntity {
  const VideoDetailEntity({
    required this.bvid,
    required this.aid,
    required this.title,
    // ... all fields from DTO
  });

  final String bvid;
  final int aid;
  final String title;
  // ... no @JsonKey, no fromJson, no freezed

  VideoDetailEntity copyWith({...}) => ...;
}
```

- [ ] **Step 2: Create remaining entities**

Same pattern for `PlayUrlEntity`, `PlayerInfoEntity`, `RelatedVideoEntity`, `SubtitleEntity`.

- [ ] **Step 3: Add DTO→Entity mapping in data layer**

Add extension methods in `lib/features/video/data/video_mapping.dart`:

```dart
extension VideoDetailDtoX on VideoDetailDto {
  VideoDetailEntity toEntity() => VideoDetailEntity(
    bvid: bvid,
    aid: aid,
    title: title,
    // ...
  );
}
```

- [ ] **Step 4: Update repository implementations**

Update `video_repository_impl.dart` to return entities instead of DTOs. Add `.toEntity()` calls.

- [ ] **Step 5: Update domain repository interfaces**

Update `video_repository.dart` to reference entity types instead of DTO types.

- [ ] **Step 6: Update view models and workflows**

Update all consumers of video entities. The entity API should be identical to the DTO API (same field names), so changes are mostly import swaps.

- [ ] **Step 7: Move presentation logic out of DTOs**

`video_model_dto.dart` has `durationString` and `pubDateString` getters. Move these to presentation-layer extensions:

```dart
// In presentation layer
extension VideoModelDisplayX on VideoModelEntity {
  String get durationString => FormatUtils.formatDuration(duration);
  String get pubDateString => FormatUtils.formatTimeAgo(pubDate);
}
```

- [ ] **Step 8: Verify**

Run: `flutter analyze lib/features/video/`
Run: `flutter test`
Expected: No errors

- [ ] **Step 9: Commit**

```bash
git add lib/features/video/
git commit -m "refactor(video): create proper domain entities, separate from DTOs"
```

---

## Part D: Error Handling Unification

### Task 6: Eliminate `dataOrNull!` force-unwraps

**Goal:** Replace all 14 dangerous force-unwraps with proper error handling.

**Files:**
- `lib/features/video/application/video_detail_workflows.dart` (line 67)
- `lib/features/video/application/video_extra_workflows.dart` (line 59)
- `lib/features/dynamic/presentation/view_models/dynamic_view_model.dart` (line 30)
- `lib/features/dynamic/presentation/view_models/dynamic_comment_view_model.dart` (line 56)
- `lib/features/dynamic/presentation/view_models/user_dynamic_view_model.dart` (line 73)
- `lib/features/dynamic/presentation/view_models/topic_dynamic_view_model.dart` (line 29)
- `lib/features/notification/data/notification_repository_impl.message_support.dart` (line 58)
- `lib/features/notification/data/notification_repository_impl.feed_sync.dart` (lines 52, 87)
- `lib/features/notification/data/notification_repository_impl.session_sync.dart` (lines 27, 94)
- `lib/features/notification/data/notification_repository_impl.message_sync.dart` (line 67)

- [ ] **Step 1: Fix video application layer (2 files)**

Replace:
```dart
final data = result.dataOrNull!;
```
With:
```dart
final data = result.when(
  success: (d) => d,
  failure: (e) => throw e, // or return early with error state
);
```

Or better, restructure to use `result.when()` at the call site.

- [ ] **Step 2: Fix dynamic view models (4 files)**

Same pattern. These are in view models, so propagate error to UI state:

```dart
result.when(
  success: (data) => state = AsyncData(data),
  failure: (error) => state = AsyncError(error, StackTrace.current),
);
```

- [ ] **Step 3: Fix notification repository (4 files)**

Same pattern. These are in data layer, so return `Result.failure()` instead of crashing.

- [ ] **Step 4: Verify**

Run: `flutter analyze`
Run: `flutter test`
Expected: No errors

- [ ] **Step 5: Commit**

```bash
git add lib/features/video/ lib/features/dynamic/ lib/features/notification/
git commit -m "fix: eliminate all dataOrNull! force-unwraps with proper error handling"
```

---

### Task 7: Unify error handling in view models

**Goal:** Standardize on `result.when()` pattern. Eliminate silent error swallowing.

**Files:**
- `lib/features/home/presentation/view_models/home_popular_view_model.dart`
- `lib/features/home/presentation/view_models/home_recommend_view_model.dart`
- `lib/features/home/presentation/view_models/weekly_view_model.dart`
- `lib/features/history/presentation/view_models/history_view_model.dart`
- `lib/features/ranking/presentation/view_models/category_ranking_view_model.dart`
- `lib/features/live/presentation/view_models/live_recommend_view_model.dart`

- [ ] **Step 1: Fix home view models (3 files)**

Replace:
```dart
return result.dataOrNull ?? const <VideoModel>[];
```
With:
```dart
return result.when(
  success: (data) => data,
  failure: (error) {
    // Log error, return empty list but track error state
    return const <VideoModel>[];
  },
);
```

Better: propagate error to a separate error state field so UI can show error indicator.

- [ ] **Step 2: Fix history, ranking, live view models (3 files)**

Same pattern.

- [ ] **Step 3: Add CancelAppError check**

Add to all view models that handle cancellable operations:
```dart
if (error is CancelAppError) return; // Don't treat cancellation as error
```

- [ ] **Step 4: Commit**

```bash
git add lib/features/
git commit -m "refactor: unify error handling — consistent result.when() pattern"
```

---

## Part E: Core Infrastructure Fixes

### Task 8: Fix pagination empty-state bug

**Files:**
- `lib/core/pagination/paged_async_notifier.dart`

- [ ] **Step 1: Fix OffsetPagedAsyncNotifier.loadNextPage**

At lines 80-84, add state update:
```dart
if (newItems.isEmpty) {
  _hasMore = false;
  state = AsyncData(currentItems); // Update state to reflect no more items
  return;
}
```

- [ ] **Step 2: Fix CursorPagedAsyncNotifier.loadNextPage**

Same fix at lines 170-172.

- [ ] **Step 3: Verify**

Run: `flutter test test/core/pagination/`
Expected: All pagination tests pass

- [ ] **Step 4: Commit**

```bash
git add lib/core/pagination/
git commit -m "fix(pagination): update state when loadNextPage returns empty result"
```

---

### Task 9: Fix audio handler memory leaks

**Files:**
- `lib/core/services/audio_handler.dart`

- [ ] **Step 1: Store stream subscriptions**

```dart
final List<StreamSubscription> _subscriptions = [];
```

Store all 6 subscriptions from the constructor.

- [ ] **Step 2: Add dispose method**

```dart
void dispose() {
  for (final sub in _subscriptions) {
    sub.cancel();
  }
  _subscriptions.clear();
}
```

- [ ] **Step 3: Wire dispose to provider lifecycle**

Update `audioHandlerProvider` to call `dispose` on container close.

- [ ] **Step 4: Commit**

```bash
git add lib/core/services/
git commit -m "fix(audio): store stream subscriptions, add dispose to prevent memory leaks"
```

---

### Task 10: Harden network security

**Files:**
- `lib/core/network/dio_client.dart`
- `lib/core/network/interceptors/token_interceptor.dart`
- `lib/core/network/interceptors/csrf_interceptor.dart`

- [ ] **Step 1: Gate certificate bypass behind kDebugMode**

```dart
if (kDebugMode) {
  config.onBadCertificate = (_) => true;
}
```

- [ ] **Step 2: Log token refresh failures**

Replace silent `catch (e) { // ignore }` with:
```dart
} catch (e) {
  debugPrint('Cookie refresh failed: $e');
}
```

- [ ] **Step 3: Add CSRF cache invalidation on token refresh**

Ensure `invalidateCsrfCache()` is called when cookies are refreshed.

- [ ] **Step 4: Commit**

```bash
git add lib/core/network/
git commit -m "fix(network): gate cert bypass behind debug mode, log refresh failures"
```

---

## Part F: Pattern Standardization

### Task 11: Standardize settings feature_scope

**Files:**
- `lib/features/settings/feature_scope.dart`
- `lib/features/settings/data/settings_repository_impl.dart`

- [ ] **Step 1: Convert to @riverpod codegen**

Move provider definition to `settings_repository_impl.dart` using `@riverpod` annotation. Update `feature_scope.dart` to re-export.

- [ ] **Step 2: Verify**

Run: `flutter analyze lib/features/settings/`
Run: `flutter test test/features/settings/`

- [ ] **Step 3: Commit**

```bash
git add lib/features/settings/
git commit -m "refactor(settings): convert feature_scope to @riverpod codegen"
```

---

### Task 12: Standardize home route_entry and data source

**Files:**
- `lib/features/home/route_entry.dart`
- `lib/features/home/data/home_feed_data_source.dart`

- [ ] **Step 1: Convert route_entry to function pattern**

Replace raw exports with `buildXxxRoutePage()` functions matching other features.

- [ ] **Step 2: Rename data source to repository impl**

Rename `HomeFeedDataSource` → `HomeRepositoryImpl`, add `RequestExecutorBinding` mixin.

- [ ] **Step 3: Verify**

Run: `flutter analyze lib/features/home/`
Run: `flutter test test/features/home/`

- [ ] **Step 4: Commit**

```bash
git add lib/features/home/
git commit -m "refactor(home): standardize route_entry and data source patterns"
```

---

## Part G: UI Quality & Accessibility

### Task 13: Add Semantics to shared widgets

**Files:**
- `lib/ui/widgets/app_clickable.dart`
- `lib/ui/widgets/follow_button.dart`
- `lib/ui/widgets/app_avatar.dart`
- `lib/ui/widgets/app_search_bar.dart`
- `lib/ui/widgets/app_network_image.dart`

- [ ] **Step 1: Add Semantics to AppClickable**

```dart
Semantics(
  label: semanticsLabel,
  button: true,
  enabled: onTap != null,
  child: ...
)
```

- [ ] **Step 2: Add Semantics to FollowButton**

```dart
Semantics(
  label: isFollowed ? t.action.unfollow : t.action.follow,
  button: true,
  child: ...
)
```

- [ ] **Step 3: Add Semantics to AppAvatar, AppSearchBar, AppNetworkImage**

Same pattern — wrap with `Semantics` and provide meaningful labels.

- [ ] **Step 4: Commit**

```bash
git add lib/ui/widgets/
git commit -m "feat(ui): add Semantics wrappers to shared widgets for accessibility"
```

---

### Task 14: Clean up dead code and widget issues

**Files:**
- `lib/ui/widgets/app_clickable.dart` (remove deprecated params)
- `lib/ui/widgets/app_network_image.dart` (change to StatelessWidget)
- `lib/ui/widgets/follow_button.dart` (remove unnecessary Row)
- `lib/ui/widgets/app_search_bar.dart` (fix hardcoded English)

- [ ] **Step 1: Remove deprecated parameters from AppClickable**

Remove `borderRadius`, `backgroundColor`, `padding`, `margin` parameters and their usage in build.

- [ ] **Step 2: Change AppNetworkImage to StatelessWidget**

Remove `extends ConsumerWidget`, change to `extends StatelessWidget`. Remove `ref` parameter.

- [ ] **Step 3: Simplify FollowButton**

Replace `Row(children: [Text(...)])` with just `Text(...)`.

- [ ] **Step 4: Fix hardcoded English in AppSearchBar**

Change default `hintText` to use i18n: `this.hintText` → require it or use `Translations.of(context).search.hint`.

- [ ] **Step 5: Commit**

```bash
git add lib/ui/widgets/
git commit -m "refactor(ui): clean up dead code, fix widget issues"
```

---

## Part H: Verification & Documentation

### Task 15: Full verification

- [ ] **Step 1: Run full analysis**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 2: Run full test suite**

Run: `flutter test`
Expected: All tests pass

- [ ] **Step 3: Run architecture guards**

Run: `flutter test test/architecture/`
Expected: Cross-feature import count = 0

- [ ] **Step 4: Run CI pipeline**

Run: `make ci`
Expected: format-check + analyze + test all pass

- [ ] **Step 5: Update architecture guide**

Update `docs/architecture/architecture-guide.md`:
- Mark Phase 6 as complete
- Add Phase 7 as current
- Update compliance matrix (cross-feature imports = 0)
- Add error handling conventions section

- [ ] **Step 6: Update CLAUDE.md**

Update "Current focus" to Phase 7.

- [ ] **Step 7: Final commit**

```bash
git add docs/ CLAUDE.md
git commit -m "docs: update architecture guide and CLAUDE.md for Phase 7"
```

---

## Dependencies

```
Task 1 (UserSession contract) ──┐
Task 2 (NavigationAction) ──────┤
                                ├── Task 3 (migrate auth imports)
                                ├── Task 4 (decouple remaining)
Task 5 (video domain purity) ───┤
Task 6 (eliminate dataOrNull!) ─┤
Task 7 (unify error handling) ──┤
Task 8 (pagination fix) ────────┤
Task 9 (audio fix) ─────────────┤
Task 10 (network security) ─────┤
Task 11 (settings standardize) ─┤
Task 12 (home standardize) ─────┤
Task 13 (accessibility) ────────┤
Task 14 (dead code cleanup) ────┘
                                ├── Task 15 (verification)
```

Tasks 1-2 must complete before 3-4. Tasks 5-14 are independent and can be parallelized. Task 15 depends on all others.

## Exit Criteria

- [ ] Zero cross-feature imports (architecture guard passes)
- [ ] Video domain entities are proper plain classes (not DTO re-exports)
- [ ] Zero `dataOrNull!` force-unwraps in codebase
- [ ] All view models use consistent `result.when()` error handling
- [ ] Pagination updates state on empty result
- [ ] Audio handler subscriptions are stored and cancellable
- [ ] Certificate bypass gated behind kDebugMode
- [ ] Settings uses @riverpod codegen
- [ ] Home route_entry uses function pattern
- [ ] Key shared widgets have Semantics
- [ ] `make ci` passes
- [ ] All tests pass
