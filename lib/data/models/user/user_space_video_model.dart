import 'package:culcul/data/models/video_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_space_video_model.freezed.dart';
part 'user_space_video_model.g.dart';

@freezed
abstract class UserSpaceVideoModel with _$UserSpaceVideoModel {
  const factory UserSpaceVideoModel({
    required int aid,
    required String bvid,
    required String title,
    required String pic,
    required String tname,
    required int duration,
    @JsonKey(name: 'pubdate') required int pubDate,
    required int ctime,
    @Default('') String desc,
    @Default(0) int state,
    @Default(0) int attribute,
    required int tid,
    required Owner owner,
    required Stat stat,
    @Default('') String reason,
    @JsonKey(name: 'inter_video') @Default(false) bool interVideo,
  }) = _UserSpaceVideoModel;

  factory UserSpaceVideoModel.fromJson(Map<String, dynamic> json) =>
      _$UserSpaceVideoModelFromJson(json);
}

@freezed
abstract class UserSpaceVideoListResponse with _$UserSpaceVideoListResponse {
  const factory UserSpaceVideoListResponse({
    required UserSpaceVideoList list,
    required UserSpacePage page,
  }) = _UserSpaceVideoListResponse;

  factory UserSpaceVideoListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSpaceVideoListResponseFromJson(json);
}

@freezed
abstract class UserSpaceVideoList with _$UserSpaceVideoList {
  const factory UserSpaceVideoList({
    @Default([]) List<UserSpaceVideoModel> vlist,
  }) = _UserSpaceVideoList;

  factory UserSpaceVideoList.fromJson(Map<String, dynamic> json) =>
      _$UserSpaceVideoListFromJson(json);
}

@freezed
abstract class UserSpacePage with _$UserSpacePage {
  const factory UserSpacePage({
    @Default(1) int pn,
    @Default(30) int ps,
    @Default(0) int count,
  }) = _UserSpacePage;

  factory UserSpacePage.fromJson(Map<String, dynamic> json) =>
      _$UserSpacePageFromJson(json);
}
