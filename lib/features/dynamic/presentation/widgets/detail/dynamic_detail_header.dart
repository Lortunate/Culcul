import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/dynamic/presentation/utils/dynamic_navigation.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DynamicDetailHeader extends StatelessWidget {
  final DynamicItem post;

  const DynamicDetailHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        UserProfileRoute(mid: post.authorMid).push(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        child: Row(
          children: [
            AppAvatar(url: post.authorAvatar, size: 42),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.authorName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: post.authorName == '哔哩哔哩番剧' || post.authorName == '哔哩哔哩漫画'
                          ? colorScheme.primary
                          : colorScheme.onSurface,
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
              icon: Icon(Icons.more_vert, size: 20, color: colorScheme.onSurfaceVariant),
              onPressed: () => _showMoreActions(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMoreActions(BuildContext context) async {
    final t = Translations.of(context);
    final link = 'https://t.bilibili.com/${post.id}';
    final action = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: Text(t.actions.share),
              onTap: () => Navigator.pop(context, 'share'),
            ),
            ListTile(
              leading: const Icon(Icons.copy_all_rounded),
              title: Text(t.moments.copy_link),
              onTap: () => Navigator.pop(context, 'copy'),
            ),
            ListTile(
              leading: const Icon(Icons.open_in_browser_rounded),
              title: Text(t.moments.open_in_browser),
              onTap: () => Navigator.pop(context, 'open'),
            ),
          ],
        ),
      ),
    );
    if (!context.mounted) return;

    switch (action) {
      case 'share':
        await ShareUtils.shareDynamic(post.id, post.contentText ?? '');
        break;
      case 'copy':
        await Clipboard.setData(ClipboardData(text: link));
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.moments.copied_link)));
        }
        break;
      case 'open':
        await DynamicNavigation.open(context, url: link);
        break;
      default:
        break;
    }
  }
}

