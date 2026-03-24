import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:culcul/features/video/controllers/video_detail_state.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoActionsRow extends ConsumerWidget {
  final VideoDetailState state;
  final VideoDetailController notifier;

  const VideoActionsRow({super.key, required this.state, required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = state.videoDetail!;
    final t = Translations.of(context);
    final authState = ref.watch(authProvider);

    void checkLoginAndAction(VoidCallback action) {
      if (!authState.isLoggedIn) {
        context.push('/login');
        return;
      }
      action();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ActionButton(
            icon: Icons.thumb_up_outlined,
            label: d.stat.like.formatNumber,
            onTap: () => checkLoginAndAction(() => notifier.toggleLike()),
          ),
          ActionButton(
            icon: Icons.thumb_down_outlined,
            label: t.actions.unlike,
            onTap: () => checkLoginAndAction(() => notifier.toggleDislike()),
          ),
          ActionButton(
            icon: Icons.monetization_on_outlined,
            label: d.stat.coin.formatNumber,
            onTap: () => checkLoginAndAction(() => notifier.sendCoin()),
          ),
          ActionButton(
            icon: Icons.star_outline_rounded,
            label: d.stat.favorite.formatNumber,
            onTap: () => checkLoginAndAction(() => notifier.toggleFavorite()),
          ),
          ActionButton(
            icon: Icons.share_outlined,
            label: d.stat.share.formatNumber,
            onTap: () => notifier.share(), // Share usually doesn't require login
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
