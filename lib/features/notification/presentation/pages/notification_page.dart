import 'dart:async';

import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/state/notification_lifecycle_sync_view_model.dart';
import 'package:culcul/features/notification/presentation/widgets/private_session_list.dart';
import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_colors.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/users/guest_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _unreadCountProvider = AsyncNotifierProvider<_UnreadCount, NotificationSummary>(
  _UnreadCount.new,
);

class _UnreadCount extends AsyncNotifier<NotificationSummary> {
  StreamSubscription<NotificationSummary>? _subscription;

  @override
  FutureOr<NotificationSummary> build() async {
    final ownerUid = int.tryParse(ref.watch(currentUserProvider)?.uid ?? '');
    if (ownerUid == null) {
      return const NotificationSummary();
    }

    final repository = ref.read(notificationRepositoryProvider);
    final stream = repository.watchUnreadCount(ownerUid: ownerUid);
    _subscription = stream.listen((summary) {
      state = AsyncData(summary);
    });
    ref.onDispose(() => _subscription?.cancel());

    unawaited(repository.syncUnreadCount(ownerUid: ownerUid));
    return stream.first;
  }

  Future<void> refresh() async {
    final ownerUid = int.tryParse(ref.read(currentUserProvider)?.uid ?? '');
    if (ownerUid == null) return;
    await ref
        .read(notificationRepositoryProvider)
        .syncUnreadCount(ownerUid: ownerUid, force: true);
  }
}

class NotificationPage extends ConsumerWidget {
  final VoidCallback onLogin;
  final VoidCallback onOpenReply;
  final VoidCallback onOpenAt;
  final VoidCallback onOpenLike;
  final VoidCallback onOpenSystem;
  final void Function(
    PrivateSession session, {
    required String name,
    required String avatarUrl,
  })
  onOpenChat;

  const NotificationPage({
    super.key,
    required this.onLogin,
    required this.onOpenReply,
    required this.onOpenAt,
    required this.onOpenLike,
    required this.onOpenSystem,
    required this.onOpenChat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(notificationLifecycleSyncProvider);
    final session = ref.watch(currentUserProvider);
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(t.notification.title),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          if (session?.isLoggedIn ?? false)
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                context.showAppFeedback(t.common.coming_soon(tab: t.notification.title));
              },
            ),
        ],
      ),
      body: session?.isLoggedIn ?? false
          ? Column(
              children: [
                _NotificationCategoryGrid(
                  onOpenReply: onOpenReply,
                  onOpenAt: onOpenAt,
                  onOpenLike: onOpenLike,
                  onOpenSystem: onOpenSystem,
                ),
                const Divider(height: 1),
                Expanded(child: PrivateSessionListView(onOpenChat: onOpenChat)),
              ],
            )
          : GuestView(
              title: t.profile.not_logged_in,
              message: t.profile.login_hint,
              onLogin: onLogin,
            ),
    );
  }
}

class _NotificationCategoryGrid extends ConsumerWidget {
  final VoidCallback onOpenReply;
  final VoidCallback onOpenAt;
  final VoidCallback onOpenLike;
  final VoidCallback onOpenSystem;

  const _NotificationCategoryGrid({
    required this.onOpenReply,
    required this.onOpenAt,
    required this.onOpenLike,
    required this.onOpenSystem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(_unreadCountProvider);
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
              onTap: onOpenReply,
            ),
            _buildCategoryItem(
              context,
              icon: Icons.alternate_email,
              label: t.notification.types.at,
              count: data.at,
              color: semanticColors.warning,
              onTap: onOpenAt,
            ),
            _buildCategoryItem(
              context,
              icon: Icons.thumb_up_alt_outlined,
              label: t.notification.types.like,
              count: data.like,
              color: Theme.of(context).colorScheme.primary,
              onTap: onOpenLike,
            ),
            _buildCategoryItem(
              context,
              icon: Icons.notifications_none,
              label: t.notification.types.system,
              count: data.system,
              color: semanticColors.info,
              onTap: onOpenSystem,
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
