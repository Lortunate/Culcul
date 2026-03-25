import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_category_grid.dart';
import 'package:culcul/features/notification/presentation/widgets/private_session_list.dart';
import 'package:culcul/ui/widgets/guest_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final t = Translations.of(context);

    return Scaffold(
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

