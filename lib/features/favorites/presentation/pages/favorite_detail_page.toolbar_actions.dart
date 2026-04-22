part of 'favorite_detail_page.dart';

List<Widget> _buildFavoriteDetailAppBarActions({
  required BuildContext context,
  required WidgetRef ref,
  required int mediaId,
  required bool isMine,
  required ValueNotifier<bool> isSelectionMode,
  required ValueNotifier<Set<int>> selectedItems,
}) {
  final t = Translations.of(context);
  final colorScheme = Theme.of(context).colorScheme;
  final commands = FavoriteDetailPageCommands(
    presentEditDialog: () async {
      final createdFolders = ref.read(favCreatedFoldersProvider).asData?.value;
      final folder = createdFolders?.where((f) => f.id == mediaId).firstOrNull;
      return showDialog<FavFolderFormData>(
        context: context,
        builder: (_) => FavFolderDialog(folder: folder),
      );
    },
    presentDeleteConfirmation: () async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(t.favorites.delete_folder),
          content: Text(t.favorites.delete_folder_confirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(t.common.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(t.common.delete),
            ),
          ],
        ),
      );
      return confirmed == true;
    },
    editFolder: (data) async {
      final result = await ref
          .read(favoriteFolderCommandWorkflowProvider)
          .editFolder(
            mediaId: mediaId,
            title: data.title,
            intro: data.intro,
            privacy: data.privacy,
          );
      return result.errorOrNull?.message;
    },
    deleteFolder: () async {
      final result = await ref
          .read(favoriteFolderCommandWorkflowProvider)
          .deleteFolder(mediaId: mediaId);
      return result.errorOrNull?.message;
    },
    deleteResources: (resourceIds) async {
      final result = await ref
          .read(favoriteFolderCommandWorkflowProvider)
          .deleteResources(mediaId: mediaId, resourceIds: resourceIds);
      return result.errorOrNull?.message;
    },
    invalidateCreatedFolders: () => ref.invalidate(favCreatedFoldersProvider),
    exitPage: () {
      if (context.mounted) {
        context.pop();
      }
    },
    showError: (message) => _showFavoriteActionErrorSnackBar(context, message),
  );

  if (isSelectionMode.value) {
    return [
      TextButton(
        onPressed: selectedItems.value.isEmpty
            ? null
            : () async {
                final success = await commands.handleDeleteResources(selectedItems.value);
                if (success) {
                  isSelectionMode.value = false;
                  selectedItems.value = {};
                  ref.invalidate(favFolderResourcesProvider(mediaId));
                  return;
                }
              },
        child: Text(t.favorites.delete_with_count(count: selectedItems.value.length)),
      ),
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          isSelectionMode.value = false;
          selectedItems.value = {};
        },
      ),
    ];
  }

  if (!isMine) {
    return const [];
  }

  return [
    PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'edit') {
          await commands.handleEditFolder();
          return;
        }
        if (value == 'manage') {
          isSelectionMode.value = true;
          return;
        }
        if (value == 'delete') {
          await commands.handleDeleteFolder();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'edit', child: Text(t.favorites.edit_info)),
        PopupMenuItem(value: 'manage', child: Text(t.favorites.manage_resources)),
        PopupMenuItem(
          value: 'delete',
          child: Text(
            t.favorites.delete_folder,
            style: TextStyle(color: colorScheme.error),
          ),
        ),
      ],
    ),
  ];
}

void _showFavoriteActionErrorSnackBar(BuildContext context, String message) {
  if (!context.mounted) return;
  final t = Translations.of(context);
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text('${t.common.error}: $message')));
}
