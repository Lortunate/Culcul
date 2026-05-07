# Phase 7: Architecture Optimization & Code Quality — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Spec:** `docs/superpowers/specs/2026-05-07-phase7-architecture-code-quality-design.md`
**Date:** 2026-05-07

## Execution Order

Structural reorganization first (high blast radius but mechanical), then contracts (no behavior change), then cross-feature decoupling (high impact), then domain purity (medium risk), then error handling (tedious but safe), then core fixes (low risk), then UI polish (low risk), then verification.

---

## Part A: Core Directory Reorganization

### Task 1: Create `core/data/` grouping and move network + pagination

**Goal:** Group network and pagination under `core/data/` for clearer data-layer boundary.

**Files to create:**
- `lib/core/data/data.dart` (barrel)

**Files to move:**
- `lib/core/network/` → `lib/core/data/network/`
- `lib/core/pagination/` → `lib/core/data/pagination/`

**Files to update:**
- `lib/core/core.dart` (update barrel exports)
- `lib/core/data/data.dart` (new barrel)
- All files importing from `core/network/` or `core/pagination/` (~60-80 files)

- [ ] **Step 1: Create directory structure**

```bash
mkdir -p lib/core/data
```

- [ ] **Step 2: Move network directory**

```bash
git mv lib/core/network lib/core/data/network
```

- [ ] **Step 3: Move pagination directory**

```bash
git mv lib/core/pagination lib/core/data/pagination
```

- [ ] **Step 4: Create barrel export**

Create `lib/core/data/data.dart`:
```dart
export 'network/core_network.dart';
export 'pagination/core_pagination.dart';
```

- [ ] **Step 5: Update all imports**

Run find-and-replace across the codebase:
```
'package:culcul/core/network/' → 'package:culcul/core/data/network/'
'package:culcul/core/pagination/' → 'package:culcul/core/data/pagination/'
```

Also update relative imports within core/.

- [ ] **Step 6: Update core.dart barrel**

Update `lib/core/core.dart` to export `data/data.dart` instead of separate network/pagination.

- [ ] **Step 7: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 8: Commit**

```bash
git add -A lib/core/ lib/test/
git commit -m "refactor(core): group network and pagination under core/data/"
```

---

### Task 2: Update test structure to match new core layout

**Goal:** Move `test/shared/` tests to mirror `lib/core/` and `lib/ui/` paths.

**Files to move:**
- `test/shared/network/` → `test/core/data/network/`
- `test/shared/pagination/` → `test/core/data/pagination/`
- `test/shared/perf/` → `test/core/perf/`
- `test/shared/services/` → `test/core/services/`
- `test/shared/widgets/` → `test/ui/widgets/`

- [ ] **Step 1: Create target directories**

```bash
mkdir -p test/core/data/network test/core/data/pagination test/core/perf test/core/services test/ui/widgets
```

- [ ] **Step 2: Move test files**

```bash
git mv test/shared/network/* test/core/data/network/
git mv test/shared/pagination/* test/core/data/pagination/
git mv test/shared/perf/* test/core/perf/
git mv test/shared/services/* test/core/services/
git mv test/shared/widgets/* test/ui/widgets/
```

- [ ] **Step 3: Update imports in test files**

Replace `package:culcul/core/network/` → `package:culcul/core/data/network/` etc.

