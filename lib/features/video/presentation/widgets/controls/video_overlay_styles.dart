import 'package:flutter/material.dart';

class VideoOverlayStyles {
  VideoOverlayStyles._();

  static Color panelBackground(ColorScheme colorScheme) =>
      colorScheme.scrim.withValues(alpha: 0.9);

  static Color foreground(ColorScheme colorScheme, {double alpha = 1.0}) =>
      colorScheme.onPrimary.withValues(alpha: alpha);

  static Widget dragHandle(ColorScheme colorScheme) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: foreground(colorScheme, alpha: 0.2),
          borderRadius: BorderRadius.circular(2),
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
}
