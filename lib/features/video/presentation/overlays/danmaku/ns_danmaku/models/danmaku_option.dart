import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'danmaku_option.freezed.dart';

@freezed
sealed class DanmakuOption with _$DanmakuOption {
  const factory DanmakuOption({
    @Default(16) double fontSize,
    @Default(1.0) double area,
    @Default(10) double duration,
    @Default(1.0) double opacity,
    @Default(false) bool hideTop,
    @Default(false) bool hideBottom,
    @Default(false) bool hideScroll,
    @Default(true) bool borderText,
    @Default(1.5) double strokeWidth,
    @Default(FontWeight.normal) FontWeight fontWeight,
  }) = _DanmakuOption;
}
