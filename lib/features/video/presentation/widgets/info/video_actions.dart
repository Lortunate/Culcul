import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_state.dart';
import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:flutter/material.dart';

class VideoActionsRow extends StatelessWidget {
  final VideoDetailState state;

  const VideoActionsRow({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final d = state.videoDetail!;
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ActionButton(
            icon: Icons.share_outlined,
            label: '${t.actions.share} ${d.stat.share.formatNumber}',
            onTap: () => ShareUtils.shareVideo(d.bvid, d.title, d.pic),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: colorScheme.onSurfaceVariant),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
