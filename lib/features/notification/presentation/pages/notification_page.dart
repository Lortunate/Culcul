import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_lifecycle_sync_view_model.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_category_grid.dart';
import 'package:culcul/features/notification/presentation/widgets/private_session_list.dart';
import 'package:culcul/ui/widgets/guest_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(notificationLifecycleSyncProvider);
    final authState = ref.watch(authProvider);
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(t.notification.title),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          if (authState.isLoggedIn)
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                // TODO: Notification settings
              },
            ),
        ],
      ),
      body: authState.isLoggedIn
          ? const Column(
              children: [
                NotificationCategoryGrid(),
                Divider(height: 1),
                Expanded(child: PrivateSessionList()),
              ],
            )
          : GuestView(title: t.profile.not_logged_in, message: t.profile.login_hint),
    );
  }
}
