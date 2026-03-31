import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_danmaku_model.freezed.dart';

@freezed
sealed class LiveDanmakuConfigModel with _$LiveDanmakuConfigModel {
  const factory LiveDanmakuConfigModel({
    required List<LiveDanmakuGroup> group,
    required List<LiveDanmakuMode> mode,
  }) = _LiveDanmakuConfigModel;
}

@freezed
sealed class LiveDanmakuGroup with _$LiveDanmakuGroup {
  const factory LiveDanmakuGroup({
    required String name,
    required int sort,
    required List<LiveDanmakuColor> color,
  }) = _LiveDanmakuGroup;
}

@freezed
sealed class LiveDanmakuColor with _$LiveDanmakuColor {
  const factory LiveDanmakuColor({
    required String name,
    required String color,
    required String colorHex,
    required int status,
    required int weight,
    required int colorId,
    required int origin,
  }) = _LiveDanmakuColor;
}

@freezed
sealed class LiveDanmakuMode with _$LiveDanmakuMode {
  const factory LiveDanmakuMode({
    required String name,
    required int mode,
    required String type,
    required int status,
  }) = _LiveDanmakuMode;
}
