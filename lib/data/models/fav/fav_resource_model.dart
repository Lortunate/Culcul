import 'package:freezed_annotation/freezed_annotation.dart';

part 'fav_resource_model.freezed.dart';
part 'fav_resource_model.g.dart';

@freezed
abstract class FavResourceModel with _$FavResourceModel {
  const factory FavResourceModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'type') required int type,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'cover') required String cover,
    @JsonKey(name: 'intro') required String intro,
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'duration') required int duration,
    @JsonKey(name: 'upper') required FavUpperModel upper,
    @JsonKey(name: 'attr') required int attr,
    @JsonKey(name: 'cnt_info') required FavCntInfoModel cntInfo,
    @JsonKey(name: 'link') required String link,
    @JsonKey(name: 'ctime') required int ctime,
    @JsonKey(name: 'pubtime') required int pubtime,
    @JsonKey(name: 'fav_time') required int favTime,
    @JsonKey(name: 'bv_id') String? bvId,
    @JsonKey(name: 'bvid') String? bvid,
  }) = _FavResourceModel;

  factory FavResourceModel.fromJson(Map<String, dynamic> json) =>
      _$FavResourceModelFromJson(json);
}

@freezed
abstract class FavUpperModel with _$FavUpperModel {
  const factory FavUpperModel({
    @JsonKey(name: 'mid') required int mid,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'face') required String face,
  }) = _FavUpperModel;

  factory FavUpperModel.fromJson(Map<String, dynamic> json) =>
      _$FavUpperModelFromJson(json);
}

@freezed
abstract class FavCntInfoModel with _$FavCntInfoModel {
  const factory FavCntInfoModel({
    @JsonKey(name: 'collect') required int collect,
    @JsonKey(name: 'play') required int play,
    @JsonKey(name: 'danmaku') required int danmaku,
  }) = _FavCntInfoModel;

  factory FavCntInfoModel.fromJson(Map<String, dynamic> json) =>
      _$FavCntInfoModelFromJson(json);
}

@freezed
abstract class FavResourceListResponse with _$FavResourceListResponse {
  const factory FavResourceListResponse({
    @JsonKey(name: 'info') required FavFolderInfoModel info,
    @JsonKey(name: 'medias') List<FavResourceModel>? medias,
    @JsonKey(name: 'has_more') required bool hasMore,
  }) = _FavResourceListResponse;

  factory FavResourceListResponse.fromJson(Map<String, dynamic> json) =>
      _$FavResourceListResponseFromJson(json);
}

@freezed
abstract class FavFolderInfoModel with _$FavFolderInfoModel {
  const factory FavFolderInfoModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'fid') required int fid,
    @JsonKey(name: 'mid') required int mid,
    @JsonKey(name: 'attr') required int attr,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'cover') required String cover,
    @JsonKey(name: 'upper') required FavUpperModel upper,
    @JsonKey(name: 'media_count') required int mediaCount,
  }) = _FavFolderInfoModel;

  factory FavFolderInfoModel.fromJson(Map<String, dynamic> json) =>
      _$FavFolderInfoModelFromJson(json);
}
