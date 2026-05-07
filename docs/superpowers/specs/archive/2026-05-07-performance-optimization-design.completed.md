# Performance Optimization Design

**Date**: 2026-05-07
**Status**: Approved
**Scope**: Full app performance and fluency optimization, large-scale refactoring allowed, no backward compatibility needed.

## Context

Culcul is a third-party BiliBili client built with Flutter. The codebase is already well-engineered with adaptive performance policies, background JSON parsing, image prefetching, and strategic RepaintBoundary placement. This optimization targets the remaining anti-patterns and deeper rendering bottlenecks.

## Phase 1: Anti-Pattern Fixes (Low Risk)

### 1.1 DynamicListView Keep-Alive

**Problem**: `DynamicListView` (`lib/features/dynamic/presentation/widgets/dynamic_list_view.dart`) is a `HookConsumerWidget` inside a 4-tab `TabBarView` (`dynamic_page.dart:63`). Every tab switch destroys and rebuilds the list, losing scroll position and re-fetching data.

**Fix**: Add `useAutomaticKeepAlive(wantKeepAlive: true)` in the `build` method. This is the standard hooks approach for `HookConsumerWidget`.

**Files**: `dynamic_list_view.dart`

### 1.2 Redundant ClipRRect Cleanup

**Problem**: `AppNetworkImage` already handles rounded corners via `borderRadius` parameter (uses `ExtendedImage.network(borderRadius: ...)`). But 20+ locations wrap `AppNetworkImage` in an additional `ClipRRect`, causing double clipping.

**Fix**: Remove all redundant `ClipRRect` wrappers around `AppNetworkImage`. Ensure `AppNetworkImage` receives the `borderRadius` parameter directly.

**Files** (approximately 20):
- `dynamic_images_widget.dart` (lines 25, 59)
- `dynamic_video_widget.dart` (line 29)
- `dynamic_ugc_widget.dart` (line 22)
- `dynamic_link_card_widget.dart` (line 22)
- `dynamic_common_widget.dart` (line 21)
- `dynamic_goods_widget.dart` (line 39)
- `topic_picker.dart` (line 105)
- `publish_dynamic_image_grid.dart` (line 61)
- `search_topic_item.dart` (line 42)
- `search_bangumi_item.dart` (line 25)
- `search_article_item.dart` (lines 46, 61)
- `fav_folder_item.dart` (line 39)
- `favorite_detail_page.list_rows.dart` (lines 18, 41)
- `to_view_item.dart` (line 34)
- `notification_item_widget.dart` (line 117)
- `chat_image_message.dart` (line 15)
- `comment_images.dart` (lines 68, 114)
- `sticky_video_section.dart` (line 54)

### 1.3 NetworkImage Replacement

**Problem**: 2 locations use raw `NetworkImage` without caching or Bilibili CDN headers (Referer, User-Agent).

**Fix**: Replace with `AppNetworkImage.providerFor()`.

**Files**:
- `recently_followed_widget.dart:79` — `NetworkImage(user.face)` → `AppNetworkImage.providerFor(url: user.face)`
- `article_detail_page_sections.dart:19` — `NetworkImage(data.authorAvatar)` → `AppNetworkImage.providerFor(url: data.authorAvatar)`

### 1.4 Opacity Optimization

**Problem A**: `seek_ripple_overlay.dart:31` uses `Opacity` inside `AnimatedBuilder`, rebuilding every frame.

**Fix**: Replace `Opacity` with `FadeTransition` driven by the existing animation controller.

**Problem B**: `user_profile_app_bar.dart:80` wraps a large subtree in `Opacity` for scroll-driven fade.

**Fix**: Narrow the `Opacity` scope to only the `Text` widget instead of the entire expanded area.

**Files**: `seek_ripple_overlay.dart`, `user_profile_app_bar.dart`

### 1.5 TextEditingController Leak

**Problem**: `dynamic_comments_view.dart:66` creates a `TextEditingController` in a method scope (`_showReplySheet()`), never disposed.

**Fix**: Use `StatefulHookWidget` with `useTextEditingController()` which auto-disposes.

**Files**: `dynamic_comments_view.dart`

### 1.6 Missing cacheWidth/cacheHeight

**Problem**: Several locations use `ExtendedImage.network` or `AppNetworkImage` without specifying memory cache dimensions, causing full-resolution decode.

**Fix**: Add `memCacheWidth`/`memCacheHeight` based on display size * devicePixelRatio, clamped to 2048.

**Files**:
- `emoji_picker.dart` — 24x24 tab icons, grid items
- `chat_message_item.dart:75` — 40x40 avatars
- `private_session_item.dart:146` — 48x48 avatars
- `dynamic_images_widget.dart:29` — single image case (needs width/height props)

---

## Phase 2: List Rendering Optimization (Medium Risk)

### 2.1 Dynamic Feed Sliver Architecture

**Problem**: `DynamicListView` uses `ListView.separated` with `RecentlyFollowedWidget` as `itemBuilder(index==0)`. The header participates in lazy loading and gets recycled during scroll.

**Fix**: Refactor to `CustomScrollView` + `SliverList.builder`:
- `RecentlyFollowedWidget` as pinned `SliverToBoxAdapter` (never recycled)
- Dynamic posts as `SliverList.builder`
- Preserve `SmartPagingView` refresh/load-more logic as Sliver-based

