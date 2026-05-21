import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:flutter/material.dart';

class VideoActionsRow extends StatelessWidget {
  final VideoDetailViewData detail;
  final VoidCallback? onLike;
  final VoidCallback? onCoin;

  const VideoActionsRow({super.key, required this.detail, this.onLike, this.onCoin});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ActionButton(
              icon: Icons.thumb_up_alt_rounded,
              label: detail.stat.like.formatNumber,
              isSelected: detail.reqUser.like == 1,
              onTap: onLike,
            ),
          ),
          Expanded(
            child: ActionButton(
              icon: Icons.thumb_down_alt_rounded,
              label: t.actions.unlike,
            ),
          ),
          Expanded(
            child: ActionButton(
              icon: Icons.paid_rounded,
              label: detail.stat.coin.formatNumber,
              isSelected: detail.reqUser.coin > 0,
              onTap: onCoin,
            ),
          ),
          Expanded(
            child: ActionButton(
              icon: Icons.star_rounded,
              label: detail.stat.favorite.formatNumber,
              isSelected: detail.reqUser.favorite == 1,
            ),
          ),
          Expanded(
            child: ActionButton(
              icon: Icons.share_rounded,
              label: detail.stat.share.formatNumber,
              onTap: () => shareVideo(detail.bvid, detail.title, detail.pic),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isSelected;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AppClickable(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(height: 3),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 8.5,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
