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
  if (isSelectionMode.value) {
    return [
      TextButton(
        onPressed: selectedItems.value.isEmpty
            ? null
            : () async {
                final error = await ref
                    .read(favoriteFolderCommandWorkflowProvider)
                    .deleteResources(mediaId: mediaId, resourceIds: selectedItems.value)
                    .then((result) => result.errorOrNull);
                if (error == null) {
                  isSelectionMode.value = false;
                  selectedItems.value = {};
                  ref.invalidate(favFolderResourcesProvider(mediaId));
                  return;
                }
                if (!context.mounted) return;
                _showFavoriteActionErrorSnackBar(context, error.message);
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
          await _handleEditFolder(context: context, ref: ref, mediaId: mediaId);
          return;
        }
        if (value == 'manage') {
          isSelectionMode.value = true;
          return;
        }
        if (value == 'delete') {
          await _handleDeleteFolder(context: context, ref: ref, mediaId: mediaId);
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

Future<void> _handleEditFolder({
  required BuildContext context,
  required WidgetRef ref,
  required int mediaId,
}) async {
  final createdFolders = ref.read(favCreatedFoldersProvider).asData?.value;
  final folder = createdFolders?.where((f) => f.id == mediaId).firstOrNull;

  final result = await showDialog<FavFolderFormData>(
    context: context,
    builder: (_) => FavFolderDialog(folder: folder),
  );

  if (result == null) return;

  final error = await ref
      .read(favoriteFolderCommandWorkflowProvider)
      .editFolder(
        mediaId: mediaId,
        title: result.title,
        intro: result.intro,
        privacy: result.privacy,
      )
      .then((result) => result.errorOrNull);
  if (error == null) {
    ref.invalidate(favCreatedFoldersProvider);
    return;
  }
  if (!context.mounted) return;
  _showFavoriteActionErrorSnackBar(context, error.message);
}

Future<void> _handleDeleteFolder({
  required BuildContext context,
  required WidgetRef ref,
  required int mediaId,
}) async {
  final t = Translations.of(context);
  final confirm = await showDialog<bool>(
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
  if (confirm != true) return;

  final error = await ref
      .read(favoriteFolderCommandWorkflowProvider)
      .deleteFolder(mediaId: mediaId)
      .then((result) => result.errorOrNull);
  if (error == null) {
    ref.invalidate(favCreatedFoldersProvider);
    if (context.mounted) {
      context.pop();
    }
    return;
  }
  if (!context.mounted) return;
  _showFavoriteActionErrorSnackBar(context, error.message);
}

void _showFavoriteActionErrorSnackBar(BuildContext context, String message) {
  if (!context.mounted) return;
  final t = Translations.of(context);
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text('${t.common.error}: $message')));
}
