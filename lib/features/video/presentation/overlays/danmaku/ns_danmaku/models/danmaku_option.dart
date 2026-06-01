import 'package:flutter/material.dart';

final class DanmakuOption {
  const DanmakuOption({
    this.fontSize = 16,
    this.area = 1.0,
    this.duration = 10,
    this.opacity = 1.0,
    this.hideTop = false,
    this.hideBottom = false,
    this.hideScroll = false,
    this.borderText = true,
    this.strokeWidth = 1.5,
    this.fontWeight = FontWeight.normal,
  });

  final double fontSize;
  final double area;
  final double duration;
  final double opacity;
  final bool hideTop;
  final bool hideBottom;
  final bool hideScroll;
  final bool borderText;
  final double strokeWidth;
  final FontWeight fontWeight;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DanmakuOption &&
            runtimeType == other.runtimeType &&
            fontSize == other.fontSize &&
            area == other.area &&
            duration == other.duration &&
            opacity == other.opacity &&
            hideTop == other.hideTop &&
            hideBottom == other.hideBottom &&
            hideScroll == other.hideScroll &&
            borderText == other.borderText &&
            strokeWidth == other.strokeWidth &&
            fontWeight == other.fontWeight;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      fontSize,
      area,
      duration,
      opacity,
      hideTop,
      hideBottom,
      hideScroll,
      borderText,
      strokeWidth,
      fontWeight,
    );
  }

  @override
  String toString() {
    return 'DanmakuOption('
        'fontSize: $fontSize, '
        'area: $area, '
        'duration: $duration, '
        'opacity: $opacity, '
        'hideTop: $hideTop, '
        'hideBottom: $hideBottom, '
        'hideScroll: $hideScroll, '
        'borderText: $borderText, '
        'strokeWidth: $strokeWidth, '
        'fontWeight: $fontWeight'
        ')';
  }
}
