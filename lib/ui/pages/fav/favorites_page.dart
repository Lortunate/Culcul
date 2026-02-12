import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/core/extensions/auth_extension.dart';
import 'package:culcul/providers/fav/fav_provider.dart';
import 'package:culcul/ui/pages/fav/widgets/fav_folder_list.dart';
import 'package:culcul/ui/pages/fav/widgets/fav_folder_dialog.dart';
import 'package:culcul/ui/widgets/app_tab_bar.dart';
import 'package:culcul/ui/widgets/guest_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritesPage extends HookConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final tabController = useTabController(initialLength: 2);
    useListenable(tabController); // Rebuild when tab changes
    final colorScheme = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(t.fav.title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (authState.isLoggedIn && tabController.index == 0)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                final result = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (context) => const FavFolderDialog(),
                );

                if (result != null) {
                  try {
                    await ref
                        .read(favRepositoryProvider)
                        .addFolder(
                          title: result['title']! as String,
                          intro: result['intro'] as String?,
                          privacy: result['privacy'] as int?,
                        );
                    // Refresh the list
                    ref.invalidate(favCreatedFoldersProvider);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add folder: $e')),
                      );
                    }
                  }
                }
              },
            ),
        ],
        bottom: authState.isLoggedIn
            ? AppTabBar(
                controller: tabController,
                tabs: [t.fav.created, t.fav.collected],
              )
            : null,
      ),
      body: authState.isLoggedIn
          ? TabBarView(
              controller: tabController,
              children: const [
                FavFolderList(type: FavFolderType.created),
                FavFolderList(type: FavFolderType.collected),
              ],
            )
          : GuestView(
              title: t.profile.not_logged_in,
              message: t.profile.login_hint,
            ),
    );
  }
}
