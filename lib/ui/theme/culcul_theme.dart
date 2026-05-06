import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'culcul_colors.dart';

part 'culcul_theme_palette.dart';
part 'culcul_theme.components.dart';

class CulculTheme {
  CulculTheme._();

  static ThemeData get light =>
      _buildTheme(brightness: Brightness.light, palette: _ThemePalette.light);

  static ThemeData get dark =>
      _buildTheme(brightness: Brightness.dark, palette: _ThemePalette.dark);

  static ThemeData _buildTheme({
    required Brightness brightness,
    required _ThemePalette palette,
  }) {
    final baseScheme = ColorScheme.fromSeed(
      seedColor: CulculColors.brand,
      brightness: brightness,
    );
    final colorScheme = baseScheme.copyWith(
      primary: CulculColors.brand,
      onPrimary: Colors.white,
      secondary: CulculColors.brandSecondary,
      onSecondary: Colors.white,
      tertiary: CulculColors.brandTertiary,
      onTertiary: Colors.white,
      surface: palette.surface,
      onSurface: palette.textPrimary,
      surfaceContainerLowest: palette.background,
      surfaceContainerLow: palette.surfaceLow,
      surfaceContainer: palette.surface,
      surfaceContainerHigh: palette.surfaceHighest,
      surfaceContainerHighest: palette.surfaceHighest,
      onSurfaceVariant: palette.textSecondary,
      outline: palette.border,
      outlineVariant: palette.divider,
      error: CulculColors.error,
      onError: Colors.white,
      shadow: Colors.black,
      scrim: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      primaryColor: CulculColors.brand,
      scaffoldBackgroundColor: palette.background,
      splashColor: CulculColors.brand.withValues(alpha: 0.10),
      highlightColor: Colors.transparent,
      iconTheme: IconThemeData(color: palette.textPrimary, size: 24),
      textTheme: _buildTextTheme(
        primary: palette.textPrimary,
        secondary: palette.textSecondary,
        tertiary: palette.textTertiary,
      ),
      appBarTheme: _appBarTheme(colorScheme),
      tabBarTheme: _tabBarTheme(colorScheme),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(colorScheme),
      cardTheme: _cardTheme(colorScheme),
      filledButtonTheme: _filledButtonTheme(colorScheme),
      textButtonTheme: _textButtonTheme(colorScheme),
      outlinedButtonTheme: _outlinedButtonTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      dividerTheme: _dividerTheme(colorScheme),
      extensions: [
        brightness == Brightness.dark
            ? CulculSemanticColors.dark
            : CulculSemanticColors.light,
      ],
      visualDensity: VisualDensity.standard,
    );
  }
}
