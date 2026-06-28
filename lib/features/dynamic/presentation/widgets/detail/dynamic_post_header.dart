import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_item_extensions.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/presentation/dynamic_share.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DynamicPostHeader extends StatelessWidget {
  final DynamicItem post;
  final double avatarSize;
  final IconData moreIcon;

  const DynamicPostHeader({
    super.key,
    required this.post,
    this.avatarSize = 40,
    this.moreIcon = Icons.more_horiz_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    void openUserProfile() {
      DynamicNavigationScope.of(context).onOpenUser(post.authorMid);
    }

    final authorColor = switch (post.authorName) {
      '哔哩哔哩番剧' || '哔哩哔哩漫画' => colorScheme.primary,
      _ => colorScheme.onSurface,
    };

    return Row(
      children: [
        AppAvatar(url: post.authorAvatar, size: avatarSize, onTap: openUserProfile),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppClickable(
                haptic: true,
                onTap: openUserProfile,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    post.authorName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: authorColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                post.timeText,
                style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(moreIcon, size: 20, color: colorScheme.onSurfaceVariant),
          onPressed: () async {
            final t = Translations.of(context);
            final link = 'https://t.bilibili.com/${post.id}';

            final action = await showModalBottomSheet<_DynamicPostAction>(
              context: context,
              showDragHandle: true,
              builder: (context) => SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.share_outlined),
                      title: Text(t.actions.share),
                      onTap: () => Navigator.pop(context, _DynamicPostAction.share),
                    ),
                    ListTile(
                      leading: const Icon(Icons.copy_all_rounded),
                      title: Text(t.moments.copy_link),
                      onTap: () => Navigator.pop(context, _DynamicPostAction.copyLink),
                    ),
                    ListTile(
                      leading: const Icon(Icons.open_in_browser_rounded),
                      title: Text(t.moments.open_in_browser),
                      onTap: () =>
                          Navigator.pop(context, _DynamicPostAction.openInBrowser),
                    ),
                  ],
                ),
              ),
            );

            if (!context.mounted || action == null) return;

            switch (action) {
              case _DynamicPostAction.share:
                await shareDynamicItem(
                  dynamicId: post.id,
                  content: post.contentText ?? '',
                );
              case _DynamicPostAction.copyLink:
                await Clipboard.setData(ClipboardData(text: link));
                if (context.mounted) {
                  context.showAppFeedback(t.moments.copied_link);
                }
              case _DynamicPostAction.openInBrowser:
                await DynamicNavigation.open(context, url: link);
            }
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        ),
      ],
    );
  }
}

enum _DynamicPostAction { share, copyLink, openInBrowser }
