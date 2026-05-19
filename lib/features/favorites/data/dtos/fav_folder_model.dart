import 'package:culcul/features/favorites/data/dtos/fav_resource_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fav_folder_model.freezed.dart';
part 'fav_folder_model.g.dart';

@freezed
sealed class FavFolderModel with _$FavFolderModel {
  const factory FavFolderModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'fid') required int fid,
    @JsonKey(name: 'mid') required int mid,
    @JsonKey(name: 'attr') required int attr,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'fav_state') required int favState,
    @JsonKey(name: 'media_count') required int mediaCount,
    @JsonKey(name: 'cover') String? cover,
    @JsonKey(name: 'upper') FavUpperModel? upper,
    @JsonKey(name: 'intro') String? intro,
    @JsonKey(name: 'ctime') int? ctime,
    @JsonKey(name: 'mtime') int? mtime,
    @JsonKey(name: 'state') int? state,
  }) = _FavFolderModel;

  factory FavFolderModel.fromJson(Map<String, dynamic> json) =>
      _$FavFolderModelFromJson(json);
}

@freezed
sealed class FavFolderListResponse with _$FavFolderListResponse {
  const factory FavFolderListResponse({
    @JsonKey(name: 'count') required int count,
    @JsonKey(name: 'list') List<FavFolderModel>? list,
  }) = _FavFolderListResponse;

  factory FavFolderListResponse.fromJson(Map<String, dynamic> json) =>
      _$FavFolderListResponseFromJson(json);
}
