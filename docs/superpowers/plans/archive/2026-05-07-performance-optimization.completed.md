# Performance Optimization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Eliminate performance anti-patterns and optimize rendering pipelines across the Culcul Flutter app.

**Architecture:** Three-phase approach — Phase 1 fixes known anti-patterns (low risk), Phase 2 optimizes list rendering (medium risk), Phase 3 optimizes media pipelines (medium risk). Each phase is independently testable.

**Tech Stack:** Flutter 3.10+, Riverpod + Hooks, ExtendedImage, media_kit, CustomPaint (danmaku)

---

## Phase 1: Anti-Pattern Fixes

### Task 1: DynamicListView Keep-Alive

**Files:**
- Modify: `lib/features/dynamic/presentation/widgets/dynamic_list_view.dart`

- [ ] **Step 1: Add flutter_hooks import**

Add `import 'package:flutter_hooks/flutter_hooks.dart';` to the imports at the top of `dynamic_list_view.dart`.

- [ ] **Step 2: Add useAutomaticKeepAlive call**

In the `build` method of `DynamicListView`, add `useAutomaticKeepAlive();` as the first line after the opening brace (before `final t = Translations.of(context);`).

The build method should start:
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final t = Translations.of(context);
    // ... rest unchanged
```

- [ ] **Step 3: Verify**

Run: `flutter analyze lib/features/dynamic/presentation/widgets/dynamic_list_view.dart`
Expected: No errors

- [ ] **Step 4: Commit**

```bash
git add lib/features/dynamic/presentation/widgets/dynamic_list_view.dart
git commit -m "perf(dynamic): add keep-alive to DynamicListView tabs"
```

---

### Task 2: Redundant ClipRRect Cleanup — Fully Redundant Cases

These files have `ClipRRect` wrapping `AppNetworkImage` where `AppNetworkImage` already has `borderRadius` set, or wrapping `ExtendedImage.network` that already has `borderRadius`.

**Files:**
- Modify: `lib/features/search/presentation/widgets/items/search_bangumi_item.dart`
- Modify: `lib/features/search/presentation/widgets/items/search_article_item.dart`
- Modify: `lib/features/notification/presentation/widgets/chat/chat_image_message.dart`

- [ ] **Step 1: Fix search_bangumi_item.dart**

At line 25, remove the `ClipRRect` wrapper. The `AppNetworkImage` already has `borderRadius: 8`.

Before:
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: AppNetworkImage(url: item.coverUrl, borderRadius: 8),
),
```

After:
```dart
AppNetworkImage(url: item.coverUrl, borderRadius: 8),
```

- [ ] **Step 2: Fix search_article_item.dart — instance A (line 46)**

Remove `ClipRRect` wrapper. `AppNetworkImage` already has `borderRadius: 6`.

Before:
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(6),
  child: AppNetworkImage(
    url: item.imageUrls[i],
    borderRadius: 6,
  ),
),
```

After:
```dart
AppNetworkImage(
  url: item.imageUrls[i],
  borderRadius: 6,
),
```

- [ ] **Step 3: Fix search_article_item.dart — instance B (line 61)**

Remove `ClipRRect` wrapper. `AppNetworkImage` already has `borderRadius: 8`.

Before:
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: AppNetworkImage(url: item.imageUrls[0], borderRadius: 8),
),
```

After:
```dart
AppNetworkImage(url: item.imageUrls[0], borderRadius: 8),
```

- [ ] **Step 4: Fix chat_image_message.dart (line 15)**

Remove the outer `ClipRRect`. The `ExtendedImage.network` inside already has `borderRadius: BorderRadius.circular(8)`.

Before:
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: ExtendedImage.network(
    url,
    fit: BoxFit.cover,
    cache: true,
    borderRadius: BorderRadius.circular(8),
    ...
  ),
),
```

After:
```dart
ExtendedImage.network(
  url,
  fit: BoxFit.cover,
  cache: true,
  borderRadius: BorderRadius.circular(8),
  ...
),
```

- [ ] **Step 5: Verify**

Run: `flutter analyze lib/features/search/presentation/widgets/items/ lib/features/notification/presentation/widgets/chat/`
Expected: No errors

- [ ] **Step 6: Commit**

```bash
git add lib/features/search/presentation/widgets/items/search_bangumi_item.dart \
  lib/features/search/presentation/widgets/items/search_article_item.dart \
  lib/features/notification/presentation/widgets/chat/chat_image_message.dart
git commit -m "perf: remove redundant ClipRRect where borderRadius already set"
```

---

### Task 3: Redundant ClipRRect Cleanup — Add borderRadius to AppNetworkImage

These files have `ClipRRect` wrapping `AppNetworkImage` where `AppNetworkImage` does NOT have `borderRadius` set. Fix by adding `borderRadius` to `AppNetworkImage` and removing `ClipRRect`.

**Files:**
- Modify: `lib/features/search/presentation/widgets/items/search_topic_item.dart`
- Modify: `lib/features/dynamic/presentation/widgets/content/dynamic_images_widget.dart`
- Modify: `lib/features/dynamic/presentation/widgets/content/dynamic_video_widget.dart`
- Modify: `lib/features/dynamic/presentation/widgets/content/dynamic_ugc_widget.dart`
- Modify: `lib/features/dynamic/presentation/widgets/content/dynamic_link_card_widget.dart`
- Modify: `lib/features/dynamic/presentation/widgets/content/dynamic_common_widget.dart`
- Modify: `lib/features/dynamic/presentation/widgets/content/dynamic_goods_widget.dart`
- Modify: `lib/features/dynamic/presentation/widgets/topic_picker.dart`
- Modify: `lib/features/notification/presentation/widgets/notification_item_widget.dart`
- Modify: `lib/features/favorites/presentation/pages/favorite_detail_page.list_rows.dart`

- [ ] **Step 1: Fix search_topic_item.dart (line 42)**

Before:
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: AppNetworkImage(
    url: item.coverUrl!,
    width: 80,
    height: 80,
    fit: BoxFit.cover,
  ),
),
```

