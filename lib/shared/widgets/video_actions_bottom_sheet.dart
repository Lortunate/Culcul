import 'package:culcul/shared/widgets/adaptive_blur.dart';
import 'package:flutter/material.dart';

class VideoActionsBottomSheet extends StatelessWidget {
  final String watchLaterLabel;
  final String downloadCoverLabel;
  final VoidCallback onWatchLaterTap;
  final VoidCallback onDownloadCoverTap;

  const VideoActionsBottomSheet({
    super.key,
    required this.watchLaterLabel,
    required this.downloadCoverLabel,
    required this.onWatchLaterTap,
    required this.onDownloadCoverTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    const topRadius = BorderRadius.vertical(top: Radius.circular(16));

    return ClipRRect(
      borderRadius: topRadius,
      child: AdaptiveBlur(
        sigmaX: 20,
        sigmaY: 20,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.8),
            borderRadius: topRadius,
            border: Border(
              top: BorderSide(
                color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _DragHandle(colorScheme: colorScheme),
                  _ActionItem(
                    icon: Icons.watch_later_outlined,
                    text: watchLaterLabel,
                    onTap: onWatchLaterTap,
                  ),
                  _ActionItem(
                    icon: Icons.image_outlined,
                    text: downloadCoverLabel,
                    onTap: onDownloadCoverTap,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  final ColorScheme colorScheme;

  const _DragHandle({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: 36,
      height: 4,
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ActionItem({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 24, color: colorScheme.onSurface),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
