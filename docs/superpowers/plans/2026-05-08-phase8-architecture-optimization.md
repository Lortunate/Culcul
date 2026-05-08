# Phase 8: Architecture Optimization & Code Readability — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Spec:** `docs/superpowers/specs/2026-05-08-phase8-architecture-optimization-design.md`
**Date:** 2026-05-08

## Execution Order

Core cleanup first (foundational, mechanical), then app layer (medium risk, structural), then UI boundary enforcement (high blast radius but mostly moves), then feature quality (targeted fixes), then pagination docs (safe), then verification.

---

## Part A: Core Layer Cleanup

### Task 1: Consolidate `core/session/` (13 files → 5)

**Goal:** Reduce navigation overhead, fix 2 dynamic-typed providers.

**New files to create in `lib/core/session/`:**

- [ ] **Step 1: Create `user_providers.dart`**

Merge from: `current_user_provider.dart`, `user_card_provider.dart`, `user_profile_lookup_provider.dart`

```dart
// user_providers.dart
import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/contracts/user_profile_lookup_contract.dart';
import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_providers.g.dart';

@Riverpod(keepAlive: true)
UserSession? currentUser(CurrentUserRef ref) => throw UnimplementedError();

typedef FetchUserCard = Future<Result<UserCardModel, AppError>> Function(int uid);

@Riverpod(keepAlive: true)
FetchUserCard fetchUserCard(FetchUserCardRef ref) => throw UnimplementedError();

// ... userProfileLookup provider + userProfileInfo derived provider
```

- [ ] **Step 2: Create `relation_providers.dart`** (fix dynamic typing!)

Merge from: `relation_repository_provider.dart`, `modify_relation_provider.dart`

```dart
// relation_providers.dart — FIX: replace dynamic with proper contract type
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Riverpod(keepAlive: true)
RelationRepository crossRelationRepository(CrossRelationRepositoryRef ref)
    => throw UnimplementedError();
```

- [ ] **Step 3: Create `search_providers.dart`** (fix dynamic typing!)

Merge from: `search_repository_provider.dart`, `search_service_provider.dart`

```dart
// search_providers.dart — FIX: replace dynamic with proper contract type
import 'package:culcul/core/contracts/search_service_contract.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Riverpod(keepAlive: true)
SearchRepository crossSearchRepository(CrossSearchRepositoryRef ref)
    => throw UnimplementedError();
```

- [ ] **Step 4: Create `session_lifecycle_providers.dart`**

Merge from: `session_cookie_refresher.dart`, `session_refresh_provider.dart`, `logout_action_provider.dart`, `show_login_dialog_provider.dart`

- [ ] **Step 5: Create `feature_action_providers.dart`**

Merge from: `follow_list_provider.dart`, `watch_later_provider.dart`

- [ ] **Step 6: Update all imports**

Update ~40 files that import from `core/session/`:
```
'package:culcul/core/session/current_user_provider.dart' → 'package:culcul/core/session/user_providers.dart'
'package:culcul/core/session/relation_repository_provider.dart' → 'package:culcul/core/session/relation_providers.dart'
// ... etc
```

- [ ] **Step 7: Delete old 13 files**

- [ ] **Step 8: Update `core.dart` barrel**

```dart
export 'session/user_providers.dart';
export 'session/relation_providers.dart';
export 'session/search_providers.dart';
export 'session/session_lifecycle_providers.dart';
export 'session/feature_action_providers.dart';
```

- [ ] **Step 9: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 10: Commit**

---

### Task 2: Consolidate error handling (`exceptions.dart` + `app_error.dart`)

**Goal:** Single error hierarchy, eliminate duplicate mapping logic.

**Context:** `AppException` subclasses are still thrown in 4 repositories (search, profile, dynamic, auth) + csrf_interceptor. Cannot delete `exceptions.dart` entirely. Instead, consolidate the DioException mapping into one place.

- [ ] **Step 1: Audit all `throw` sites for AppException subclasses**

```bash
grep -rn "throw.*Exception\b" lib/ --include="*.dart" | grep -v ".g.dart" | grep -v ".freezed.dart"
```

