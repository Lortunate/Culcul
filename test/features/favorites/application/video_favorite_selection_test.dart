import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/favorites/application/video_favorite_selection.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('selectedVideoFavoriteFolderIds reads folders marked by favState', () {
    final ids = selectedVideoFavoriteFolderIds([
      _folder(id: 1, favState: 1),
      _folder(id: 2),
      _folder(id: 3, favState: 1),
    ]);

    expect(ids, {1, 3});
  });

  test('buildVideoFavoriteFolderDelta calculates add and delete ids', () {
    final delta = buildVideoFavoriteFolderDelta(initialIds: {1, 2}, selectedIds: {2, 3});

    expect(delta.addMediaIds, {3});
    expect(delta.delMediaIds, {1});
    expect(delta.isFavorite, isTrue);
    expect(delta.hasChanges, isTrue);
  });
}

FavoriteFolder _folder({required int id, int favState = 0}) {
  return FavoriteFolder(
    id: id,
    fid: id,
    mid: 42,
    attr: 0,
    title: 'Folder $id',
    favState: favState,
    mediaCount: 0,
    cover: null,
    upper: const VideoOwner(mid: 42, name: 'owner'),
    intro: null,
    ctime: null,
    mtime: null,
    state: null,
  );
}
