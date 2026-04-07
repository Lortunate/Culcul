import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_model_contract.freezed.dart';
part 'video_model_contract.g.dart';

typedef Owner = VideoOwner;
typedef Stat = VideoStat;

@freezed
sealed class VideoModel with _$VideoModel {
  const factory VideoModel({
    required String bvid,
    required String title,
    required String pic,
    required VideoOwner owner,
    required VideoStat stat,
    required int duration,
    @JsonKey(name: 'pubdate') required int pubDate,
    @Default('') String desc,
    @JsonKey(name: 'rcmd_reason') @RcmdReasonConverter() @Default('') String rcmdReason,
  }) = _VideoModel;

  factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);
}

@freezed
sealed class VideoOwner with _$VideoOwner {
  const factory VideoOwner({
    required int mid,
    required String name,
    @Default('') String face,
  }) = _VideoOwner;

  factory VideoOwner.fromJson(Map<String, dynamic> json) => _$VideoOwnerFromJson(json);
}

@freezed
sealed class VideoStat with _$VideoStat {
  const factory VideoStat({
    @Default(0) int view,
    @Default(0) int danmaku,
    @Default(0) int reply,
    @Default(0) int like,
    @Default(0) int coin,
    @Default(0) int favorite,
    @Default(0) int share,
  }) = _VideoStat;

  factory VideoStat.fromJson(Map<String, dynamic> json) => _$VideoStatFromJson(json);
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