After:
```dart
AppNetworkImage(
  url: item.coverUrl!,
  width: 80,
  height: 80,
  fit: BoxFit.cover,
  borderRadius: 8,
),
```

- [ ] **Step 2: Fix dynamic_images_widget.dart — single image (line 25)**

Before:
```dart
child: ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: ConstrainedBox(
    constraints: const BoxConstraints(maxHeight: 240, maxWidth: 240),
    child: AppNetworkImage(url: validImages.first, fit: BoxFit.cover),
  ),
),
```

After:
```dart
child: ConstrainedBox(
  constraints: const BoxConstraints(maxHeight: 240, maxWidth: 240),
  child: AppNetworkImage(url: validImages.first, fit: BoxFit.cover, borderRadius: 8),
),
```

- [ ] **Step 3: Fix dynamic_images_widget.dart — multi image (line 59)**

Before:
```dart
Widget _buildImageItem(String url, [double? size]) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(6),
    child: AppNetworkImage(url: url, fit: BoxFit.cover, width: size, height: size),
  );
}
```

After:
```dart
Widget _buildImageItem(String url, [double? size]) {
  return AppNetworkImage(url: url, fit: BoxFit.cover, width: size, height: size, borderRadius: 6);
}
```

- [ ] **Step 4: Fix dynamic_video_widget.dart (line 29)**

Before:
```dart
ClipRRect(
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(6),
    bottomLeft: Radius.circular(6),
  ),
  child: AppNetworkImage(
    url: video.cover,
    width: 140,
    height: 88,
    fit: BoxFit.cover,
  ),
),
```

After: Keep the `ClipRRect` here because it uses `BorderRadius.only` (topLeft + bottomLeft), which `AppNetworkImage`'s `borderRadius` parameter (a simple `double`) cannot express. No change needed.

- [ ] **Step 5: Fix dynamic_ugc_widget.dart (line 22)**

Same as dynamic_video_widget.dart — uses `BorderRadius.only`. Keep `ClipRRect`. No change needed.

- [ ] **Step 6: Fix dynamic_link_card_widget.dart (line 22)**

Same — uses `BorderRadius.only`. Keep `ClipRRect`. No change needed.

- [ ] **Step 7: Fix dynamic_common_widget.dart (line 21)**

Same — uses `BorderRadius.only`. Keep `ClipRRect`. No change needed.

- [ ] **Step 8: Fix dynamic_goods_widget.dart (line 39)**

Before:
```dart
leading: ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: AppNetworkImage(
    url: item.cover,
    width: 50,
    height: 50,
    fit: BoxFit.cover,
  ),
),
```

After:
```dart
leading: AppNetworkImage(
  url: item.cover,
  width: 50,
  height: 50,
  fit: BoxFit.cover,
  borderRadius: 8,
),
```

- [ ] **Step 9: Fix topic_picker.dart (line 105)**

Before:
```dart
leading: topic.coverUrl != null
    ? ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AppNetworkImage(
          url: topic.coverUrl!,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      )
    : Container(...)
```

After:
```dart
leading: topic.coverUrl != null
    ? AppNetworkImage(
        url: topic.coverUrl!,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        borderRadius: 4,
      )
    : Container(...)
```

- [ ] **Step 10: Fix notification_item_widget.dart (line 117)**

Before:
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(4),
  child: AppNetworkImage(
    url: detail.image,
    width: 40,
    height: 40,
    fit: BoxFit.cover,
  ),
),
```

After:
```dart
AppNetworkImage(
  url: detail.image,
  width: 40,
  height: 40,
  fit: BoxFit.cover,
  borderRadius: 4,
),
```

- [ ] **Step 11: Fix favorite_detail_page.list_rows.dart — instance A (line 18)**

Before:
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: AppNetworkImage(
    url: info.cover,
    width: 100,
    height: 100,
    fit: BoxFit.cover,
  ),
),
```

After:
```dart
AppNetworkImage(
  url: info.cover,
  width: 100,
  height: 100,
  fit: BoxFit.cover,
  borderRadius: 8,
),
```

- [ ] **Step 12: Verify**

Run: `flutter analyze lib/features/dynamic/ lib/features/search/ lib/features/notification/ lib/features/favorites/`
Expected: No errors

- [ ] **Step 13: Commit**

```bash
git add lib/features/search/presentation/widgets/items/search_topic_item.dart \
  lib/features/dynamic/presentation/widgets/content/dynamic_images_widget.dart \
  lib/features/dynamic/presentation/widgets/content/dynamic_goods_widget.dart \
  lib/features/dynamic/presentation/widgets/topic_picker.dart \
  lib/features/notification/presentation/widgets/notification_item_widget.dart \
  lib/features/favorites/presentation/pages/favorite_detail_page.list_rows.dart
git commit -m "perf: remove ClipRRect, add borderRadius to AppNetworkImage directly"
```

---

### Task 4: Redundant ClipRRect Cleanup — comment_images.dart

`comment_images.dart` uses `ExtendedImage.network` directly (not `AppNetworkImage`). Add `borderRadius` to the `ExtendedImage.network` calls and remove `ClipRRect`.

**Files:**
- Modify: `lib/features/video/presentation/widgets/comments/comment_images.dart`

- [ ] **Step 1: Fix instance A (line 68)**

