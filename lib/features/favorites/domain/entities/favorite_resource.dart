import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:culcul/core/contracts/video_model_contract.dart';

part 'favorite_resource.freezed.dart';

@freezed
sealed class FavoriteResourceStats with _$FavoriteResourceStats {
  const factory FavoriteResourceStats({
    required int collect,
    required int play,
    required int danmaku,
  }) = _FavoriteResourceStats;
}

@freezed
sealed class FavoriteResource with _$FavoriteResource {
  const FavoriteResource._();

  const factory FavoriteResource({
    required int id,
    required int type,
    required String title,
    required String cover,
    required String intro,
    required int page,
    required int duration,
    required VideoOwner upper,
    required int attr,
    required FavoriteResourceStats stats,
    required String link,
    required int ctime,
    required int pubtime,
    required int favTime,
    required String? bvId,
    required String? bvid,
  }) = _FavoriteResource;

  String? get preferredBvid => bvid ?? bvId;
}

@freezed
sealed class FavoriteFolderInfo with _$FavoriteFolderInfo {
  const factory FavoriteFolderInfo({
    required int id,
    required int fid,
    required int mid,
    required int attr,
    required String title,
    required String cover,
    required VideoOwner upper,
    required int mediaCount,
  }) = _FavoriteFolderInfo;
}

@freezed
sealed class FavoriteResourcePage with _$FavoriteResourcePage {
  const factory FavoriteResourcePage({
    required FavoriteFolderInfo info,
    required List<FavoriteResource> medias,
    required bool hasMore,
  }) = _FavoriteResourcePage;
}
