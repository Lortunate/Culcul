import 'package:freezed_annotation/freezed_annotation.dart';

import 'subtitle_dto.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';

part 'video_detail_dto.freezed.dart';
part 'video_detail_dto.g.dart';

@freezed
sealed class VideoDetail with _$VideoDetail {
  const factory VideoDetail({
    required String bvid,
    required int aid,
    required int videos,
    required int tid,
    required String tname,
    required dynamic copyright,
    required String pic,
    required String title,
    @JsonKey(name: 'pubdate') required int pubDate,
    required int ctime,
    required String desc,
    required Owner owner,
    required Stat stat,
    @Default(VideoDimension()) VideoDimension dimension,
    @Default([]) List<VideoPage> pages,
    VideoSubtitle? subtitle,
    @Default([]) List<VideoTag> tag,
    @JsonKey(name: 'req_user') ReqUser? reqUser,
  }) = _VideoDetail;

  factory VideoDetail.fromJson(Map<String, dynamic> json) => _$VideoDetailFromJson(json);
}

@freezed
sealed class ReqUser with _$ReqUser {
  const factory ReqUser({
    @Default(0) int attention,
    @JsonKey(name: 'guest_attention') @Default(0) int guestAttention,
  }) = _ReqUser;

  factory ReqUser.fromJson(Map<String, dynamic> json) => _$ReqUserFromJson(json);
}

@freezed
sealed class VideoPage with _$VideoPage {
  const factory VideoPage({
    required int cid,
    @Default(0) int page,
    @Default('') String from,
    @Default('') String part,
    @Default(0) int duration,
    @Default('') String vid,
    @Default('') String weblink,
    @Default(VideoDimension()) VideoDimension dimension,
  }) = _VideoPage;

  factory VideoPage.fromJson(Map<String, dynamic> json) => _$VideoPageFromJson(json);
}

@freezed
sealed class VideoDimension with _$VideoDimension {
  const factory VideoDimension({
    @Default(0) int width,
    @Default(0) int height,
    @Default(0) int rotate,
  }) = _VideoDimension;

  factory VideoDimension.fromJson(Map<String, dynamic> json) =>
      _$VideoDimensionFromJson(json);
}

@freezed
sealed class VideoTag with _$VideoTag {
  const factory VideoTag({
    @JsonKey(name: 'tag_id') @Default(0) int tagId,
    @JsonKey(name: 'tag_name') @Default('') String tagName,
    @Default('') String cover,
    @Default(0) int likes,
    @Default(0) int hates,
    @Default(0) int liked,
    @Default(0) int hated,
    @Default(0) int attribute,
    @JsonKey(name: 'is_activity') @Default(0) int isActivity,
    @Default('') String uri,
    @JsonKey(name: 'tag_type') @Default('') String tagType,
    @Default(TagCount()) TagCount count,
    @Default(0) int type,
    @Default(0) int state,
    @Default(0) int ctime,
    @Default(0) int mtime,
    @Default(0) int atime,
    @Default(0) @JsonKey(name: 'is_atten') int isAtten,
    @Default(0) @JsonKey(name: 'extra_attr') int extraAttr,
    @Default('') @JsonKey(name: 'music_id') String musicId,
    @Default('') String content,
    @Default('') @JsonKey(name: 'short_content') String shortContent,
    @Default('') @JsonKey(name: 'head_cover') String headCover,
  }) = _VideoTag;

  factory VideoTag.fromJson(Map<String, dynamic> json) => _$VideoTagFromJson(json);
}

@freezed
sealed class TagCount with _$TagCount {
  const factory TagCount({
    @Default(0) int view,
    @Default(0) int use,
    @Default(0) int atten,
  }) = _TagCount;

  factory TagCount.fromJson(Map<String, dynamic> json) => _$TagCountFromJson(json);
}
