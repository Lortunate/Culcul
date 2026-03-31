import 'package:freezed_annotation/freezed_annotation.dart';

import 'subtitle.dart';
import 'video_model.dart';

part 'video_detail.freezed.dart';

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
    required int pubDate,
    required int ctime,
    required String desc,
    required Owner owner,
    required Stat stat,
    @Default(VideoDimension()) VideoDimension dimension,
    @Default([]) List<VideoPage> pages,
    VideoSubtitle? subtitle,
    @Default([]) List<VideoTag> tag,
    ReqUser? reqUser,
  }) = _VideoDetail;
}

@freezed
sealed class ReqUser with _$ReqUser {
  const factory ReqUser({@Default(0) int attention, @Default(0) int guestAttention}) =
      _ReqUser;
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
}

@freezed
sealed class VideoDimension with _$VideoDimension {
  const factory VideoDimension({
    @Default(0) int width,
    @Default(0) int height,
    @Default(0) int rotate,
  }) = _VideoDimension;
}

@freezed
sealed class VideoTag with _$VideoTag {
  const factory VideoTag({
    @Default(0) int tagId,
    @Default('') String tagName,
    @Default('') String cover,
    @Default(0) int likes,
    @Default(0) int hates,
    @Default(0) int liked,
    @Default(0) int hated,
    @Default(0) int attribute,
    @Default(0) int isActivity,
    @Default('') String uri,
    @Default('') String tagType,
    @Default(TagCount()) TagCount count,
    @Default(0) int type,
    @Default(0) int state,
    @Default(0) int ctime,
    @Default(0) int mtime,
    @Default(0) int atime,
    @Default(0) int isAtten,
    @Default(0) int extraAttr,
    @Default('') String musicId,
    @Default('') String content,
    @Default('') String shortContent,
    @Default('') String headCover,
  }) = _VideoTag;
}

@freezed
sealed class TagCount with _$TagCount {
  const factory TagCount({
    @Default(0) int view,
    @Default(0) int use,
    @Default(0) int atten,
  }) = _TagCount;
}
