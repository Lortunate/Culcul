import 'package:culcul/features/dynamic/application/presentation_contracts/dtos/dynamic_response.dart';
import 'package:culcul/features/dynamic/application/presentation_contracts/dtos/dynamic_item_extensions.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DynamicPostAction { share, copyLink, openInBrowser }

Future<void> showDynamicPostActions(BuildContext context, DynamicItem post) async {
  final t = Translations.of(context);
  final link = 'https://t.bilibili.com/${post.id}';

  final action = await showModalBottomSheet<DynamicPostAction>(
    context: context,
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: Text(t.actions.share),
            onTap: () => Navigator.pop(context, DynamicPostAction.share),
          ),
          ListTile(
            leading: const Icon(Icons.copy_all_rounded),
            title: Text(t.moments.copy_link),
            onTap: () => Navigator.pop(context, DynamicPostAction.copyLink),
          ),
          ListTile(
            leading: const Icon(Icons.open_in_browser_rounded),
            title: Text(t.moments.open_in_browser),
            onTap: () => Navigator.pop(context, DynamicPostAction.openInBrowser),
          ),
        ],
      ),
    ),
  );

  if (!context.mounted || action == null) return;

  switch (action) {
    case DynamicPostAction.share:
      await ShareUtils.shareDynamic(post.id, post.contentText ?? '');
      break;
    case DynamicPostAction.copyLink:
      await Clipboard.setData(ClipboardData(text: link));
      if (context.mounted) {
        context.showAppFeedback(t.moments.copied_link);
      }
      break;
    case DynamicPostAction.openInBrowser:
      await DynamicNavigation.open(context, url: link);
      break;
  }
}
