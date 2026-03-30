import 'package:culcul/features/dynamic/domain/entities/dynamic_models.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_post_header.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_content_widget.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class DynamicPostCard extends StatelessWidget {
  final DynamicItem post;
  final Function(DynamicItem)? onLike;

  const DynamicPostCard({super.key, required this.post, this.onLike});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
  }

  Widget _buildContentSection(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => DynamicDetailRoute(id: post.id).push(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: DynamicContentWidget(post: post),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final t = Translations.of(context);

    return Row(
      children: [
        Expanded(
          child: _buildStat(
            context,
            Icons.reply_rounded,
            post.forwardCount,
            t.actions.forward,
            () async {
              await ShareUtils.shareDynamic(post.id, post.description ?? '');
            },
          ),
        ),
        Expanded(
          child: _buildStat(
            context,
            Icons.chat_bubble_outline_rounded,
            post.commentCount,
            t.actions.comment,
            () {
              DynamicDetailRoute(id: post.id).push(context);
            },
          ),
        ),
        Expanded(
          child: _buildStat(
            context,
            post.isLiked ? Icons.thumb_up_alt_rounded : Icons.thumb_up_alt_outlined,
            post.likeCount,
            t.actions.like,
            () {
              final likeHandler = onLike;
              if (likeHandler == null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(t.moments.like_coming_soon)));
                return;
              }
              likeHandler(post);
            },
            color: post.isLiked ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
      ],
    );
  }

  Widget _buildStat(
    BuildContext context,
    IconData icon,
    int count,
    String defaultText,
    VoidCallback onTap, {
    Color? color,
  }) {
    final contentColor = color ?? Theme.of(context).colorScheme.onSurfaceVariant;

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
}
