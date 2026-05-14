import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_lifecycle_sync_view_model.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_category_grid.dart';
import 'package:culcul/features/notification/presentation/widgets/private_session_list.dart';
import 'package:culcul/ui/widgets/users/guest_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

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
          ? const Column(
              children: [
                NotificationCategoryGrid(),
                Divider(height: 1),
                Expanded(child: PrivateSessionList()),
              ],
            )
          : GuestView(
              title: t.profile.not_logged_in,
              message: t.profile.login_hint,
              onLogin: () => const LoginRoute().push(context),
            ),
    );
  }
}
