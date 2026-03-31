import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:culcul/core/utils/format_utils.dart';

part 'video_model.freezed.dart';

@freezed
sealed class VideoModel with _$VideoModel {
  const VideoModel._();

  const factory VideoModel({
    required String bvid,
    required String title,
    required String pic,
    required Owner owner,
    required Stat stat,
    required int duration,
    required int pubDate,
    @Default('') String desc,
    @Default('') String rcmdReason,
  }) = _VideoModel;

  String get durationString => FormatUtils.formatDuration(duration);
  String get pubDateString => FormatUtils.formatTimeAgo(pubDate);
}

@freezed
sealed class Owner with _$Owner {
  const factory Owner({
    required int mid,
    required String name,
    @Default('') String face,
  }) = _Owner;
}

@freezed
sealed class Stat with _$Stat {
  const Stat._();

  const factory Stat({
    @Default(0) int view,
    @Default(0) int danmaku,
    @Default(0) int reply,
    @Default(0) int like,
    @Default(0) int coin,
    @Default(0) int favorite,
    @Default(0) int share,
  }) = _Stat;

  String get viewString => FormatUtils.formatNumber(view);
  String get danmakuString => FormatUtils.formatNumber(danmaku);
  String get replyString => FormatUtils.formatNumber(reply);
  String get likeString => FormatUtils.formatNumber(like);
  String get coinString => FormatUtils.formatNumber(coin);
  String get favoriteString => FormatUtils.formatNumber(favorite);
  String get shareString => FormatUtils.formatNumber(share);
}