- [ ] **Step 2: Keep `exceptions.dart` for throw sites, remove duplicate mapping**

In `exceptions.dart`:
- Keep the exception class definitions (they're still thrown)
- Remove `dioExceptionToAppException()` function (duplicates `AppError._fromDioException()`)

In `app_error.dart`:
- Keep `_fromException()` that handles `AppException` subclasses
- This becomes the single mapping entry point

- [ ] **Step 3: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 4: Commit**

---

### Task 3: Fix `core/core.dart` barrel

**Goal:** Export a useful public API surface.

- [ ] **Step 1: Expand barrel exports**

```dart
// core.dart
// Errors
export 'errors/app_error.dart';
export 'errors/error_handler.dart';
export 'errors/exceptions.dart';

// Result
export 'result/result.dart';

// Session (all consolidated files)
export 'session/user_providers.dart';
export 'session/relation_providers.dart';
export 'session/search_providers.dart';
export 'session/session_lifecycle_providers.dart';
export 'session/feature_action_providers.dart';

// Constants
export 'constants/api_constants.dart';
export 'constants/app_dimens.dart';

// Data (sub-barrel)
export 'data/data.dart';
```

- [ ] **Step 2: Verify no circular exports**

- [ ] **Step 3: Commit**

---

## Part B: App Layer Cleanup

### Task 4: Extract adapters from `provider_overrides.dart`

**Goal:** Eliminate god file, fix UnimplementedError, add return type.

- [ ] **Step 1: Move `_AuthSessionAdapter` to `features/auth/feature_scope.dart`**

The auth feature already has `feature_scope.dart`. Add the adapter class there as a public `AuthSessionAdapter`.

- [ ] **Step 2: Move `_FollowListAdapter` to `features/profile/feature_scope.dart`**

- [ ] **Step 3: Move `_SearchServiceAdapter` to `features/search/feature_scope.dart`**

- [ ] **Step 4: Move `_WatchLaterAdapter` to `features/to_view/feature_scope.dart`**

**CRITICAL:** Fix `removeFromWatchLater` — either implement it or provide a logged no-op. Remove the `UnimplementedError`.

- [ ] **Step 5: Move `_UserProfileLookupAdapter` to `features/profile/feature_scope.dart`**

- [ ] **Step 6: Rewrite `provider_overrides.dart`**

```dart
List<Override> createProviderOverrides(AppDependencies deps) {
  return [
    // Auth
    currentUserProvider.overrideWithValue(deps.authSession.currentUser),
    sessionCookieRefresherProvider.overrideWithValue(deps.authSession.refreshCookies),
    sessionRefreshActionProvider.overrideWithValue(deps.authSession.refreshSession),
    logoutActionProvider.overrideWithValue(deps.authSession.logout),
    showLoginDialogProvider.overrideWithValue(deps.showLoginDialog),
    // Profile
    ...ProfileFeatureScope.overrides(deps),
    // Search
    ...SearchFeatureScope.overrides(deps),
    // Watch Later
    ...ToViewFeatureScope.overrides(deps),
    // Storage
    cacheStoreProvider.overrideWithValue(deps.cacheStore),
    storageProvider.overrideWithValue(deps.storage),
  ];
}
```

- [ ] **Step 7: Add return type annotation**

- [ ] **Step 8: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 9: Commit**

---

### Task 5: Fix `ProviderScope` nesting in `app.dart`

**Goal:** Move override to root scope in `main()`.

- [ ] **Step 1: Read `main.dart` to understand current structure**

- [ ] **Step 2: Move `sessionCookieRefresherProvider` override from `app.dart` ProviderScope to `main()` ProviderScope**

- [ ] **Step 3: Remove the inner ProviderScope from `app.dart`**

- [ ] **Step 4: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 5: Commit**

---

### Task 6: Rename route sub-files

**Goal:** Self-documenting route file names.

- [ ] **Step 1: Rename files**

```
app_primary_routes.dart → app_content_routes.dart
app_primary_routes.content_feed.dart → app_social_routes.dart
app_secondary_routes.dart → app_notification_routes.dart
```

- [ ] **Step 2: Update `part` directives in `app_routes.dart`**

- [ ] **Step 3: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 4: Commit**

---

## Part C: UI Boundary Enforcement

### Task 7: Move domain widgets out of `ui/widgets/`

**Goal:** `ui/widgets/` contains only generic, reusable UI primitives.

- [ ] **Step 1: Move `video_card/` (4 files) to `features/video/presentation/widgets/`**

Update all imports (~15-20 files that use VideoCard).

- [ ] **Step 2: Move `video_list_card/` (4 files) to `features/video/presentation/widgets/`**

Update all imports.

- [ ] **Step 3: Move `comments/` (6 files) to `features/video/presentation/widgets/`**

Update all imports. These are video comment widgets (comment_item, comment_images, comment_reply_sheet).

- [ ] **Step 4: Move `bilibili_emoji_text.dart` to `features/dynamic/presentation/widgets/`**

Update all imports.

- [ ] **Step 5: Move `video_actions_bottom_sheet.dart` to `features/video/presentation/widgets/`**

Update all imports.

- [ ] **Step 6: Move `user_tags.dart` to `features/profile/presentation/widgets/`**

Update all imports.

- [ ] **Step 7: Move `video_card_skeleton.dart` and `video_list_skeleton.dart` to `features/video/presentation/widgets/`**

Update all imports.

- [ ] **Step 8: Move `video_thumbnail.dart` to `features/video/presentation/widgets/`**

Update all imports.

- [ ] **Step 9: Fix `guest_view.dart` navigation coupling**

Replace hardcoded `context.push('/login')` with an injected callback or use a route-aware approach.

- [ ] **Step 10: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 11: Commit**

---

### Task 8: Fix `ui/ui.dart` barrel

**Goal:** Export all generic widgets.

- [ ] **Step 1: Expand barrel after domain widgets are moved out**

```dart
// ui.dart
// Responsive
export 'responsive/app_breakpoints.dart';
export 'responsive/app_responsive.dart';
export 'responsive/responsive_container.dart';

// Theme
export 'theme/app_theme.dart';

// Widgets — Buttons
export 'widgets/buttons/app_clickable.dart';
export 'widgets/buttons/app_tag.dart';
export 'widgets/buttons/follow_button.dart';

// Widgets — Cards
export 'widgets/cards/app_card_container.dart';

// Widgets — Feedback
export 'widgets/feedback/app_empty_state_widget.dart';
export 'widgets/feedback/app_error_widget.dart';
export 'widgets/feedback/app_shimmer.dart';
export 'widgets/feedback/privacy_error_widget.dart';

// Widgets — Inputs
export 'widgets/inputs/app_search_bar.dart';
export 'widgets/inputs/app_selectable_text.dart';

// Widgets — Layout
export 'widgets/layout/app_section_header.dart';
export 'widgets/layout/app_tab_bar.dart';
export 'widgets/layout/refresh_header_footer.dart';
export 'widgets/layout/sliver_tab_bar_delegate.dart';

// Widgets — Media
export 'widgets/media/adaptive_blur.dart';
export 'widgets/media/app_image_preview.dart';
export 'widgets/media/app_network_image.dart';
export 'widgets/media/app_network_image_prefetcher.dart';

// Widgets — Overlays
export 'widgets/overlays/app_bottom_sheet.dart';
export 'widgets/overlays/app_overlay_tag.dart';

// Widgets — Text
export 'widgets/text/app_min_lines_text.dart';
export 'widgets/text/icon_text.dart';

// Widgets — Users
export 'widgets/users/app_avatar.dart';
export 'widgets/users/guest_view.dart';
export 'widgets/users/user_list_tile.dart';

// Widgets — Smart Paging
export 'widgets/smart_paging_view.dart';
```

- [ ] **Step 2: Verify**

- [ ] **Step 3: Commit**

---

### Task 9: Move feature-specific constants from `ui/responsive/`

**Goal:** Generic responsive utilities contain no feature-specific values.

- [ ] **Step 1: Move `homeFeedMaxWidth`, `homePopularMaxWidth` to `features/home/`**

Create `features/home/presentation/widgets/home_breakpoints.dart` or inject via parameters.

- [ ] **Step 2: Move `homeGridColumns` getter to `features/home/`**

- [ ] **Step 3: Update `app_breakpoints.dart` and `app_responsive.dart`**

- [ ] **Step 4: Update imports in home feature**

- [ ] **Step 5: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 6: Commit**

---

## Part D: Feature Quality

### Task 10: Fix `notification/` architecture violations

- [ ] **Step 1: Move `application/chat_page_commands.dart` to `presentation/`**

This file contains UI callbacks (clearInput, afterSuccess). Move to `presentation/view_models/` or `presentation/widgets/`.

- [ ] **Step 2: Fix `dart:io` leak in domain**

Replace `File` parameter in `NotificationRepository.uploadImage()` with `Uint8List` bytes. Update the data layer implementation to construct `File` internally from bytes.

- [ ] **Step 3: Verify**

```bash
flutter analyze
flutter test
```

- [ ] **Step 4: Commit**

---

### Task 11: Document `dynamic/` view model → repository shortcut

**Goal:** Acknowledge the pragmatic shortcut with a code comment.

- [ ] **Step 1: Add architecture decision comments to the 3 view models**

```dart
// Architecture note: This view model imports the domain repository interface
// directly rather than going through the application layer. This is a deliberate
// pragmatic choice — the dynamic feature's application layer (dynamic_workflows.dart)
// handles complex multi-step operations, while simple single-call operations
// are consumed directly by view models for simplicity.
```

- [ ] **Step 2: Commit**

---

### Task 12: Document protobuf domain leak in video/

**Goal:** Acknowledge the intentional trade-off.

- [ ] **Step 1: Add architecture decision comment to `danmaku_repository.dart`**

```dart
// Architecture note: This domain repository imports protobuf types (dm.pb.dart)
// directly. This is an intentional trade-off — wrapping protobuf DanmakuElem
// in a domain entity would add a mapping layer with no practical benefit,
// since the protobuf type IS the domain model for danmaku.
```

- [ ] **Step 2: Commit**

---

## Part E: Pagination Documentation

### Task 13: Document dual pagination strategy

**Goal:** Clarify when to use which abstraction.

Both are actively used:
- `PagedListState` — used by video comments, notification chat, favorites, dynamic comments (10 consumers)
- `OffsetPagedAsyncNotifier`/`CursorPagedAsyncNotifier` — used by profile, notification, live, home, favorites, dynamic (12 consumers)

- [ ] **Step 1: Add documentation to `core/data/pagination/` README or barrel**

```dart
/// Pagination abstractions for the Culcul app.
///
/// Two strategies are available:
///
/// 1. **Mixin-based** (`OffsetPagedAsyncNotifier`, `CursorPagedAsyncNotifier`):
///    Use when your view model extends AsyncNotifier and you want built-in
///    pagination state management. Best for simple list + load-more patterns.
///
/// 2. **State-based** (`PagedListState`, `PagedListStateTransitions`):
///    Use when you need explicit control over pagination state transitions,
///    or when combining pagination with other state (e.g., filters, sorting).
///    Best for complex list UIs with multiple state dimensions.
```

- [ ] **Step 2: Commit**

---

## Part F: Verification

### Task 14: Full verification pass

- [ ] **Step 1: Run analysis**

```bash
flutter analyze
```

- [ ] **Step 2: Run all tests**

```bash
flutter test
```

- [ ] **Step 3: Run build_runner to regenerate**

```bash
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 4: Verify no broken imports**

```bash
grep -rn "package:culcul/core/session/" lib/ --include="*.dart" | grep -v "user_providers\|relation_providers\|search_providers\|session_lifecycle_providers\|feature_action_providers"
```

- [ ] **Step 5: Verify ui/widgets/ has no domain widgets**

```bash
grep -rn "VideoModel\|CommentItem\|bilibili\|BiliBili" lib/ui/widgets/ --include="*.dart"
```

- [ ] **Step 6: Update architecture guide**

Update `docs/architecture/architecture-guide.md` with Phase 8 changes.

- [ ] **Step 7: Update CLAUDE.md**

Mark Phase 8 as complete.

- [ ] **Step 8: Final commit and push**
