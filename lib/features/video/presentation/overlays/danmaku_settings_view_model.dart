import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_settings_view_model.g.dart';

final class DanmakuSettings {
  const DanmakuSettings({
    this.opacity = 1.0,
    this.fontSizeScale = 1.0,
    this.area = 1.0, // 0.25, 0.5, 0.75, 1.0
    this.speed = 1.0, // 1.0 is normal, smaller is slower? No, usually multiplier.
    this.showTop = true,
    this.showBottom = true,
    this.showScroll = true,
    this.showColor = true,
    this.isEnabled = true,
    this.enableAiMask = true,
    this.strokeWidth = 0.0,
  });

  final double opacity;
  final double fontSizeScale;
  final double area;
  final double speed;
  final bool showTop;
  final bool showBottom;
  final bool showScroll;
  final bool showColor;
  final bool isEnabled;
  final bool enableAiMask;
  final double strokeWidth;

  DanmakuSettings copyWith({
    double? opacity,
    double? fontSizeScale,
    double? area,
    double? speed,
    bool? showTop,
    bool? showBottom,
    bool? showScroll,
    bool? showColor,
    bool? isEnabled,
    bool? enableAiMask,
    double? strokeWidth,
  }) {
    return DanmakuSettings(
      opacity: opacity ?? this.opacity,
      fontSizeScale: fontSizeScale ?? this.fontSizeScale,
      area: area ?? this.area,
      speed: speed ?? this.speed,
      showTop: showTop ?? this.showTop,
      showBottom: showBottom ?? this.showBottom,
      showScroll: showScroll ?? this.showScroll,
      showColor: showColor ?? this.showColor,
      isEnabled: isEnabled ?? this.isEnabled,
      enableAiMask: enableAiMask ?? this.enableAiMask,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DanmakuSettings &&
            other.opacity == opacity &&
            other.fontSizeScale == fontSizeScale &&
            other.area == area &&
            other.speed == speed &&
            other.showTop == showTop &&
            other.showBottom == showBottom &&
            other.showScroll == showScroll &&
            other.showColor == showColor &&
            other.isEnabled == isEnabled &&
            other.enableAiMask == enableAiMask &&
            other.strokeWidth == strokeWidth;
  }

  @override
  int get hashCode => Object.hash(
    opacity,
    fontSizeScale,
    area,
    speed,
    showTop,
    showBottom,
    showScroll,
    showColor,
    isEnabled,
    enableAiMask,
    strokeWidth,
  );

  @override
  String toString() {
    return 'DanmakuSettings(opacity: $opacity, fontSizeScale: $fontSizeScale, '
        'area: $area, speed: $speed, showTop: $showTop, showBottom: $showBottom, '
        'showScroll: $showScroll, showColor: $showColor, isEnabled: $isEnabled, '
        'enableAiMask: $enableAiMask, strokeWidth: $strokeWidth)';
  }
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
