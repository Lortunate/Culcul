import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_folder.freezed.dart';

@freezed
sealed class FavoriteOwner with _$FavoriteOwner {
  const factory FavoriteOwner({
    required int mid,
    required String name,
    required String face,
  }) = _FavoriteOwner;
}

@freezed
sealed class FavoriteFolder with _$FavoriteFolder {
  const FavoriteFolder._();

  const factory FavoriteFolder({
    required int id,
    required int fid,
    required int mid,
    required int attr,
    required String title,
    required int favState,
    required int mediaCount,
    required String? cover,
    required FavoriteOwner? upper,
    required String? intro,
    required int? ctime,
    required int? mtime,
    required int? state,
  }) = _FavoriteFolder;

  bool get isPrivate => attr != 0 && (attr & 1) == 1;
}

@freezed
sealed class FavoriteFolderPage with _$FavoriteFolderPage {
  const factory FavoriteFolderPage({
    required int count,
    required List<FavoriteFolder> folders,
  }) = _FavoriteFolderPage;
}
