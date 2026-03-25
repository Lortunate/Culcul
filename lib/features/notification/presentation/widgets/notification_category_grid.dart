import 'package:culcul/features/notification/controllers/unread_count_controller.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationCategoryGrid extends ConsumerWidget {
  const NotificationCategoryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadCountProvider);
    final semanticColors = context.semanticColors;

    return unreadCount.when(
      data: (data) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryItem(
              context,
              icon: Icons.reply,
              label: '回复我的',
              count: data.reply,
              color: semanticColors.success,
              onTap: () => context.push('/notification/reply'),
            ),
            _buildCategoryItem(
              context,
              icon: Icons.alternate_email,
              label: '@我',
              count: data.at,
              color: semanticColors.warning,
              onTap: () => context.push('/notification/at'),
            ),
            _buildCategoryItem(
              context,
              icon: Icons.thumb_up_alt_outlined,
              label: '收到的赞',
              count: data.like,
              color: Theme.of(context).colorScheme.primary,
              onTap: () => context.push('/notification/like'),
            ),
            _buildCategoryItem(
              context,
              icon: Icons.notifications_none,
              label: '系统通知',
              count: data.sysMsg,
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
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                    top: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        borderRadius: BorderRadius.circular(10),
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
            const SizedBox(height: 8),
            Text(label, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
