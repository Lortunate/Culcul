import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_danmu_info_model.freezed.dart';

@freezed
sealed class LiveDanmuInfoModel with _$LiveDanmuInfoModel {
  const factory LiveDanmuInfoModel({
    required String token,
    required List<LiveDanmuHost> hostList,
  }) = _LiveDanmuInfoModel;
}

@freezed
sealed class LiveDanmuHost with _$LiveDanmuHost {
  const factory LiveDanmuHost({
    required String host,
    required int wssPort,
    required int wsPort,
  }) = _LiveDanmuHost;
}
