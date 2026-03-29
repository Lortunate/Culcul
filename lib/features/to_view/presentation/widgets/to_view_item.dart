import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/toview/to_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/icon_text.dart';
import 'package:culcul/ui/widgets/video_list_card.dart';
import 'package:flutter/material.dart';

class ToViewItem extends StatelessWidget {
  final ToViewModel item;
  final VoidCallback? onTap;

  const ToViewItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return VideoListCard(
      onTap: onTap,
      coverUrl: item.pic ?? '',
      title: item.title ?? '',
      duration: item.hasProgress ? 0 : (item.duration ?? 0),
      thumbnailWidth: 140,
      aspectRatio: 140 / 88,
      height: 88,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      overlay: item.hasProgress
          ? Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                child: LinearProgressIndicator(
                  value: item.progressRatio,
                  minHeight: 3,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                ),
              ),
            )
          : null,
      middleContent: Row(
        children: [
          if (item.hasProgress) ...[
            Icon(Icons.history, size: 14, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                t.watch_later.watch_to(
                  progress: FormatUtils.formatDuration(item.progress ?? 0),
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else ...[
            Icon(Icons.person_outline, size: 14, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                item.owner?.name ?? '',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
      stats: [
        IconText(
          icon: Icons.play_circle_outline,
          text: FormatUtils.formatNumber(item.stat?.view ?? 0),
          iconSize: 12,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
        IconText(
          icon: Icons.comment_outlined,
          text: FormatUtils.formatNumber(item.stat?.danmaku ?? 0),
          iconSize: 12,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
