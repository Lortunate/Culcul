import 'package:cilixili/core/theme/app_colors.dart';
import 'package:cilixili/core/utils/format_utils.dart';
import 'package:cilixili/data/models/video/index.dart';
import 'package:cilixili/i18n/strings.g.dart';
import 'package:cilixili/shared/widgets/index.dart';
import 'package:flutter/material.dart';

class CommentItemWidget extends StatelessWidget {
  final CommentItem item;
  final VoidCallback? onLike;
  final VoidCallback? onReply;
  final bool showRepliesPreview;
  final VoidCallback? onTapReplies;

  const CommentItemWidget({
    super.key,
    required this.item,
    this.onLike,
    this.onReply,
    this.showRepliesPreview = true,
    this.onTapReplies,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(isDark),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, isDark),
                const SizedBox(height: 8),
                _buildContent(context, isDark, textTheme),
                const SizedBox(height: 10),
                _buildFooter(context, isDark),
                if (showRepliesPreview && item.replies.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildReplies(context, isDark),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isDark) {
    return AppAvatar(url: item.member.avatar, size: 40);
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    final nameColor = item.member.vip.vipStatus == 1
        ? const Color(0xFFFB7299)
        : (isDark ? Colors.grey[300] : const Color(0xFF333333));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          item.member.uname,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: nameColor,
          ),
        ),
        const SizedBox(width: 8),
        if (item.member.level_info.current_level > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF9499A0).withValues(alpha: 0.4),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              'LV${item.member.level_info.current_level}',
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF9499A0),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, bool isDark, TextTheme textTheme) {
    return SelectableText(
      item.content.message,
      style: TextStyle(
        fontSize: 14,
        height: 1.6,
        color: isDark
            ? Colors.white.withValues(alpha: 0.85)
            : const Color(0xFF18191C),
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDark) {
    final subTextColor = isDark ? Colors.grey[600]! : const Color(0xFF9499A0);

    return SizedBox(
      height: 28,
      child: Row(
        children: [
          Text(
            FormatUtils.formatTimestamp(item.ctime),
            style: TextStyle(fontSize: 12, color: subTextColor),
          ),
          if (item.content.device.isNotEmpty) ...[
            const SizedBox(width: 12),
            Text(
              item.content.device,
              style: TextStyle(fontSize: 12, color: subTextColor),
            ),
          ],
          const Spacer(),
          _buildActionButton(
            icon: Icons.thumb_up_outlined,
            label: item.like > 0
                ? '${item.like}'
                : Translations.of(context).video.actions.like,
            onTap: onLike,
            color: subTextColor,
            isDark: isDark,
          ),
          const SizedBox(width: 20),
          _buildActionButton(
            icon: Icons.chat_bubble_outline_rounded,
            label: Translations.of(context).video.actions.reply,
            onTap: onReply,
            color: subTextColor,
            isDark: isDark,
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Icon(Icons.more_vert, size: 16, color: subTextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    required Color color,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: color),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReplies(BuildContext context, bool isDark) {
    final replyTextColor = isDark
        ? Colors.white.withValues(alpha: 0.75)
        : const Color(0xFF18191C);

    return GestureDetector(
      onTap: onTapReplies,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF252526) : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.05),
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...item.replies.take(2).map((reply) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: replyTextColor,
                    ),
                    children: [
                      TextSpan(
                        text: '${reply.member.uname} ',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: reply.content.message,
                        style: TextStyle(
                          color: replyTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            if (item.rcount > 2)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${Translations.of(context).video.replies(count: item.rcount)} >',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
