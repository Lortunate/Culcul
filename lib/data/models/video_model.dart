import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_model.freezed.dart';
part 'video_model.g.dart';

@freezed
abstract class VideoModel with _$VideoModel {
  const factory VideoModel({
    required String bvid,
    required String title,
    required String pic,
    required Owner owner,
    required Stat stat,
    required int duration,
    @JsonKey(name: 'pubdate') required int pubDate,
    @Default('') String desc,
    @RcmdReasonConverter() @Default('') String rcmd_reason,
  }) = _VideoModel;

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
}

@freezed
abstract class Owner with _$Owner {
  const factory Owner({
    required int mid,
    required String name,
    @Default('') String face,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}

@freezed
abstract class Stat with _$Stat {
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
