import 'package:freezed_annotation/freezed_annotation.dart';

part 'related_video.freezed.dart';
part 'related_video.g.dart';

@freezed
abstract class RelatedVideo with _$RelatedVideo {
  const factory RelatedVideo({
    required int aid,
    required String bvid,
    @Default(0) int cid,
    required String title,
    required String pic,
    required RelatedOwner owner,
    required RelatedStat stat,
    required int duration,
    @JsonKey(name: 'pubdate') required int pubDate,
    @Default('') String desc,
    @JsonKey(name: 'short_link_v2') @Default('') String shortLink,
    @JsonKey(name: 'rcmd_reason') @Default('') String rcmdReason,
  }) = _RelatedVideo;

  factory RelatedVideo.fromJson(Map<String, dynamic> json) =>
      _$RelatedVideoFromJson(json);
}

@freezed
abstract class RelatedOwner with _$RelatedOwner {
  const factory RelatedOwner({
    required int mid,
    required String name,
    required String face,
  }) = _RelatedOwner;

  factory RelatedOwner.fromJson(Map<String, dynamic> json) =>
      _$RelatedOwnerFromJson(json);
}

@freezed
abstract class RelatedStat with _$RelatedStat {
  const factory RelatedStat({
    @Default(0) int view,
    @Default(0) int danmaku,
    @Default(0) int reply,
    @Default(0) int favorite,
    @Default(0) int coin,
    @Default(0) int share,
    @Default(0) int like,
  }) = _RelatedStat;

  factory RelatedStat.fromJson(Map<String, dynamic> json) =>
      _$RelatedStatFromJson(json);
}