- [ ] **Step 4: Remove empty test/shared/**

```bash
rmdir test/shared
```

- [ ] **Step 5: Verify**

```bash
flutter test
```

- [ ] **Step 6: Commit**

```bash
git add -A test/
git commit -m "test: restructure test/shared/ to mirror lib/core/ and lib/ui/"
```

---

## Part B: UI Widget Reorganization

### Task 3: Categorize `ui/widgets/` into logical subdirectories

**Goal:** Group 33 loose widgets into categories for discoverability.

**New structure:**
```
ui/widgets/
  ui_widgets.dart          # Updated barrel
  buttons/                 # follow_button, app_clickable, app_tag
  cards/                   # video_card/, video_list_card/, app_card_container
  feedback/                # app_error_widget, app_empty_state_widget, app_shimmer, privacy_error_widget
  inputs/                  # app_search_bar
  layout/                  # app_section_header, sliver_tab_bar_delegate, app_tab_bar, refresh_header_footer
  media/                   # app_network_image, app_network_image_prefetcher, video_thumbnail, app_image_preview, adaptive_blur
  overlays/                # app_bottom_sheet, app_overlay_tag, video_actions_bottom_sheet
  text/                    # bilibili_emoji_text, app_min_lines_text, icon_text
  users/                   # app_avatar, user_list_tile, user_tags, guest_view/
  comments/                # (unchanged)
  skeletons/               # (unchanged)
  smart_paging_view/       # (unchanged)
```

- [ ] **Step 1: Create subdirectories**

```bash
mkdir -p lib/ui/widgets/{buttons,cards,feedback,inputs,layout,media,overlays,text,users}
```

- [ ] **Step 2: Move widgets into categories**

Use `git mv` for each widget. Example:
```bash
git mv lib/ui/widgets/follow_button.dart lib/ui/widgets/buttons/
git mv lib/ui/widgets/app_clickable.dart lib/ui/widgets/buttons/
git mv lib/ui/widgets/app_tag.dart lib/ui/widgets/buttons/
# ... etc for each category
```

- [ ] **Step 3: Create category barrel exports**

Create `lib/ui/widgets/buttons/buttons.dart`, `lib/ui/widgets/cards/cards.dart`, etc.

- [ ] **Step 4: Update `ui/widgets/ui_widgets.dart` barrel**

Export all category barrels.

- [ ] **Step 5: Update all imports across codebase**

Replace `package:culcul/ui/widgets/follow_button.dart` → `package:culcul/ui/widgets/buttons/follow_button.dart` etc. Or better: use the barrel `package:culcul/ui/widgets/ui_widgets.dart`.

- [ ] **Step 6: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 7: Commit**

```bash
git add -A lib/ui/
git commit -m "refactor(ui): categorize widgets into logical subdirectories"
```

---

## Part C: Bootstrap Simplification

### Task 4: Extract provider overrides from main.dart

**Goal:** Move 11 `ProviderScope` overrides from `main.dart` into a dedicated bootstrap configuration.

**Files:**
- Create: `lib/app/bootstrap/provider_overrides.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Create provider_overrides.dart**

Extract the `ProviderScope(overrides: [...])` list into a function:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ... all provider imports

List<Override> createProviderOverrides({
  required CookieJar cookieJar,
  required CacheStore cacheStore,
  // ... other dependencies
}) {
  return [
    cookieJarProvider.overrideWithValue(cookieJar),
    cacheStoreProvider.overrideWithValue(cacheStore),
    // ... all 11 overrides
  ];
}
```

- [ ] **Step 2: Simplify main.dart**

```dart
ProviderScope(
  overrides: createProviderOverrides(
    cookieJar: deps.cookieJar,
    cacheStore: deps.cacheStore,
    // ...
  ),
  child: TranslationProvider(child: CulculApp()),
)
```

- [ ] **Step 3: Verify**

```bash
flutter analyze lib/main.dart lib/app/bootstrap/
flutter test
```

- [ ] **Step 4: Commit**

```bash
git add lib/main.dart lib/app/bootstrap/
git commit -m "refactor(app): extract provider overrides from main.dart"
```

---

## Part D: Shared Contracts & Cross-Feature Decoupling

### Task 5: Create UserSession contract and provider

**Goal:** Eliminate 21 cross-feature imports of `auth_view_model.dart`.

**Files:**
- Create: `lib/core/contracts/user_session_contract.dart`
- Create: `lib/core/session/current_user_provider.dart`
- Modify: `lib/core/contracts/core_contracts.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Define UserSession contract**

```dart
abstract interface class UserSession {
  int get uid;
  bool get isLoggedIn;
  String? get avatarUrl;
  String? get nickname;
}
```

- [ ] **Step 2: Create CurrentUserProvider**

```dart
final currentUserProvider = Provider<UserSession?>((ref) {
  throw UnimplementedError('Must be overridden at bootstrap');
});
```

- [ ] **Step 3: Wire up in main.dart**

Add `currentUserProvider` override that reads from `auth_view_model_provider`.

- [ ] **Step 4: Verify**

```bash
flutter analyze lib/core/
```

- [ ] **Step 5: Commit**

```bash
git add lib/core/contracts/ lib/core/session/ lib/main.dart
git commit -m "feat(core): add UserSession contract and currentUserProvider"
```

---

### Task 6: Create NavigationAction contracts

**Goal:** Eliminate cross-feature imports used only for navigation/actions.

**Files:**
- Create: `lib/core/contracts/video_action_contract.dart`
- Modify: `lib/core/contracts/core_contracts.dart`

- [ ] **Step 1: Define action interfaces**

```dart
abstract interface class VideoActions {
  Future<void> addToWatchLater(String bvid);
  Future<void> removeFromWatchLater(String bvid);
}

abstract interface class LiveActions {
  Future<void> enterLiveRoom(int roomId);
}
```

- [ ] **Step 2: Create providers in core/session/**

- [ ] **Step 3: Commit**

```bash
git add lib/core/contracts/
git commit -m "feat(core): add NavigationAction contracts for cross-feature actions"
```

---

### Task 7: Migrate all auth-dependent features to UserSession

**Goal:** Replace 21 `auth_view_model.dart` imports with `core/session/current_user_provider.dart`.

**Files (21 files across 9 features):**
- `features/video/presentation/widgets/info/uploader_section.dart`
- `features/home/presentation/widgets/home_app_bar.dart`
- `features/favorites/presentation/pages/favorites_page.dart`
- `features/favorites/presentation/pages/favorite_detail_page.dart`
- `features/favorites/presentation/view_models/favorites_view_model.dart`
- `features/history/presentation/pages/history_page.dart`
- `features/profile/presentation/pages/profile_page.dart`
- `features/profile/presentation/view_models/profile_view_model.dart`
- `features/profile/presentation/widgets/profile_app_bar.dart`
- `features/profile/presentation/widgets/profile_menu.dart`
- `features/profile/presentation/widgets/relation_user_item.dart`
- `features/profile/presentation/widgets/user_profile_buttons.dart`
- `features/profile/presentation/widgets/user_profile_info.dart`
- `features/notification/presentation/pages/chat_page.dart`
- `features/notification/presentation/pages/notification_page.dart`
- `features/notification/presentation/view_models/notification_owner_uid_provider.dart`
- `features/live/presentation/widgets/live_header.dart`
- `features/to_view/presentation/pages/to_view_page.dart`
- `features/to_view/presentation/view_models/to_view_view_model.dart`
- `features/dynamic/presentation/pages/dynamic_page.dart`
- `features/dynamic/presentation/view_models/recently_followed_view_model.dart`

- [ ] **Step 1: Batch migrate profile feature (8 files)**

Replace `import '...auth_view_model.dart'` with `import '...current_user_provider.dart'`. Update `ref.watch(authViewModelProvider)` to `ref.watch(currentUserProvider)`. Adapt field access to `UserSession` interface.

- [ ] **Step 2: Batch migrate favorites + history (4 files)**

Same pattern.

- [ ] **Step 3: Batch migrate notification + live + to_view (5 files)**

Same pattern.

- [ ] **Step 4: Batch migrate video + home + dynamic (4 files)**

Same pattern.

- [ ] **Step 5: Update architecture guard test**

Update `test/architecture/` to verify cross-feature import count dropped to 0 for auth.

- [ ] **Step 6: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 7: Commit**

```bash
git add lib/features/
git commit -m "refactor: migrate all features from auth_view_model to UserSession contract"
```

---

### Task 8: Decouple remaining cross-feature imports

**Goal:** Eliminate remaining ~21 cross-feature imports.

**Files:** Various (see spec P1 table)

- [ ] **Step 1: Audit remaining cross-feature imports**

```bash
grep -rn "import 'package:culcul/features/" lib/features/ | grep -v "$(echo $line | cut -d/ -f4)"
```

- [ ] **Step 2: Migrate dynamic→video widget imports**

`dynamic` imports `video` widgets. These are already in `ui/widgets/video_card/`. Update `dynamic` to import from `ui/` instead.

- [ ] **Step 3: Migrate dynamic→search imports**

Extract shared search contract to `core/contracts/` or use provider pattern.

- [ ] **Step 4: Migrate home→live/to_view imports**

Use `NavigationAction` contracts from Task 6.

- [ ] **Step 5: Migrate notification→profile imports**

Extract shared user info to `UserSession` contract.

- [ ] **Step 6: Migrate remaining (profile↔dynamic, profile↔notification, live↔auth/profile)**

Same patterns — extract to contracts or use provider overrides.

- [ ] **Step 7: Verify architecture guards**

```bash
flutter test test/architecture/
```

Expected: Zero cross-feature import violations.

- [ ] **Step 8: Commit**

```bash
git add lib/features/
git commit -m "refactor: eliminate all remaining cross-feature imports"
```

---

## Part E: Domain Layer Purity

### Task 9: Create proper domain entities for video feature

**Goal:** Replace hollow DTO re-exports with genuine domain entities.

**Files:**
- Create: `lib/features/video/domain/entities/video_detail_entity.dart`
- Create: `lib/features/video/domain/entities/play_url_entity.dart`
- Create: `lib/features/video/domain/entities/player_info_entity.dart`
- Create: `lib/features/video/domain/entities/related_video_entity.dart`
- Create: `lib/features/video/domain/entities/subtitle_entity.dart`
- Create: `lib/features/video/data/video_mapping.dart` (DTO→Entity extensions)
- Modify: `lib/features/video/domain/entities/video_detail.dart` (replace re-export)
- Modify: `lib/features/video/domain/entities/play_url.dart` (replace re-export)
- Modify: `lib/features/video/domain/entities/player_info.dart` (replace re-export)
- Modify: `lib/features/video/domain/entities/related_video.dart` (replace re-export)
- Modify: `lib/features/video/domain/entities/subtitle.dart` (replace re-export)
- Modify: `lib/features/video/domain/repositories/video_repository.dart` (use entity types)
- Modify: `lib/features/video/data/video_repository_impl.dart` (add .toEntity() calls)

- [ ] **Step 1: Read existing DTOs to understand fields**

Read `lib/features/video/data/dtos/video_detail_dto.dart` and others.

- [ ] **Step 2: Create VideoDetailEntity**

Plain Dart class with `copyWith`, `==`, `hashCode`. No JSON, no freezed.

- [ ] **Step 3: Create remaining entities**

Same pattern for PlayUrlEntity, PlayerInfoEntity, RelatedVideoEntity, SubtitleEntity.

- [ ] **Step 4: Add DTO→Entity mapping in data layer**

```dart
extension VideoDetailDtoX on VideoDetailDto {
  VideoDetailEntity toEntity() => VideoDetailEntity(bvid: bvid, ...);
}
```

- [ ] **Step 5: Update repository implementations**

Add `.toEntity()` calls in `video_repository_impl.dart`.

- [ ] **Step 6: Update domain repository interfaces**

Reference entity types instead of DTO types.

- [ ] **Step 7: Move presentation logic out of DTOs**

`video_model_dto.dart` has `durationString` and `pubDateString` getters. Move to presentation-layer extensions.

- [ ] **Step 8: Update consumers**

Import swaps (entity API identical to DTO API).

- [ ] **Step 9: Verify**

```bash
flutter analyze lib/features/video/
flutter test
```

- [ ] **Step 10: Commit**

```bash
git add lib/features/video/
git commit -m "refactor(video): create proper domain entities, separate from DTOs"
```

---

## Part F: Error Handling Unification

### Task 10: Eliminate `dataOrNull!` force-unwraps

**Goal:** Replace all 14 dangerous force-unwraps with proper error handling.

**Files:**
- `lib/features/video/application/video_detail_workflows.dart`
- `lib/features/video/application/video_extra_workflows.dart`
- `lib/features/dynamic/presentation/view_models/dynamic_view_model.dart`
- `lib/features/dynamic/presentation/view_models/dynamic_comment_view_model.dart`
- `lib/features/dynamic/presentation/view_models/user_dynamic_view_model.dart`
- `lib/features/dynamic/presentation/view_models/topic_dynamic_view_model.dart`
- `lib/features/notification/data/notification_repository_impl.message_support.dart`
- `lib/features/notification/data/notification_repository_impl.feed_sync.dart`
- `lib/features/notification/data/notification_repository_impl.session_sync.dart`
- `lib/features/notification/data/notification_repository_impl.message_sync.dart`

- [ ] **Step 1: Fix video application layer (2 files)**

Replace `result.dataOrNull!` with `result.when(success: (d) => d, failure: (e) => throw e)`.

- [ ] **Step 2: Fix dynamic view models (4 files)**

Propagate error to UI state via `AsyncError`.

- [ ] **Step 3: Fix notification repository (4 files)**

Return `Result.failure()` instead of crashing.

- [ ] **Step 4: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 5: Commit**

```bash
git add lib/features/video/ lib/features/dynamic/ lib/features/notification/
git commit -m "fix: eliminate all dataOrNull! force-unwraps with proper error handling"
```

---

### Task 11: Unify error handling in view models

**Goal:** Standardize on `result.when()`. Eliminate silent error swallowing.

**Files:**
- `lib/features/home/presentation/view_models/home_popular_view_model.dart`
- `lib/features/home/presentation/view_models/home_recommend_view_model.dart`
- `lib/features/home/presentation/view_models/weekly_view_model.dart`
- `lib/features/history/presentation/view_models/history_view_model.dart`
- `lib/features/ranking/presentation/view_models/category_ranking_view_model.dart`
- `lib/features/live/presentation/view_models/live_recommend_view_model.dart`

- [ ] **Step 1: Fix home view models (3 files)**

Replace `result.dataOrNull ?? []` with explicit `result.when()` and error tracking.

- [ ] **Step 2: Fix history, ranking, live view models (3 files)**

Same pattern.

- [ ] **Step 3: Add CancelAppError check**

Add to all view models handling cancellable operations.

- [ ] **Step 4: Commit**

```bash
git add lib/features/
git commit -m "refactor: unify error handling — consistent result.when() pattern"
```

---

## Part G: Core Infrastructure Fixes

### Task 12: Fix pagination empty-state bug

**Files:**
- `lib/core/data/pagination/paged_async_notifier.dart` (after Part A move)

- [ ] **Step 1: Fix OffsetPagedAsyncNotifier.loadNextPage**

Add state update when result is empty:
```dart
if (newItems.isEmpty) {
  _hasMore = false;
  state = AsyncData(currentItems);
  return;
}
```

- [ ] **Step 2: Fix CursorPagedAsyncNotifier.loadNextPage**

Same fix.

- [ ] **Step 3: Verify**

```bash
flutter test test/core/data/pagination/
```

- [ ] **Step 4: Commit**

```bash
git add lib/core/data/pagination/
git commit -m "fix(pagination): update state when loadNextPage returns empty result"
```

---

### Task 13: Fix audio handler memory leaks

**Files:**
- `lib/core/services/audio_handler.dart`

- [ ] **Step 1: Store stream subscriptions**

```dart
final List<StreamSubscription> _subscriptions = [];
```

- [ ] **Step 2: Add dispose method**

- [ ] **Step 3: Wire dispose to provider lifecycle**

- [ ] **Step 4: Commit**

```bash
git add lib/core/services/
git commit -m "fix(audio): store stream subscriptions, add dispose to prevent memory leaks"
```

---

### Task 14: Harden network security

**Files:**
- `lib/core/data/network/dio_client.dart` (after Part A move)
- `lib/core/data/network/interceptors/token_interceptor.dart`
- `lib/core/data/network/interceptors/csrf_interceptor.dart`

- [ ] **Step 1: Gate certificate bypass behind kDebugMode**

- [ ] **Step 2: Log token refresh failures**

- [ ] **Step 3: Add CSRF cache invalidation on token refresh**

- [ ] **Step 4: Commit**

```bash
git add lib/core/data/network/
git commit -m "fix(network): gate cert bypass behind debug mode, log refresh failures"
```

---

## Part H: Pattern Standardization

### Task 15: Standardize settings feature_scope

**Files:**
- `lib/features/settings/feature_scope.dart`
- `lib/features/settings/data/settings_repository_impl.dart`

- [ ] **Step 1: Convert to @riverpod codegen**

- [ ] **Step 2: Verify**

```bash
flutter analyze lib/features/settings/
flutter test test/features/settings/
```

- [ ] **Step 3: Commit**

```bash
git add lib/features/settings/
git commit -m "refactor(settings): convert feature_scope to @riverpod codegen"
```

---

### Task 16: Standardize home route_entry and data source

**Files:**
- `lib/features/home/route_entry.dart`
- `lib/features/home/data/home_feed_data_source.dart`

- [ ] **Step 1: Convert route_entry to function pattern**

- [ ] **Step 2: Rename data source to repository impl**

- [ ] **Step 3: Verify**

```bash
flutter analyze lib/features/home/
flutter test test/features/home/
```

- [ ] **Step 4: Commit**

```bash
git add lib/features/home/
git commit -m "refactor(home): standardize route_entry and data source patterns"
```

---

## Part I: UI Quality & Accessibility

### Task 17: Add Semantics to shared widgets

**Files:**
- `lib/ui/widgets/buttons/app_clickable.dart` (after Part B move)
- `lib/ui/widgets/buttons/follow_button.dart`
- `lib/ui/widgets/users/app_avatar.dart`
- `lib/ui/widgets/inputs/app_search_bar.dart`
- `lib/ui/widgets/media/app_network_image.dart`

- [ ] **Step 1: Add Semantics to AppClickable**

- [ ] **Step 2: Add Semantics to FollowButton**

- [ ] **Step 3: Add Semantics to AppAvatar, AppSearchBar, AppNetworkImage**

- [ ] **Step 4: Commit**

```bash
git add lib/ui/widgets/
git commit -m "feat(ui): add Semantics wrappers to shared widgets for accessibility"
```

---

### Task 18: Clean up dead code and widget issues

**Files:**
- `lib/ui/widgets/buttons/app_clickable.dart`
- `lib/ui/widgets/media/app_network_image.dart`
- `lib/ui/widgets/buttons/follow_button.dart`
- `lib/ui/widgets/inputs/app_search_bar.dart`

- [ ] **Step 1: Remove deprecated parameters from AppClickable**

- [ ] **Step 2: Change AppNetworkImage to StatelessWidget**

- [ ] **Step 3: Simplify FollowButton**

- [ ] **Step 4: Fix hardcoded English in AppSearchBar**

- [ ] **Step 5: Commit**

```bash
git add lib/ui/widgets/
git commit -m "refactor(ui): clean up dead code, fix widget issues"
```

---

## Part J: Verification & Documentation

### Task 19: Full verification

- [ ] **Step 1: Run full analysis**

```bash
flutter analyze
```

- [ ] **Step 2: Run full test suite**

```bash
flutter test
```

- [ ] **Step 3: Run architecture guards**

```bash
flutter test test/architecture/
```

Expected: Zero cross-feature imports, all structural rules pass.

- [ ] **Step 4: Run CI pipeline**

```bash
make ci
```

- [ ] **Step 5: Update architecture guide**

Update `docs/architecture/architecture-guide.md`:
- Update directory structure diagram
- Add `core/data/` grouping
- Add `ui/widgets/` categorization
- Update compliance matrix (cross-feature imports = 0)
- Add error handling conventions

- [ ] **Step 6: Update CLAUDE.md**

Update "Current focus" and directory structure references.

- [ ] **Step 7: Final commit**

```bash
git add docs/ CLAUDE.md
git commit -m "docs: update architecture guide and CLAUDE.md for Phase 7"
```

---

## Dependencies

```
Task 1 (core reorg) ──────────────┐
Task 2 (test reorg) ──────────────┤
Task 3 (widget reorg) ────────────┤
Task 4 (bootstrap simplify) ──────┤
                                  ├── Task 5 (UserSession contract)
                                  ├── Task 6 (NavigationAction contract)
                                  │         │
                                  │         ├── Task 7 (migrate auth imports)
                                  │         ├── Task 8 (decouple remaining)
                                  │
Task 9 (video domain purity) ─────┤
Task 10 (eliminate dataOrNull!) ──┤
Task 11 (unify error handling) ───┤
Task 12 (pagination fix) ─────────┤
Task 13 (audio fix) ──────────────┤
Task 14 (network security) ───────┤
Task 15 (settings standardize) ───┤
Task 16 (home standardize) ───────┤
Task 17 (accessibility) ──────────┤
Task 18 (dead code cleanup) ──────┘
                                  ├── Task 19 (verification)
```

- Tasks 1-4 are independent structural changes (can parallelize)
- Tasks 5-6 must complete before 7-8
- Tasks 9-18 are independent and can parallelize
- Task 19 depends on all others

## Exit Criteria

- [ ] `core/` reorganized into logical groups (`data/`, `session/`, etc.)
- [ ] `ui/widgets/` categorized into subdirectories
- [ ] `test/` structure mirrors `lib/`
- [ ] `main.dart` simplified (provider overrides extracted)
- [ ] Zero cross-feature imports (architecture guard passes)
- [ ] Video domain entities are proper plain classes
- [ ] Zero `dataOrNull!` force-unwraps
- [ ] All view models use consistent `result.when()` error handling
- [ ] Pagination updates state on empty result
- [ ] Audio handler subscriptions stored and cancellable
- [ ] Certificate bypass gated behind kDebugMode
- [ ] Settings uses @riverpod codegen
- [ ] Home route_entry uses function pattern
- [ ] Key shared widgets have Semantics
- [ ] `make ci` passes
- [ ] All tests pass
