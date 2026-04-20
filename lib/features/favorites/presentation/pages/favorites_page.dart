import 'package:culcul/features/favorites/presentation/view_models/favorites_view_model.dart';
import 'package:culcul/features/favorites/presentation/view_models/favorite_folder_action_view_model.dart';
import 'package:culcul/features/favorites/presentation/pages/favorites_page_commands.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_folder_dialog.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_folder_list.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/widgets/app_tab_bar.dart';
import 'package:culcul/shared/widgets/guest_view.dart';
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
        title: Text(t.favorites.title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        actions: [
          _AddFolderAction(isVisible: authState.isLoggedIn && tabController.index == 0),
        ],
        bottom: authState.isLoggedIn
            ? AppTabBar(
                controller: tabController,
                tabs: [t.favorites.created, t.favorites.collected],
              )
            : null,
      ),
      body: authState.isLoggedIn
          ? _FavoritesTabView(controller: tabController)
          : GuestView(title: t.profile.not_logged_in, message: t.profile.login_hint),
    );
  }
}

class _FavoritesTabView extends StatelessWidget {
  final TabController controller;

  const _FavoritesTabView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: const [
        FavFolderList(type: FavFolderType.created),
        FavFolderList(type: FavFolderType.collected),
      ],
    );
  }
}

class _AddFolderAction extends ConsumerWidget {
  final bool isVisible;

  const _AddFolderAction({required this.isVisible});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isVisible) {
      return const SizedBox.shrink();
    }

    final commands = FavoritesPageCommands(
      presentCreateDialog: () {
        return showDialog<FavFolderFormData>(
          context: context,
          builder: (_) => const FavFolderDialog(),
        );
      },
      createFolder: (data) async {
        final error = await ref
            .read(favoriteFolderActionViewModelProvider.notifier)
            .createFolder(title: data.title, intro: data.intro, privacy: data.privacy);
        return error?.message;
      },
      invalidateCreatedFolders: () => ref.invalidate(favCreatedFoldersProvider),
      showError: (message) {
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to add folder: $message')));
      },
    );

    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: commands.handleCreateFolder,
    );
  }
}
