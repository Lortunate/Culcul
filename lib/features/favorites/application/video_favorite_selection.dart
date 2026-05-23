import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';

class VideoFavoriteFolderDelta {
  const VideoFavoriteFolderDelta({
    required this.addMediaIds,
    required this.delMediaIds,
    required this.isFavorite,
  });

  final Set<int> addMediaIds;
  final Set<int> delMediaIds;
  final bool isFavorite;

  bool get hasChanges => addMediaIds.isNotEmpty || delMediaIds.isNotEmpty;
}

Set<int> selectedVideoFavoriteFolderIds(Iterable<FavoriteFolder> folders) {
  return folders
      .where((folder) => folder.favState == 1)
      .map((folder) => folder.id)
      .toSet();
}

VideoFavoriteFolderDelta buildVideoFavoriteFolderDelta({
  required Set<int> initialIds,
  required Set<int> selectedIds,
}) {
  return VideoFavoriteFolderDelta(
    addMediaIds: selectedIds.difference(initialIds),
    delMediaIds: initialIds.difference(selectedIds),
    isFavorite: selectedIds.isNotEmpty,
  );
}
