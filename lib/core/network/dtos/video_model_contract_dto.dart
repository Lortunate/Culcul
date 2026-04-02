import 'package:culcul/core/contracts/video_model_contract.dart' as contract;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_model_contract_dto.freezed.dart';
part 'video_model_contract_dto.g.dart';

@freezed
sealed class VideoModelDto with _$VideoModelDto {
  const factory VideoModelDto({
    required String bvid,
    required String title,
    required String pic,
    required VideoOwnerDto owner,
    required VideoStatDto stat,
    required int duration,
    @JsonKey(name: 'pubdate') required int pubDate,
    @Default('') String desc,
    @JsonKey(name: 'rcmd_reason') @RcmdReasonConverter() @Default('') String rcmdReason,
  }) = _VideoModelDto;

  factory VideoModelDto.fromJson(Map<String, dynamic> json) =>
      _$VideoModelDtoFromJson(json);
}

@freezed
sealed class VideoOwnerDto with _$VideoOwnerDto {
  const factory VideoOwnerDto({
    required int mid,
    required String name,
    @Default('') String face,
  }) = _VideoOwnerDto;

  factory VideoOwnerDto.fromJson(Map<String, dynamic> json) =>
      _$VideoOwnerDtoFromJson(json);
}

@freezed
sealed class VideoStatDto with _$VideoStatDto {
  const factory VideoStatDto({
    @Default(0) int view,
    @Default(0) int danmaku,
    @Default(0) int reply,
    @Default(0) int like,
    @Default(0) int coin,
    @Default(0) int favorite,
    @Default(0) int share,
  }) = _VideoStatDto;

  factory VideoStatDto.fromJson(Map<String, dynamic> json) =>
      _$VideoStatDtoFromJson(json);
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

extension VideoModelDtoMapper on VideoModelDto {
  contract.VideoModel toContract() {
    return contract.VideoModel(
      bvid: bvid,
      title: title,
      pic: pic,
      owner: owner.toContract(),
      stat: stat.toContract(),
      duration: duration,
      pubDate: pubDate,
      desc: desc,
      rcmdReason: rcmdReason,
    );
  }
}

extension VideoOwnerDtoMapper on VideoOwnerDto {
  contract.Owner toContract() {
    return contract.Owner(mid: mid, name: name, face: face);
  }
}

extension VideoStatDtoMapper on VideoStatDto {
  contract.Stat toContract() {
    return contract.Stat(
      view: view,
      danmaku: danmaku,
      reply: reply,
      like: like,
      coin: coin,
      favorite: favorite,
      share: share,
    );
  }
}
