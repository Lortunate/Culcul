import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_item_extensions.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/presentation/dynamic_share.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class DynamicPostCard extends StatelessWidget {
  final DynamicItem post;
  final Widget header;
  final Widget content;
  final VoidCallback? onLike;

  const DynamicPostCard({
    super.key,
    required this.post,
    required this.header,
    required this.content,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    Widget stat({
      required IconData icon,
      required int count,
      required String defaultText,
      required VoidCallback onTap,
      Color? color,
    }) {
      final contentColor = color ?? colorScheme.onSurfaceVariant;

      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: contentColor),
              const SizedBox(width: 6),
              Text(
                count > 0 ? FormatUtils.formatNumber(count) : defaultText,
                style: TextStyle(
                  fontSize: 13,
                  color: contentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RepaintBoundary(
      child: Container(
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
            header,
            const SizedBox(height: 12),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () =>
                    DynamicNavigationScope.of(context).onOpenDynamicDetail(post.id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: content,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Divider(
              height: 1,
              thickness: 0.5,
              color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
            Row(
              children: [
                Expanded(
                  child: stat(
                    icon: Icons.reply_rounded,
                    count: post.forwardCount,
                    defaultText: t.actions.forward,
                    onTap: () async {
                      await shareDynamicItem(
                        dynamicId: post.id,
                        content: post.description ?? '',
                      );
                    },
                  ),
                ),
                Expanded(
                  child: stat(
                    icon: Icons.chat_bubble_outline_rounded,
                    count: post.commentCount,
                    defaultText: t.actions.comment,
                    onTap: () {
                      DynamicNavigationScope.of(context).onOpenDynamicDetail(post.id);
                    },
                  ),
                ),
                Expanded(
                  child: stat(
                    icon: post.isLiked
                        ? Icons.thumb_up_alt_rounded
                        : Icons.thumb_up_alt_outlined,
                    count: post.likeCount,
                    defaultText: t.actions.like,
                    onTap: () {
                      final likeHandler = onLike;
                      if (likeHandler == null) {
                        context.showAppFeedback(t.moments.like_coming_soon);
                        return;
                      }
                      likeHandler();
                    },
                    color: post.isLiked ? colorScheme.primary : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
