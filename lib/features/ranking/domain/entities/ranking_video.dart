import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_video.freezed.dart';

@freezed
sealed class RankingVideo with _$RankingVideo {
  const factory RankingVideo({
    required String bvid,
    required String title,
    required String coverUrl,
    required int duration,
    required String ownerName,
    required int viewCount,
    required int danmakuCount,
  }) = _RankingVideo;
}
