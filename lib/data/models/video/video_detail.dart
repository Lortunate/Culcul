import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cilixili/data/models/home/video_model.dart';

part 'video_detail.freezed.dart';
part 'video_detail.g.dart';

@freezed
abstract class VideoDetail with _$VideoDetail {
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
    dynamic subtitle,
    @Default([]) List<VideoTag> tag,
  }) = _VideoDetail;

  factory VideoDetail.fromJson(Map<String, dynamic> json) =>
      _$VideoDetailFromJson(json);
}

@freezed
abstract class VideoPage with _$VideoPage {
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

  factory VideoPage.fromJson(Map<String, dynamic> json) =>
      _$VideoPageFromJson(json);
}

@freezed
abstract class VideoDimension with _$VideoDimension {
  const factory VideoDimension({
    @Default(0) int width,
    @Default(0) int height,
    @Default(0) int rotate,
  }) = _VideoDimension;

  factory VideoDimension.fromJson(Map<String, dynamic> json) =>
      _$VideoDimensionFromJson(json);
}

@freezed
abstract class VideoTag with _$VideoTag {
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
  }) = _VideoTag;

  factory VideoTag.fromJson(Map<String, dynamic> json) =>
      _$VideoTagFromJson(json);
}