Before:
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: ExtendedImage.network(
    FormatUtils.formatImageUrl(picture.imgSrc),
    fit: BoxFit.cover,
    cache: true,
    cacheWidth: ...,
    cacheHeight: ...,
    loadStateChanged: ...,
  ),
),
```

After:
```dart
ExtendedImage.network(
  FormatUtils.formatImageUrl(picture.imgSrc),
  fit: BoxFit.cover,
  cache: true,
  cacheWidth: ...,
  cacheHeight: ...,
  borderRadius: BorderRadius.circular(8),
  loadStateChanged: ...,
),
```

- [ ] **Step 2: Fix instance B (line 114)**

Before:
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: SizedBox(
    width: itemSize,
    height: itemSize,
    child: ExtendedImage.network(
      FormatUtils.formatImageUrl(pictures[index].imgSrc),
      fit: BoxFit.cover,
      cache: true,
      cacheWidth: decodeSize,
      cacheHeight: decodeSize,
      loadStateChanged: ...,
    ),
  ),
),
```

After:
```dart
SizedBox(
  width: itemSize,
  height: itemSize,
  child: ExtendedImage.network(
    FormatUtils.formatImageUrl(pictures[index].imgSrc),
    fit: BoxFit.cover,
    cache: true,
    cacheWidth: decodeSize,
    cacheHeight: decodeSize,
    borderRadius: BorderRadius.circular(8),
    loadStateChanged: ...,
  ),
),
```

- [ ] **Step 3: Verify**

Run: `flutter analyze lib/features/video/presentation/widgets/comments/comment_images.dart`
Expected: No errors

- [ ] **Step 4: Commit**

```bash
git add lib/features/video/presentation/widgets/comments/comment_images.dart
git commit -m "perf(comments): remove redundant ClipRRect from comment images"
```

---

### Task 5: NetworkImage Replacement

Replace raw `NetworkImage` with `AppNetworkImage.providerFor()` in 2 locations.

**Files:**
- Modify: `lib/features/dynamic/presentation/widgets/recently_followed_widget.dart`
- Modify: `lib/features/dynamic/presentation/pages/article_detail_page_sections.dart`

- [ ] **Step 1: Fix recently_followed_widget.dart (line 79)**

Add import: `import 'package:culcul/ui/widgets/app_network_image.dart';`

Before:
```dart
child: CircleAvatar(
  radius: 26,
  backgroundImage: NetworkImage(user.face),
  backgroundColor: theme.colorScheme.surfaceContainerHighest,
),
```

After:
```dart
child: CircleAvatar(
  radius: 26,
  backgroundImage: AppNetworkImage.providerFor(url: user.face),
  backgroundColor: theme.colorScheme.surfaceContainerHighest,
),
```

- [ ] **Step 2: Fix article_detail_page_sections.dart (line 19)**

Add import: `import 'package:culcul/ui/widgets/app_network_image.dart';`

Before:
```dart
backgroundImage: data.authorAvatar.isNotEmpty
    ? NetworkImage(data.authorAvatar)
    : null,
```

After:
```dart
backgroundImage: data.authorAvatar.isNotEmpty
    ? AppNetworkImage.providerFor(url: data.authorAvatar)
    : null,
```

- [ ] **Step 3: Verify**

Run: `flutter analyze lib/features/dynamic/presentation/widgets/recently_followed_widget.dart lib/features/dynamic/presentation/pages/article_detail_page_sections.dart`
Expected: No errors

- [ ] **Step 4: Commit**

```bash
git add lib/features/dynamic/presentation/widgets/recently_followed_widget.dart \
  lib/features/dynamic/presentation/pages/article_detail_page_sections.dart
git commit -m "perf: replace NetworkImage with AppNetworkImage.providerFor for caching"
```

---

### Task 6: Opacity Optimization

**Files:**
- Modify: `lib/features/video/presentation/widgets/controls/seek_ripple_overlay.dart`
- Modify: `lib/features/profile/presentation/widgets/user_profile_app_bar.dart`

- [ ] **Step 1: Fix seek_ripple_overlay.dart — replace Opacity with FadeTransition**

The current code uses `AnimatedBuilder` + `Opacity`. Replace with `FadeTransition` which is more efficient because it uses a separate compositing layer that doesn't rebuild the widget tree.

Before (lines 28-58):
```dart
child: AnimatedBuilder(
  animation: controller,
  builder: (context, child) {
    return Opacity(
      opacity: 1.0 - controller.value,
      child: Container(
        color: colorScheme.onPrimary.withValues(alpha: 0.2),
        alignment: isForward ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isForward ? Icons.fast_forward_rounded : Icons.fast_rewind_rounded,
              color: colorScheme.onPrimary,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              '10s',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  },
),
```

After:
```dart
child: FadeTransition(
  opacity: Tween<double>(begin: 1.0, end: 0.0).animate(controller),
  child: Container(
    color: colorScheme.onPrimary.withValues(alpha: 0.2),
    alignment: isForward ? Alignment.centerRight : Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isForward ? Icons.fast_forward_rounded : Icons.fast_rewind_rounded,
          color: colorScheme.onPrimary,
          size: 40,
        ),
        const SizedBox(height: 8),
        Text(
          '10s',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    ),
  ),
),
```

- [ ] **Step 2: Fix user_profile_app_bar.dart — narrow Opacity scope (line 80)**

The current `Opacity` wraps the entire `Expanded` > `Text` subtree. Narrow it to only wrap the `Text`.

Before (lines 79-92):
```dart
Expanded(
  child: Opacity(
    opacity: opacity,
    child: Text(
      profile?.username ?? '',
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: contentColor,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  ),
),
```

After:
```dart
Expanded(
  child: Text(
    profile?.username ?? '',
    style: theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: contentColor.withValues(alpha: opacity),
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  ),
),
```

Note: We apply opacity via `color.withValues(alpha:)` instead of the `Opacity` widget, which avoids creating a separate compositing layer entirely.

- [ ] **Step 3: Verify**

Run: `flutter analyze lib/features/video/presentation/widgets/controls/seek_ripple_overlay.dart lib/features/profile/presentation/widgets/user_profile_app_bar.dart`
Expected: No errors

