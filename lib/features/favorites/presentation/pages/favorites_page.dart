import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/favorites/application/favorites_application_providers.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/presentation/view_models/favorites_view_model.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_folder_dialog.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_folder_list.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/layout/app_tab_bar.dart';
import 'package:culcul/ui/widgets/users/guest_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritesPage extends HookConsumerWidget {
  final VoidCallback onLogin;
  final ValueChanged<FavoriteFolder> onOpenFolder;

  const FavoritesPage({super.key, required this.onLogin, required this.onOpenFolder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final tabController = useTabController(initialLength: 2);
    useListenable(tabController); // Rebuild when tab changes
    final colorScheme = Theme.of(context).colorScheme;
    final isLoggedIn = ref.watch(
      currentUserProvider.select((s) => s?.isLoggedIn ?? false),
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(t.favorites.title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        actions: [_AddFolderAction(isVisible: isLoggedIn && tabController.index == 0)],
        bottom: isLoggedIn
            ? AppTabBar(
                controller: tabController,
                tabs: [t.favorites.created, t.favorites.collected],
              )
            : null,
      ),
      body: isLoggedIn
          ? _FavoritesTabView(controller: tabController, onOpenFolder: onOpenFolder)
          : GuestView(
              title: t.profile.not_logged_in,
              message: t.profile.login_hint,
              onLogin: onLogin,
            ),
    );
  }
}

class _FavoritesTabView extends StatelessWidget {
  final TabController controller;
  final ValueChanged<FavoriteFolder> onOpenFolder;

  const _FavoritesTabView({required this.controller, required this.onOpenFolder});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: [
        FavFolderList(type: FavFolderType.created, onOpenFolder: onOpenFolder),
        FavFolderList(type: FavFolderType.collected, onOpenFolder: onOpenFolder),
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

    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () => _handleCreateFolder(context: context, ref: ref),
    );
  }
}

Future<bool> _handleCreateFolder({
  required BuildContext context,
  required WidgetRef ref,
}) async {
  final t = Translations.of(context);
  final data = await showDialog<FavFolderFormData>(
    context: context,
    builder: (_) => const FavFolderDialog(),
  );
  if (data == null) {
    return false;
  }

  final result = await ref
      .read(favoritesPortProvider)
      .createFolder(title: data.title, intro: data.intro, privacy: data.privacy);
  final error = result.errorOrNull;
  if (error == null) {
    ref.invalidate(favCreatedFoldersProvider);
    return true;
  }

  if (context.mounted) {
    context.showAppFeedback(
      '${t.common.error}: ${error.message}',
      level: AppFeedbackLevel.error,
    );
  }
  return false;
}
