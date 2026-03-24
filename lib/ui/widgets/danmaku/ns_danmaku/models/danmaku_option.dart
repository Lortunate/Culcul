import 'package:flutter/material.dart';

class DanmakuOption {
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

  const DanmakuOption({
    this.fontSize = 16,
    this.area = 1.0,
    this.duration = 10,
    this.opacity = 1.0,
    this.hideBottom = false,
    this.hideScroll = false,
    this.hideTop = false,
    this.borderText = true,
    this.strokeWidth = 1.5,
    this.fontWeight = FontWeight.normal,
  });

  DanmakuOption copyWith({
    double? fontSize,
    double? area,
    double? duration,
    double? opacity,
    bool? hideTop,
    bool? hideBottom,
    bool? hideScroll,
    bool? borderText,
    double? strokeWidth,
    FontWeight? fontWeight,
  }) {
    return DanmakuOption(
      area: area ?? this.area,
      fontSize: fontSize ?? this.fontSize,
      duration: duration ?? this.duration,
      opacity: opacity ?? this.opacity,
      hideTop: hideTop ?? this.hideTop,
      hideBottom: hideBottom ?? this.hideBottom,
      hideScroll: hideScroll ?? this.hideScroll,
      borderText: borderText ?? this.borderText,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      fontWeight: fontWeight ?? this.fontWeight,
    );
  }
}