- [ ] **Step 4: Commit**

```bash
git add lib/features/video/presentation/widgets/controls/seek_ripple_overlay.dart \
  lib/features/profile/presentation/widgets/user_profile_app_bar.dart
git commit -m "perf: replace Opacity widget with FadeTransition and color alpha"
```

---

### Task 7: TextEditingController Leak Fix

**Files:**
- Modify: `lib/features/dynamic/presentation/widgets/dynamic_comments_view.dart`

- [ ] **Step 1: Add hooks import**

Add `import 'package:flutter_hooks/flutter_hooks.dart';` to imports.

- [ ] **Step 2: Change class to use hooks**

Change `class DynamicCommentsSliver extends ConsumerWidget` to `class DynamicCommentsSliver extends HookConsumerWidget`.

- [ ] **Step 3: Fix _showReplySheet to use a StatefulWidget bottom sheet**

The `_showReplySheet` method creates a `TextEditingController` in a method scope. Refactor the bottom sheet builder to use a `StatefulBuilder` that disposes the controller.

Before (lines 64-132):
```dart
void _showReplySheet(BuildContext context, WidgetRef ref, CommentItem comment) {
  final theme = Theme.of(context);
  final controller = TextEditingController();
  final notifier = ref.read(dynamicCommentControllerProvider(post).notifier);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: theme.colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  t.video.reply_to(name: comment.member.uname),
                  style: theme.textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: t.moments.comment_hint,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              maxLines: 3,
              minLines: 1,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: () {
                  final text = controller.text.trim();
                  if (text.isNotEmpty) {
                    notifier.addReply(comment.rpid, comment.root, text);
                    Navigator.pop(context);
                  }
                },
                child: Text(t.moments.publish),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}
```

After:
```dart
void _showReplySheet(BuildContext context, WidgetRef ref, CommentItem comment) {
  final theme = Theme.of(context);
  final notifier = ref.read(dynamicCommentControllerProvider(post).notifier);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: theme.colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return _ReplySheetContent(
        comment: comment,
        theme: theme,
        t: t,
        onSubmit: (text) {
          notifier.addReply(comment.rpid, comment.root, text);
        },
      );
    },
  );
}
```

Add a new private widget at the bottom of the file:

