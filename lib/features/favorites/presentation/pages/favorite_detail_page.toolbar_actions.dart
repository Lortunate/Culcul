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
                final success = await _handleDeleteResources(
                  context: context,
                  ref: ref,
                  mediaId: mediaId,
                  resourceIds: selectedItems.value,
                );
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

Future<bool> _handleEditFolder({
  required BuildContext context,
  required WidgetRef ref,
  required int mediaId,
}) async {
  final createdFolders = ref.read(favCreatedFoldersProvider).asData?.value;
  final folder = createdFolders?.where((f) => f.id == mediaId).firstOrNull;
  final data = await showDialog<FavFolderFormData>(
    context: context,
    builder: (_) => FavFolderDialog(folder: folder),
  );
  if (data == null) {
    return false;
  }

  final result = await ref
      .read(favRepositoryProvider)
      .updateFolder(
        mediaId: mediaId,
        title: data.title,
        intro: data.intro,
        privacy: data.privacy,
      );
  final error = result.errorOrNull;
  if (error == null) {
    ref.invalidate(favCreatedFoldersProvider);
    return true;
  }

  if (!context.mounted) {
    return false;
  }
  context.showAppFeedback(
    '${t.common.error}: ${error.message}',
    level: AppFeedbackLevel.error,
  );
  return false;
}

Future<bool> _handleDeleteFolder({
  required BuildContext context,
  required WidgetRef ref,
  required int mediaId,
}) async {
  final t = Translations.of(context);
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
  if (confirmed != true) {
    return false;
  }

  final result = await ref
      .read(favRepositoryProvider)
      .deleteFolder(mediaIds: mediaId.toString());
  final error = result.errorOrNull;
  if (error == null) {
    ref.invalidate(favCreatedFoldersProvider);
    if (context.mounted) {
      context.pop();
    }
    return true;
  }

  if (!context.mounted) {
    return false;
  }
  context.showAppFeedback(
    '${t.common.error}: ${error.message}',
    level: AppFeedbackLevel.error,
  );
  return false;
}

Future<bool> _handleDeleteResources({
  required BuildContext context,
  required WidgetRef ref,
  required int mediaId,
  required Set<int> resourceIds,
}) async {
  final result = await ref
      .read(favRepositoryProvider)
      .deleteResources(mediaId: mediaId, resources: resourceIds.join(','));
  final error = result.errorOrNull;
  if (error == null) {
    return true;
  }

  if (!context.mounted) {
    return false;
  }
  final t = Translations.of(context);
  context.showAppFeedback(
    '${t.common.error}: ${error.message}',
    level: AppFeedbackLevel.error,
  );
  return false;
}