**Files**: `dynamic_list_view.dart`, `smart_paging_view.dart` (may need Sliver support)

### 2.2 Video Card Precaching

**Problem**: Cover images load only when entering the viewport. The existing `AppNetworkImagePrefetcher` triggers on page load, not on scroll position.

**Fix**: Add scroll-aware precaching:
- Monitor `ScrollController` velocity
- When scrolling is stable (not flinging), precache next 3-5 video cover images
- Reuse `AppNetworkImagePrefetcher` LRU cache
- Disable in `minimalEffects` performance mode

**Files**: New utility in `core/perf/` or extension to `AppNetworkImagePrefetcher`, integration in `recommend_view.dart`, `popular_view.dart`, `dynamic_list_view.dart`

### 2.3 Unified Keep-Alive Strategy

**Problem**: Inconsistent keep-alive behavior across TabBarView children.

**Fix**: Add `useAutomaticKeepAlive` to all TabBarView list children:
- `DynamicListView` — Phase 1 covers this
- `home_page.dart` tabs (LiveView, RecommendView, PopularView) — replace `visitedTabs` pattern with `useAutomaticKeepAlive`
- `favorites_page.dart` tabs — check and add if missing

**Files**: `home_page.dart`, `live_view.dart`, `recommend_view.dart`, `popular_view.dart`, `favorites_page.dart`, `fav_folder_list.dart`

### 2.4 Widget Tree Depth Reduction

**Problem**: `DynamicPostCard` has 3-layer nesting (Container > Padding > Column). Each layer creates an extra RenderObject.

**Fix**: Merge Container and Padding into a single Container with `padding` parameter. Similar optimization for `VideoCard`.

**Files**: `dynamic_post_card.dart`, `video_card.dart`

---

## Phase 3: Media Pipeline Optimization (Medium Risk)

### 3.1 Danmaku Rendering Pipeline

**Problem A**: `_activeItems` is a `List`, removing mid-list elements is O(n).

**Fix**: Switch to mark-and-sweep: mark expired items, compact periodically (every 60 frames).

**Problem B**: `_waitingItems` uses linear scan to find items to activate.

**Fix**: Keep `_waitingItems` sorted by start time, use binary search for activation.

**Problem C**: `_updateOption()` calls `setState()`, rebuilding the entire widget including `LayoutBuilder`.

**Fix**: Replace `setState` with `_requestRepaint()` for option changes. Cache layout constraints.

**Files**: `danmaku_view.dart`, `danmaku_view.render.dart`, `danmaku_view.layout.dart`

### 3.2 Danmaku Segment Caching

**Problem**: Danmaku data is loaded per-segment (protobuf), but caching strategy is unclear.

**Fix**:
- Preload current segment + adjacent 2 segments
- LRU cache in memory (keep 5 most recent segments)
- In `minimalEffects` mode, only load current segment

**Files**: Danmaku loading logic (likely in `danmaku_layer.dart` or related data layer)

### 3.3 Video Player Widget Tree Reduction

**Problem**: 5-layer nesting: `AspectRatio > Container > Stack > _InteractiveVideoLayers > InteractionLayer > Stack > [VideoLayer, DanmakuLayer, SubtitleLayer] + ControlsLayer`.

**Fix**:
- Merge `AspectRatio` + `Container` into single `Container` with constraints
- Flatten `_InteractiveVideoLayers` Stack into parent Stack
- Consider making `InteractionLayer` a `SingleChildRenderObjectWidget` to avoid extra RenderObject layer

**Files**: `video_player_view.dart`, `interaction_layer.dart`

### 3.4 Video Progress Reporting

**Problem**: Progress reporting frequency may be too high.

**Fix**:
- Increase reporting interval to 3 seconds (Bilibili API doesn't need sub-second precision)
- Only report when progress changes > 1%

**Files**: `use_video_progress.dart` or related hook

### 3.5 Subtitle Rendering Cache

**Problem**: Need to verify `TextPainter` caching in `SubtitleLayer`.

**Fix**: Ensure `TextPainter` is cached and only re-laid-out when subtitle text actually changes. Skip `setState` if content unchanged.

**Files**: `subtitle_layer.dart`

### 3.6 PlayerControlsOverlay Optimization

**Problem**: Controls children rebuild even when hidden.

**Fix**: When controls are hidden, use `Offstage` or conditional rendering to skip internal widget build entirely.

**Files**: `player_controls_overlay.dart`

---

## Expected Impact

| Phase | Files | Risk | Impact |
|-------|-------|------|--------|
| Phase 1 | ~50 | Low | Eliminates known anti-patterns, immediate smoothness improvement |
| Phase 2 | ~15-20 | Medium | Better scroll performance, reduced image load latency |
| Phase 3 | ~10-15 | Medium | Smoother danmaku, faster video player, reduced memory usage |

## Verification

- Run `flutter test` after each phase
- Manual testing: scroll dynamic feed, switch tabs, play video with danmaku, check memory usage
- Use Flutter DevTools timeline to verify frame timing improvement
- Check `PerformancePolicy` degradation still works correctly
