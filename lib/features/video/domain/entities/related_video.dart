import 'video_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'related_video.freezed.dart';

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
    required int pubDate,
    @Default('') String desc,
    @Default('') String shortLink,
    @Default('') String rcmdReason,
  }) = _RelatedVideo;
}
