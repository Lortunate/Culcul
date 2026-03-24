import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:flutter/material.dart';

class BottomInputBar extends StatelessWidget {
  final VoidCallback? onTapInput;
  final VoidCallback? onTapLike;
  final VoidCallback? onTapCoin;
  final VoidCallback? onTapStar;
  final VoidCallback? onTapShare;

  final bool simpleMode;

  const BottomInputBar({
    super.key,
    this.onTapInput,
    this.onTapLike,
    this.onTapCoin,
    this.onTapStar,
    this.onTapShare,
    this.simpleMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: AppClickable(
                onTap: onTapInput,
                borderRadius: BorderRadius.circular(20),
                backgroundColor: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.6,
                ),
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        size: 16,
                        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        t.video.comment.hint,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (!simpleMode) ...[
              const SizedBox(width: 8),
              _ActionIcon(icon: Icons.thumb_up_outlined, onTap: onTapLike),
              _ActionIcon(icon: Icons.star_outline_rounded, onTap: onTapStar),
              _ActionIcon(icon: Icons.share_outlined, onTap: onTapShare),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _ActionIcon({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          size: 24,
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}
