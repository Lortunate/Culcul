import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_lifecycle_sync_view_model.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_category_grid.dart';
import 'package:culcul/features/notification/presentation/widgets/private_session_list.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/users/guest_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                NotificationCategoryGrid(
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
