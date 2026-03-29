import 'package:flutter/material.dart';

class CulculColors {
  CulculColors._();

  static const Color brand = Color(0xFF3E7BFF);
  static const Color brandSecondary = Color(0xFF18B7A4);
  static const Color brandTertiary = Color(0xFFFFB24A);

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFFF4D5A);
  static const Color info = Color(0xFF3B82F6);

  static const Color lightBackground = Color(0xFFF5F7FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceLow = Color(0xFFF9FBFF);
  static const Color lightSurfaceHighest = Color(0xFFF0F4FA);
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF5B6474);
  static const Color lightTextTertiary = Color(0xFF8B95A7);
  static const Color lightBorder = Color(0xFFE3E8F0);
  static const Color lightDivider = Color(0xFFDDE4EF);

  static const Color darkBackground = Color(0xFF0D1117);
  static const Color darkSurface = Color(0xFF151B24);
  static const Color darkSurfaceLow = Color(0xFF10151D);
  static const Color darkSurfaceHighest = Color(0xFF202836);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFFB2BCCB);
  static const Color darkTextTertiary = Color(0xFF7E8899);
  static const Color darkBorder = Color(0xFF273244);
  static const Color darkDivider = Color(0xFF222B3A);
}

@immutable
class CulculSemanticColors extends ThemeExtension<CulculSemanticColors> {
  final Color success;
  final Color warning;
  final Color info;
  final Color overlayBackground;
  final Color overlayBorder;
  final Color overlayForeground;

  const CulculSemanticColors({
    required this.success,
    required this.warning,
    required this.info,
    required this.overlayBackground,
    required this.overlayBorder,
    required this.overlayForeground,
  });

  static const CulculSemanticColors light = CulculSemanticColors(
    success: CulculColors.success,
    warning: CulculColors.warning,
    info: CulculColors.info,
    overlayBackground: Color(0x80000000),
    overlayBorder: Color(0x1AFFFFFF),
    overlayForeground: Colors.white,
  );

  static const CulculSemanticColors dark = CulculSemanticColors(
    success: CulculColors.success,
    warning: CulculColors.warning,
    info: CulculColors.info,
    overlayBackground: Color(0xA6000000),
    overlayBorder: Color(0x1AFFFFFF),
    overlayForeground: Colors.white,
  );

  @override
  CulculSemanticColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? overlayBackground,
    Color? overlayBorder,
    Color? overlayForeground,
  }) {
    return CulculSemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      overlayBackground: overlayBackground ?? this.overlayBackground,
      overlayBorder: overlayBorder ?? this.overlayBorder,
      overlayForeground: overlayForeground ?? this.overlayForeground,
    );
  }

  @override
  CulculSemanticColors lerp(
    covariant ThemeExtension<CulculSemanticColors>? other,
    double t,
  ) {
    if (other is! CulculSemanticColors) {
      return this;
    }
    return CulculSemanticColors(
      success: Color.lerp(success, other.success, t) ?? success,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      info: Color.lerp(info, other.info, t) ?? info,
      overlayBackground:
          Color.lerp(overlayBackground, other.overlayBackground, t) ?? overlayBackground,
      overlayBorder: Color.lerp(overlayBorder, other.overlayBorder, t) ?? overlayBorder,
      overlayForeground:
          Color.lerp(overlayForeground, other.overlayForeground, t) ?? overlayForeground,
    );
  }
}

extension CulculThemeDataX on ThemeData {
  CulculSemanticColors get semanticColors =>
      extension<CulculSemanticColors>() ??
      (brightness == Brightness.dark
          ? CulculSemanticColors.dark
          : CulculSemanticColors.light);
}

extension CulculBuildContextThemeX on BuildContext {
  CulculSemanticColors get semanticColors => Theme.of(this).semanticColors;
}
