import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_danmu_info_model.freezed.dart';
part 'live_danmu_info_model.g.dart';

@freezed
sealed class LiveDanmuInfoModel with _$LiveDanmuInfoModel {
  const factory LiveDanmuInfoModel({
    required String token,
    @JsonKey(name: 'host_list') required List<LiveDanmuHost> hostList,
  }) = _LiveDanmuInfoModel;

  factory LiveDanmuInfoModel.fromJson(Map<String, dynamic> json) =>
      _$LiveDanmuInfoModelFromJson(json);
}

@freezed
sealed class LiveDanmuHost with _$LiveDanmuHost {
  const factory LiveDanmuHost({
    required String host,
    @JsonKey(name: 'wss_port') required int wssPort,
    @JsonKey(name: 'ws_port') required int wsPort,
  }) = _LiveDanmuHost;

  factory LiveDanmuHost.fromJson(Map<String, dynamic> json) =>
      _$LiveDanmuHostFromJson(json);
}

