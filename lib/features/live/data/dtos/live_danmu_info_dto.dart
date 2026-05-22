import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_danmu_info_dto.freezed.dart';
part 'live_danmu_info_dto.g.dart';

@freezed
sealed class LiveDanmuInfoDto with _$LiveDanmuInfoDto {
  const factory LiveDanmuInfoDto({
    required String token,
    @JsonKey(name: 'host_list') @Default([]) List<LiveDanmuHostDto> hostList,
  }) = _LiveDanmuInfoDto;

  factory LiveDanmuInfoDto.fromJson(Map<String, dynamic> json) =>
      _$LiveDanmuInfoDtoFromJson(json);
}

@freezed
sealed class LiveDanmuHostDto with _$LiveDanmuHostDto {
  const factory LiveDanmuHostDto({
    required String host,
    @JsonKey(name: 'wss_port') required int wssPort,
    @JsonKey(name: 'ws_port') required int wsPort,
  }) = _LiveDanmuHostDto;

  factory LiveDanmuHostDto.fromJson(Map<String, dynamic> json) =>
      _$LiveDanmuHostDtoFromJson(json);
}
