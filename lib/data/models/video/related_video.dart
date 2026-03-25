import 'package:culcul/data/models/video/video_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'related_video.freezed.dart';
part 'related_video.g.dart';

@freezed
sealed class RelatedVideo with _$RelatedVideo {
  const factory RelatedVideo({
    required int aid,
    required String bvid,
    @Default(0) int cid,
    required String title,
    required String pic,
    required Owner owner,
    required Stat stat,
    required int duration,
    @JsonKey(name: 'pubdate') required int pubDate,
    @Default('') String desc,
    @JsonKey(name: 'short_link_v2') @Default('') String shortLink,
    @JsonKey(name: 'rcmd_reason') @Default('') String rcmdReason,
  }) = _RelatedVideo;

  factory RelatedVideo.fromJson(Map<String, dynamic> json) =>
      _$RelatedVideoFromJson(json);
}

