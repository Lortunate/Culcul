import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_model_dto.freezed.dart';
part 'video_model_dto.g.dart';

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
    @JsonKey(name: 'pubdate') required int pubDate,
    @Default('') String desc,
    @JsonKey(name: 'rcmd_reason') @RcmdReasonConverter() @Default('') String rcmdReason,
  }) = _VideoModel;

  factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);
}

@freezed
sealed class Owner with _$Owner {
  const factory Owner({
    required int mid,
    required String name,
    @Default('') String face,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
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

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
}

class RcmdReasonConverter implements JsonConverter<String, dynamic> {
  const RcmdReasonConverter();

  @override
  String fromJson(dynamic json) {
    if (json is Map) {
      return json['content'] as String? ?? '';
    }
    return '';
  }

  @override
  dynamic toJson(String object) => object;
}
