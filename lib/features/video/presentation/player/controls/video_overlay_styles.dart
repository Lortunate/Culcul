import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';

class VideoOverlayStyles {
  VideoOverlayStyles._();

  static Color panelBackground(ColorScheme colorScheme) =>
      colorScheme.scrim.withValues(alpha: 0.9);

  static Color panelSurface(ColorScheme colorScheme, {double alpha = 0.58}) =>
      colorScheme.onPrimary.withValues(alpha: alpha * 0.12);

  static Color panelOutline(ColorScheme colorScheme, {double alpha = 0.12}) =>
      colorScheme.onPrimary.withValues(alpha: alpha);

  static Color foreground(ColorScheme colorScheme, {double alpha = 1.0}) =>
      colorScheme.onPrimary.withValues(alpha: alpha);

  static Widget dragHandle(ColorScheme colorScheme) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: CulculSpacing.md),
        width: CulculSpacing.xl + CulculSpacing.xxs,
        height: CulculSpacing.xxs,
        decoration: BoxDecoration(
          color: foreground(colorScheme, alpha: 0.2),
          borderRadius: BorderRadius.circular(CulculRadius.xs / 2),
        ),
      ),
    );
  }

  static TextStyle titleStyle(ColorScheme colorScheme) {
    return TextStyle(
      color: foreground(colorScheme),
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    );
  }

  static TextStyle bodyStyle(ColorScheme colorScheme) {
    return TextStyle(
      color: foreground(colorScheme, alpha: 0.64),
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1.35,
    );
  }
}
