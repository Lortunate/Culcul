import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/notification/presentation/view_models/unread_count_view_model.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/ui/theme/culcul_colors.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationCategoryGrid extends ConsumerWidget {
  const NotificationCategoryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadCountProvider);
    final semanticColors = context.semanticColors;
    final t = context.t;

    return unreadCount.when(
      data: (data) => Padding(
        padding: const EdgeInsets.symmetric(vertical: CulculSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryItem(
              context,
              icon: Icons.reply,
              label: t.notification.types.reply,
              count: data.reply,
              color: semanticColors.success,
              onTap: () => const ReplyNotificationRoute().push(context),
            ),
            _buildCategoryItem(
              context,
              icon: Icons.alternate_email,
              label: t.notification.types.at,
              count: data.at,
              color: semanticColors.warning,
              onTap: () => const AtNotificationRoute().push(context),
            ),
            _buildCategoryItem(
              context,
              icon: Icons.thumb_up_alt_outlined,
              label: t.notification.types.like,
              count: data.like,
              color: Theme.of(context).colorScheme.primary,
              onTap: () => const LikeNotificationRoute().push(context),
            ),
            _buildCategoryItem(
              context,
              icon: Icons.notifications_none,
              label: t.notification.types.system,
              count: data.system,
              color: semanticColors.info,
              onTap: () => const SystemNotificationRoute().push(context),
            ),
          ],
        ),
      ),
      error: (_, errorStack) => const SizedBox.shrink(),
      loading: () => const SizedBox(height: 100),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int count,
    required Color color,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CulculRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: CulculSpacing.xs,
          vertical: CulculSpacing.xxs,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                if (count > 0)
                  Positioned(
                    top: -CulculSpacing.xxs,
                    right: -CulculSpacing.xxs,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: CulculSpacing.xxs + CulculSpacing.xxs / 2,
                        vertical: CulculSpacing.xxs / 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        borderRadius: BorderRadius.circular(
                          CulculRadius.sm + CulculSpacing.xxs / 2,
                        ),
                        border: Border.all(color: theme.colorScheme.surface, width: 2),
                      ),
                      child: Text(
                        count > 99 ? '99+' : count.toString(),
                        style: TextStyle(
                          color: theme.colorScheme.onError,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: CulculSpacing.xs),
            Text(label, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
