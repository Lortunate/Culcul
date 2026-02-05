import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_danmaku_model.freezed.dart';
part 'live_danmaku_model.g.dart';

@freezed
abstract class LiveDanmakuConfigModel with _$LiveDanmakuConfigModel {
  const factory LiveDanmakuConfigModel({
    required List<LiveDanmakuGroup> group,
    required List<LiveDanmakuMode> mode,
  }) = _LiveDanmakuConfigModel;

  factory LiveDanmakuConfigModel.fromJson(Map<String, dynamic> json) =>
      _$LiveDanmakuConfigModelFromJson(json);
}

@freezed
abstract class LiveDanmakuGroup with _$LiveDanmakuGroup {
  const factory LiveDanmakuGroup({
    required String name,
    required int sort,
    required List<LiveDanmakuColor> color,
  }) = _LiveDanmakuGroup;

  factory LiveDanmakuGroup.fromJson(Map<String, dynamic> json) =>
      _$LiveDanmakuGroupFromJson(json);
}

@freezed
abstract class LiveDanmakuColor with _$LiveDanmakuColor {
  const factory LiveDanmakuColor({
    required String name,
    required String color,
    @JsonKey(name: 'color_hex') required String colorHex,
    required int status,
    required int weight,
    @JsonKey(name: 'color_id') required int colorId,
    required int origin,
  }) = _LiveDanmakuColor;

  factory LiveDanmakuColor.fromJson(Map<String, dynamic> json) =>
      _$LiveDanmakuColorFromJson(json);
}

@freezed
abstract class LiveDanmakuMode with _$LiveDanmakuMode {
  const factory LiveDanmakuMode({
    required String name,
    required int mode,
    required String type,
    required int status,
  }) = _LiveDanmakuMode;

  factory LiveDanmakuMode.fromJson(Map<String, dynamic> json) =>
      _$LiveDanmakuModeFromJson(json);
}
