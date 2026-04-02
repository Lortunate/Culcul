import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_model_contract.freezed.dart';

@freezed
sealed class VideoModel with _$VideoModel {
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
  const factory Stat({
    @Default(0) int view,
    @Default(0) int danmaku,
    @Default(0) int reply,
    @Default(0) int like,
    @Default(0) int coin,
    @Default(0) int favorite,
    @Default(0) int share,
  }) = _Stat;
}
