import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_settings_controller.freezed.dart';
part 'danmaku_settings_controller.g.dart';

@freezed
sealed class DanmakuSettings with _$DanmakuSettings {
  const factory DanmakuSettings({
    @Default(1.0) double opacity,
    @Default(1.0) double fontSizeScale,
    @Default(1.0) double area, // 0.25, 0.5, 0.75, 1.0
    @Default(1.0)
    double speed, // 1.0 is normal, smaller is slower? No, usually multiplier.
    @Default(true) bool showTop,
    @Default(true) bool showBottom,
    @Default(true) bool showScroll,
    @Default(true) bool showColor,
    @Default(true) bool isEnabled,
    @Default(true) bool enableAiMask,
    @Default(0.0) double strokeWidth,
  }) = _DanmakuSettings;
}

@riverpod
class DanmakuSettingsController extends _$DanmakuSettingsController {
  @override
  DanmakuSettings build() {
    return const DanmakuSettings();
  }

  void setOpacity(double value) {
    state = state.copyWith(opacity: value);
  }

  void setFontSizeScale(double value) {
    state = state.copyWith(fontSizeScale: value);
  }

  void setArea(double value) {
    state = state.copyWith(area: value);
  }

  void setSpeed(double value) {
    state = state.copyWith(speed: value);
  }

  void toggleTop() {
    state = state.copyWith(showTop: !state.showTop);
  }

  void toggleBottom() {
    state = state.copyWith(showBottom: !state.showBottom);
  }

  void toggleScroll() {
    state = state.copyWith(showScroll: !state.showScroll);
  }

  void toggleColor() {
    state = state.copyWith(showColor: !state.showColor);
  }

  void toggleEnabled() {
    state = state.copyWith(isEnabled: !state.isEnabled);
  }

  void toggleAiMask() {
    state = state.copyWith(enableAiMask: !state.enableAiMask);
  }

  void setEnabled(bool value) {
    state = state.copyWith(isEnabled: value);
  }
}