```dart
class _ReplySheetContent extends StatefulWidget {
  final CommentItem comment;
  final ThemeData theme;
  final Translations t;
  final ValueChanged<String> onSubmit;

  const _ReplySheetContent({
    required this.comment,
    required this.theme,
    required this.t,
    required this.onSubmit,
  });

  @override
  State<_ReplySheetContent> createState() => _ReplySheetContentState();
}

class _ReplySheetContentState extends State<_ReplySheetContent> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                widget.t.video.reply_to(name: widget.comment.member.uname),
                style: widget.theme.textTheme.titleMedium,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: widget.t.moments.comment_hint,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            maxLines: 3,
            minLines: 1,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: () {
                final text = _controller.text.trim();
                if (text.isNotEmpty) {
                  widget.onSubmit(text);
                  Navigator.pop(context);
                }
              },
              child: Text(widget.t.moments.publish),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: Verify**

Run: `flutter analyze lib/features/dynamic/presentation/widgets/dynamic_comments_view.dart`
Expected: No errors

- [ ] **Step 5: Commit**

```bash
git add lib/features/dynamic/presentation/widgets/dynamic_comments_view.dart
git commit -m "fix(dynamic): TextEditingController leak in reply sheet"
```

---

### Task 8: Missing cacheWidth/cacheHeight

**Files:**
- Modify: `lib/features/dynamic/presentation/widgets/emoji_picker.dart`
- Modify: `lib/features/notification/presentation/widgets/chat_message_item.dart`
- Modify: `lib/features/notification/presentation/widgets/private_session_item.dart`
- Modify: `lib/features/dynamic/presentation/widgets/content/dynamic_images_widget.dart`

- [ ] **Step 1: Fix emoji_picker.dart — tab icons (line 61)**

Before:
```dart
ExtendedImage.network(
  package.url,
  width: 24,
  height: 24,
  fit: BoxFit.contain,
),
```

After:
```dart
ExtendedImage.network(
  package.url,
  width: 24,
  height: 24,
  fit: BoxFit.contain,
  cacheWidth: 48,
  cacheHeight: 48,
),
```

(48 = 24 * 2, assuming 2x pixel ratio as conservative default)

- [ ] **Step 2: Fix emoji_picker.dart — grid items (line 99)**

Before:
```dart
ExtendedImage.network(emote.url, fit: BoxFit.contain)
```

After:
```dart
ExtendedImage.network(emote.url, fit: BoxFit.contain, cacheWidth: 96, cacheHeight: 96)
```

(96 = 48 * 2, grid items are 48x48 logical)

- [ ] **Step 3: Fix chat_message_item.dart — avatar (line 75)**

Add `import 'package:flutter/widgets.dart';` if not present (for `MediaQuery`).

Before:
```dart
ExtendedImage.network(
  url,
  fit: BoxFit.cover,
  cache: true,
  loadStateChanged: (state) {
```

After:
```dart
final dpr = MediaQuery.devicePixelRatioOf(context);
final cacheSize = (40 * dpr).round().clamp(1, 2048);
ExtendedImage.network(
  url,
  fit: BoxFit.cover,
  cache: true,
  cacheWidth: cacheSize,
  cacheHeight: cacheSize,
  loadStateChanged: (state) {
```

- [ ] **Step 4: Fix private_session_item.dart — avatar (line 146)**

Before:
```dart
ExtendedImage.network(
  url,
  width: 48,
  height: 48,
  shape: BoxShape.circle,
  fit: BoxFit.cover,
  loadStateChanged: (state) {
```

After:
```dart
final dpr = MediaQuery.devicePixelRatioOf(context);
final cacheSize = (48 * dpr).round().clamp(1, 2048);
ExtendedImage.network(
  url,
  width: 48,
  height: 48,
  shape: BoxShape.circle,
  fit: BoxFit.cover,
  cacheWidth: cacheSize,
  cacheHeight: cacheSize,
  loadStateChanged: (state) {
```

- [ ] **Step 5: Fix dynamic_images_widget.dart — single image (line 29)**

The single image case needs width/height constraints for AppNetworkImage to resolve cache dimensions.

Before:
```dart
child: AppNetworkImage(url: validImages.first, fit: BoxFit.cover, borderRadius: 8),
```

After:
```dart
child: AppNetworkImage(
  url: validImages.first,
  fit: BoxFit.cover,
  borderRadius: 8,
  width: 240,
  height: 240,
),
```

(240 matches the `maxHeight`/`maxWidth` constraint. `AppNetworkImage` will resolve `cacheWidth`/`cacheHeight` from these.)

- [ ] **Step 6: Verify**

Run: `flutter analyze lib/features/dynamic/presentation/widgets/emoji_picker.dart lib/features/notification/presentation/widgets/chat_message_item.dart lib/features/notification/presentation/widgets/private_session_item.dart lib/features/dynamic/presentation/widgets/content/dynamic_images_widget.dart`
Expected: No errors

- [ ] **Step 7: Commit**

```bash
git add lib/features/dynamic/presentation/widgets/emoji_picker.dart \
  lib/features/notification/presentation/widgets/chat_message_item.dart \
  lib/features/notification/presentation/widgets/private_session_item.dart \
  lib/features/dynamic/presentation/widgets/content/dynamic_images_widget.dart
git commit -m "perf: add cacheWidth/cacheHeight to prevent full-resolution decode"
```

---

### Task 9: Phase 1 Verification

- [ ] **Step 1: Run full analysis**

Run: `flutter analyze`
Expected: No new errors introduced

- [ ] **Step 2: Run tests**

Run: `flutter test`
Expected: All tests pass

- [ ] **Step 3: Manual verification checklist**

- Open dynamic page, switch between 4 tabs rapidly — scroll position should persist
- Open a dynamic post with images — images should load with shimmer, no double-clipping visible
- Open user profile, scroll down — username should fade in smoothly
- Open video, seek forward — ripple animation should be smooth
- Open a dynamic post, tap reply — bottom sheet should work, controller should be disposed on close

---

## Phase 2: List Rendering Optimization

### Task 10: Dynamic Feed Sliver Architecture

Refactor `DynamicListView` from `ListView.separated` to `CustomScrollView` + `SliverList.builder`, with `RecentlyFollowedWidget` as a pinned `SliverToBoxAdapter`.

**Files:**
- Modify: `lib/features/dynamic/presentation/widgets/dynamic_list_view.dart`

- [ ] **Step 1: Refactor DynamicListView to use CustomScrollView**

Replace the `SmartPagingView` builder's `ListView.separated` with a `CustomScrollView`.

Before (lines 29-65):
```dart
child: SmartPagingView<DynamicItem>(
  asyncValue: state,
  onRefresh: notifier.refresh,
  onLoadMore: notifier.loadMore,
  itemCount: () => ref.read(provider).value?.length ?? 0,
  skeleton: const VideoListSkeleton(),
  emptyText: t.common.no_content,
  builder: (context, items) {
    return ListView.separated(
      padding: contentPadding,
      itemCount: items.length + (type == 'all' ? 1 : 0),
      itemBuilder: (context, index) {
        if (type == 'all') {
          if (index == 0) return const RecentlyFollowedWidget();
          final post = items[index - 1];
          return KeyedSubtree(
            key: ValueKey(post.id),
            child: DynamicPostCard(
              post: post,
              onLike: (post) => notifier.toggleLike(post.id, post.isLiked),
            ),
          );
        }
        final post = items[index];
        return KeyedSubtree(
          key: ValueKey(post.id),
          child: DynamicPostCard(
            post: post,
            onLike: (post) => notifier.toggleLike(post.id, post.isLiked),
          ),
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: context.isDesktopLayout ? 10 : 8),
    );
  },
),
```

After:
```dart
child: SmartPagingView<DynamicItem>(
  asyncValue: state,
  onRefresh: notifier.refresh,
  onLoadMore: notifier.loadMore,
  itemCount: () => ref.read(provider).value?.length ?? 0,
  skeleton: const VideoListSkeleton(),
  emptyText: t.common.no_content,
  builder: (context, items) {
    final separatorHeight = context.isDesktopLayout ? 10.0 : 8.0;
    final postCount = items.length;
    final showFollowed = type == 'all';
    final sliverCount = postCount + (showFollowed ? 1 : 0);

    return CustomScrollView(
      slivers: [
        if (showFollowed)
          const SliverToBoxAdapter(child: RecentlyFollowedWidget()),
        SliverList.separated(
          itemCount: postCount,
          separatorBuilder: (context, index) => SizedBox(height: separatorHeight),
          itemBuilder: (context, index) {
            final post = items[index];
            return KeyedSubtree(
              key: ValueKey(post.id),
              child: DynamicPostCard(
                post: post,
                onLike: (post) => notifier.toggleLike(post.id, post.isLiked),
              ),
            );
          },
        ),
      ],
    );
  },
),
```

- [ ] **Step 2: Verify**

Run: `flutter analyze lib/features/dynamic/presentation/widgets/dynamic_list_view.dart`
Expected: No errors

- [ ] **Step 3: Manual test**

- Open dynamic page, scroll down — `RecentlyFollowedWidget` should stay visible at top (not recycled)
- Switch tabs — scroll position should persist (from Task 1)
- Pull to refresh — should work correctly
- Scroll to bottom — load more should trigger

- [ ] **Step 4: Commit**

```bash
git add lib/features/dynamic/presentation/widgets/dynamic_list_view.dart
git commit -m "perf(dynamic): refactor to Sliver architecture, pin RecentlyFollowedWidget"
```

---

### Task 11: Unified Keep-Alive Strategy

**Files:**
- Modify: `lib/features/home/presentation/pages/home_page.dart`
- Modify: `lib/features/home/presentation/widgets/live_view.dart`
- Modify: `lib/features/home/presentation/widgets/recommend_view.dart`
- Modify: `lib/features/home/presentation/widgets/popular_view.dart`

- [ ] **Step 1: Check live_view.dart for keep-alive**

Read `lib/features/home/presentation/widgets/live_view.dart`. If it extends `HookConsumerWidget`, add `useAutomaticKeepAlive();` in the build method. If it doesn't use hooks, convert it or use `AutomaticKeepAliveClientMixin`.

- [ ] **Step 2: Check recommend_view.dart for keep-alive**

Read `lib/features/home/presentation/widgets/recommend_view.dart`. Same approach as Step 1.

- [ ] **Step 3: Check popular_view.dart for keep-alive**

Read `lib/features/home/presentation/widgets/popular_view.dart`. Same approach as Step 1.

- [ ] **Step 4: Update home_page.dart**

Once all three tab views have `useAutomaticKeepAlive`, the `visitedTabs` lazy initialization pattern in `home_page.dart` can be simplified. The `visitedTabs` set is still needed to avoid building all tabs on first load, but the tabs themselves will now preserve their state.

No change needed to `home_page.dart` itself — the `visitedTabs` pattern and `useAutomaticKeepAlive` complement each other.

- [ ] **Step 5: Check favorites_page.dart**

Read `lib/features/features/favorites/presentation/pages/favorites_page.dart` and its tab children. Add `useAutomaticKeepAlive` if missing.

- [ ] **Step 6: Verify**

Run: `flutter analyze lib/features/home/ lib/features/favorites/`
Expected: No errors

- [ ] **Step 7: Manual test**

- Open home page, scroll recommend tab, switch to live tab, switch back — scroll position should persist
- Open favorites, switch between tabs — scroll position should persist

- [ ] **Step 8: Commit**

```bash
git add lib/features/home/presentation/widgets/live_view.dart \
  lib/features/home/presentation/widgets/recommend_view.dart \
  lib/features/home/presentation/widgets/popular_view.dart \
  lib/features/favorites/
git commit -m "perf: add keep-alive to all TabBarView children"
```

---

### Task 12: Video Card Precaching

Add scroll-aware image precaching that prefetches upcoming cover images when scrolling stabilizes.

**Files:**
- Create: `lib/core/hooks/use_scroll_precache.dart`
- Modify: `lib/features/home/presentation/widgets/recommend_view.dart`
- Modify: `lib/features/home/presentation/widgets/popular_view.dart`

- [ ] **Step 1: Create useScrollPrecache hook**

Create `lib/core/hooks/use_scroll_precache.dart`:

```dart
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/ui/widgets/app_network_image_prefetcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Precaches images for items that are about to scroll into view.
///
/// Monitors scroll velocity and, when scrolling is stable (not flinging),
/// prefetches the next [prefetchCount] images using [AppNetworkImagePrefetcher].
void useScrollPrecache({
  required ScrollController scrollController,
  required List<NetworkImagePrefetchSpec> Function(int firstVisibleIndex, int count) getUpcomingSpecs,
  int prefetchCount = 5,
  Duration debounce = const Duration(milliseconds: 300),
}) {
  final context = useContext();
  final debounceTimer = useRef<Timer?>(null);
  final lastPrefetchedIndex = useRef<int>(-1);

  useEffect(() {
    void onScroll() {
      if (!scrollController.hasClients) return;

      final position = scrollController.position;
      // Skip during fling (fast scroll)
      if (position.isScrollingNotifier.value) return;

      debounceTimer.value?.cancel();
      debounceTimer.value = Timer(debounce, () {
        if (!context.mounted) return;

        // Check performance policy
        final policy = PerformancePolicyController.notifier.value;
        if (policy == PerformanceLevel.minimalEffects) return;

        // Estimate first visible index from scroll offset
        // Use a rough estimate of 200px per item
        final estimatedIndex = (position.pixels / 200).floor();

        if (estimatedIndex == lastPrefetchedIndex.value) return;
        lastPrefetchedIndex.value = estimatedIndex;

        final specs = getUpcomingSpecs(estimatedIndex, prefetchCount);
        if (specs.isNotEmpty) {
          AppNetworkImagePrefetcher.prefetch(
            context,
            specs: specs,
            limit: prefetchCount,
            maxConcurrency: 2,
          );
        }
      });
    }

    scrollController.addListener(onScroll);
    return () {
      scrollController.removeListener(onScroll);
      debounceTimer.value?.cancel();
    };
  }, [scrollController]);
}
```

- [ ] **Step 2: Integrate in recommend_view.dart**

Read `lib/features/home/presentation/widgets/recommend_view.dart` to find the `ScrollController` and video list. Add the hook call after the scroll controller is created:

```dart
useScrollPrecache(
  scrollController: scrollController, // or however the controller is named
  getUpcomingSpecs: (firstIndex, count) {
    final videos = ref.read(homeRecommendProvider).value ?? [];
    final start = firstIndex + 1;
    final end = (start + count).clamp(0, videos.length);
    return videos.sublist(start, end).map((v) =>
      NetworkImagePrefetchSpec(url: v.pic, memCacheWidth: 400, memCacheHeight: 250)
    ).toList();
  },
);
```

- [ ] **Step 3: Integrate in popular_view.dart**

Same pattern as recommend_view.dart, using the popular videos provider.

- [ ] **Step 4: Verify**

Run: `flutter analyze lib/core/hooks/use_scroll_precache.dart lib/features/home/`
Expected: No errors

- [ ] **Step 5: Commit**

```bash
git add lib/core/hooks/use_scroll_precache.dart \
  lib/features/home/presentation/widgets/recommend_view.dart \
  lib/features/home/presentation/widgets/popular_view.dart
git commit -m "perf: add scroll-aware image precaching for feed views"
```

---

### Task 13: Widget Tree Depth Reduction

**Files:**
- Modify: `lib/features/dynamic/presentation/widgets/dynamic_post_card.dart`

- [ ] **Step 1: Merge Container and Padding in DynamicPostCard**

Before (lines 20-46):
```dart
return Container(
  decoration: BoxDecoration(
    color: colorScheme.surface,
    border: Border(
      bottom: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.35)),
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DynamicPostHeader(post: post),
        const SizedBox(height: 12),
        _buildContentSection(context),
        const SizedBox(height: 12),
        Divider(
          height: 1,
          thickness: 0.5,
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
        _buildFooter(context),
      ],
    ),
  ),
);
```

After:
```dart
return Container(
  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
  decoration: BoxDecoration(
    color: colorScheme.surface,
    border: Border(
      bottom: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.35)),
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DynamicPostHeader(post: post),
      const SizedBox(height: 12),
      _buildContentSection(context),
      const SizedBox(height: 12),
      Divider(
        height: 1,
        thickness: 0.5,
        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
      ),
      _buildFooter(context),
    ],
  ),
);
```

- [ ] **Step 2: Verify**

Run: `flutter analyze lib/features/dynamic/presentation/widgets/dynamic_post_card.dart`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/dynamic/presentation/widgets/dynamic_post_card.dart
git commit -m "perf(dynamic): reduce widget tree depth in DynamicPostCard"
```

---

### Task 14: Phase 2 Verification

- [ ] **Step 1: Run full analysis**

Run: `flutter analyze`
Expected: No new errors

- [ ] **Step 2: Run tests**

Run: `flutter test`
Expected: All tests pass

- [ ] **Step 3: Manual verification**

- Scroll dynamic feed — header should stay pinned, list should be smooth
- Switch home tabs — scroll position should persist
- Dynamic post cards should render identically to before

---

## Phase 3: Media Pipeline Optimization

### Task 15: Danmaku Rendering Pipeline — Mark-and-Sweep

**Files:**
- Modify: `lib/features/video/presentation/widgets/danmaku/ns_danmaku/danmaku_view.dart`
- Modify: `lib/features/video/presentation/widgets/danmaku/ns_danmaku/danmaku_view.ticker.dart`

- [ ] **Step 1: Add `_sweepCounter` field to `_DanmakuViewState`**

In `danmaku_view.dart`, add a counter field after `_lastFrameTime`:

```dart
int _sweepCounter = 0;
```

- [ ] **Step 2: Modify `_updateScrollingItems` in danmaku_view.ticker.dart**

Replace `removeWhere` with mark-and-sweep. Mark expired items by setting a flag, then compact periodically.

Before:
```dart
void _updateScrollingItems(int delta) {
  _activeItems.removeWhere((item) {
    if (item.type != DanmakuItemType.scroll) {
      return false;
    }
    item.x -= item.velocity * delta;
    return item.x + item.width < 0;
  });
}
```

After:
```dart
void _updateScrollingItems(int delta) {
  for (final item in _activeItems) {
    if (item.type == DanmakuItemType.scroll) {
      item.x -= item.velocity * delta;
    }
  }
  _sweepCounter++;
  if (_sweepCounter >= 60) {
    _sweepCounter = 0;
    _activeItems.removeWhere((item) {
      if (item.type == DanmakuItemType.scroll) {
        return item.x + item.width < 0;
      }
      return false;
    });
  }
}
```

- [ ] **Step 3: Modify `_removeExpiredStaticItems` in danmaku_view.ticker.dart**

Same mark-and-sweep approach:

Before:
```dart
void _removeExpiredStaticItems(int currentMs) {
  const staticDuration = 5000;
  _activeItems.removeWhere((item) {
    if (item.type == DanmakuItemType.scroll) {
      return false;
    }
    return (currentMs - item.creationTime) > staticDuration;
  });
}
```

After:
```dart
void _removeExpiredStaticItems(int currentMs) {
  const staticDuration = 5000;
  if (_sweepCounter != 0) return; // Only sweep on the same frame as scrolling sweep
  _activeItems.removeWhere((item) {
    if (item.type == DanmakuItemType.scroll) {
      return false;
    }
    return (currentMs - item.creationTime) > staticDuration;
  });
}
```

- [ ] **Step 4: Verify**

Run: `flutter analyze lib/features/video/presentation/widgets/danmaku/ns_danmaku/`
Expected: No errors

- [ ] **Step 5: Commit**

```bash
git add lib/features/video/presentation/widgets/danmaku/ns_danmaku/danmaku_view.dart \
  lib/features/video/presentation/widgets/danmaku/ns_danmaku/danmaku_view.ticker.dart
git commit -m "perf(danmaku): mark-and-sweep for active items, reduce O(n) removals"
```

---

### Task 16: Danmaku Rendering Pipeline — Option Update Optimization

**Files:**
- Modify: `lib/features/video/presentation/widgets/danmaku/ns_danmaku/danmaku_view.dart`

- [ ] **Step 1: Replace setState with _requestRepaint in _updateOption**

Before:
```dart
void _updateOption(DanmakuOption option) {
  if (!mounted) return;
  setState(() {
    _option = option;
  });
  _requestRepaint();
}
```

After:
```dart
void _updateOption(DanmakuOption option) {
  if (!mounted) return;
  _option = option;
  _requestRepaint();
}
```

This avoids rebuilding the entire widget (including `LayoutBuilder`) when only the option changes. The `_requestRepaint()` call triggers only a `CustomPaint` repaint, not a full widget rebuild.

- [ ] **Step 2: Verify**

Run: `flutter analyze lib/features/video/presentation/widgets/danmaku/ns_danmaku/danmaku_view.dart`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/video/presentation/widgets/danmaku/ns_danmaku/danmaku_view.dart
git commit -m "perf(danmaku): skip setState on option update, use repaint only"
```

---

### Task 17: Video Player Widget Tree Reduction

**Files:**
- Modify: `lib/features/video/presentation/widgets/video_player_view.dart`

- [ ] **Step 1: Flatten _InteractiveVideoLayers into parent**

The current structure has `_InteractiveVideoLayers` as a separate `HookWidget` with its own `Stack`. Flatten it into the parent `VideoPlayerView`.

Before:
```dart
return AspectRatio(
  aspectRatio: isFullscreen ? MediaQuery.of(context).size.aspectRatio : 16 / 10,
  child: Container(
    color: colorScheme.scrim,
    child: Stack(
      children: [
        _InteractiveVideoLayers(bvid: bvid, player: player, brightness: brightness),
        ControlsLayer(
          bvid: bvid,
          onToggleFullscreen: onToggleFullscreen,
          isFullscreen: isFullscreen,
        ),
      ],
    ),
  ),
);
```

After:
```dart
final volumeSnapshot = useStream(player.stream.volume);
final currentVolume = volumeSnapshot.data ?? player.state.volume;

return AspectRatio(
  aspectRatio: isFullscreen ? MediaQuery.of(context).size.aspectRatio : 16 / 10,
  child: Container(
    color: colorScheme.scrim,
    child: Stack(
      children: [
        InteractionLayer(
          bvid: bvid,
          brightness: brightness,
          currentVolume: currentVolume,
          child: const Stack(
            fit: StackFit.passthrough,
            children: [
              VideoLayer(),
              Positioned.fill(child: DanmakuLayer(bvid: bvid)),
              Positioned.fill(child: SubtitleLayer(bvid: bvid)),
            ],
          ),
        ),
        ControlsLayer(
          bvid: bvid,
          onToggleFullscreen: onToggleFullscreen,
          isFullscreen: isFullscreen,
        ),
      ],
    ),
  ),
);
```

Remove the `_InteractiveVideoLayers` class entirely.

- [ ] **Step 2: Verify**

Run: `flutter analyze lib/features/video/presentation/widgets/video_player_view.dart`
Expected: No errors

- [ ] **Step 3: Manual test**

- Open a video — player should render correctly
- Danmaku, subtitles, and controls should all work
- Gesture interactions (tap, swipe for brightness/volume) should work

- [ ] **Step 4: Commit**

```bash
git add lib/features/video/presentation/widgets/video_player_view.dart
git commit -m "perf(video): flatten _InteractiveVideoLayers, reduce widget nesting"
```

---

### Task 18: PlayerControlsOverlay Optimization

**Files:**
- Modify: `lib/features/video/presentation/widgets/controls/player_controls_overlay.dart`

- [ ] **Step 1: Skip build when hidden**

The current code uses `AnimatedOpacity` which still builds all children even when opacity is 0. Add an `Offstage` wrapper or conditional rendering.

Before:
```dart
return RepaintBoundary(
  child: AnimatedOpacity(
    opacity: showControls ? 1.0 : 0.0,
    duration: const Duration(milliseconds: 200),
    child: Stack(
      children: [
        if (!isLocked) ...[
          // ... top bar, bottom bar, gradients
        ],
        // ... lock button
      ],
    ),
  ),
);
```

After:
```dart
if (!showControls && !isLocked) {
  return const RepaintBoundary(child: SizedBox.shrink());
}

return RepaintBoundary(
  child: AnimatedOpacity(
    opacity: showControls ? 1.0 : 0.0,
    duration: const Duration(milliseconds: 200),
    child: Stack(
      children: [
        if (!isLocked) ...[
          // ... top bar, bottom bar, gradients (unchanged)
        ],
        // ... lock button (unchanged)
      ],
    ),
  ),
);
```

Note: We keep the full build when `isLocked` is true because the lock button needs to remain visible. Only skip when controls are hidden AND not locked.

- [ ] **Step 2: Verify**

Run: `flutter analyze lib/features/video/presentation/widgets/controls/player_controls_overlay.dart`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/video/presentation/widgets/controls/player_controls_overlay.dart
git commit -m "perf(video): skip PlayerControlsOverlay build when hidden"
```

---

### Task 19: Phase 3 Verification

- [ ] **Step 1: Run full analysis**

Run: `flutter analyze`
Expected: No new errors

- [ ] **Step 2: Run tests**

Run: `flutter test`
Expected: All tests pass

- [ ] **Step 3: Manual verification**

- Open video with heavy danmaku — should be smooth, no frame drops
- Change danmaku settings (font size, opacity) — should update without flicker
- Open video, hide controls, tap to show — should animate smoothly
- Check memory usage in DevTools — should be lower than before

---

## Final Verification

- [ ] **Step 1: Run full test suite**

Run: `flutter test`
Expected: All tests pass

- [ ] **Step 2: Run full analysis**

Run: `flutter analyze`
Expected: No errors

- [ ] **Step 3: Build verification**

Run: `flutter build apk --debug` (or platform of choice)
Expected: Build succeeds

- [ ] **Step 4: Performance check**

Use Flutter DevTools Timeline to verify:
- Dynamic feed scrolling: < 16ms per frame
- Tab switching: instant (no rebuild)
- Danmaku rendering: < 8ms per frame
- Video controls show/hide: smooth animation
