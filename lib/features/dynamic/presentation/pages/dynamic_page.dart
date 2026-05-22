import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_list_view.dart';
import 'package:culcul/ui/widgets/layout/app_tab_bar.dart';
import 'package:culcul/ui/widgets/users/guest_view.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicPage extends HookConsumerWidget {
  final VoidCallback onLogin;
  final VoidCallback onOpenSearch;
  final VoidCallback onOpenPublish;

  const DynamicPage({
    super.key,
    required this.onLogin,
    required this.onOpenSearch,
    required this.onOpenPublish,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLoggedIn = ref.watch(
      currentUserProvider.select((s) => s?.isLoggedIn ?? false),
    );
    final tabs = [t.moments.tabs.all, t.moments.tabs.video, t.search.tabs.article];
    final tabController = useTabController(initialLength: tabs.length);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        backgroundColor: colorScheme.surface,
        scrolledUnderElevation: 0,
        title: Text(
          t.moments.title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (isLoggedIn)
            IconButton(
              icon: const Icon(Icons.edit_note_rounded, size: 24),
              onPressed: onOpenPublish,
            ),
          IconButton(
            icon: const Icon(Icons.search_rounded, size: 24),
            onPressed: onOpenSearch,
          ),
          const SizedBox(width: 8),
        ],
        bottom: isLoggedIn
            ? AppTabBar(controller: tabController, tabs: tabs, isScrollable: false)
            : null,
      ),
      body: isLoggedIn
          ? TabBarView(
              controller: tabController,
              children: const [
                DynamicListView(type: 'all'),
                DynamicListView(type: 'video'),
                DynamicListView(type: 'article'),
              ],
            )
          : ResponsiveContentContainer(
              maxWidth: 760,
              child: GuestView(
                title: t.profile.not_logged_in,
                message: t.profile.login_hint,
                onLogin: onLogin,
              ),
            ),
    );
  }
}
