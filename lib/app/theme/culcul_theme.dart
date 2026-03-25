import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'culcul_colors.dart';

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

  static TextTheme _buildTextTheme({
    required Color primary,
    required Color secondary,
    required Color tertiary,
  }) {
    return TextTheme(
      displayLarge: TextStyle(
        color: primary,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
      ),
      displayMedium: TextStyle(
        color: primary,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
      ),
      displaySmall: TextStyle(
        color: primary,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineLarge: TextStyle(
        color: primary,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
      ),
      headlineMedium: TextStyle(
        color: primary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
      headlineSmall: TextStyle(color: primary, fontSize: 18, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: primary, fontSize: 17, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(color: primary, fontSize: 15, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(color: primary, fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(color: primary, fontSize: 15, height: 1.45),
      bodyMedium: TextStyle(color: secondary, fontSize: 14, height: 1.45),
      bodySmall: TextStyle(color: tertiary, fontSize: 12, height: 1.35),
      labelLarge: TextStyle(color: primary, fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(color: secondary, fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(color: tertiary, fontSize: 11, fontWeight: FontWeight.w500),
    );
  }

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    final overlayStyle = colorScheme.brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return AppBarTheme(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurface, size: 24),
      systemOverlayStyle: overlayStyle.copyWith(statusBarColor: Colors.transparent),
    );
  }

  static TabBarThemeData _tabBarTheme(ColorScheme colorScheme) {
    return TabBarThemeData(
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: colorScheme.primary,
      dividerColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(colorScheme.primary.withValues(alpha: 0.08)),
    );
  }

  static BottomNavigationBarThemeData _bottomNavigationBarTheme(ColorScheme colorScheme) {
    return BottomNavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  static CardThemeData _cardTheme(ColorScheme colorScheme) {
    return CardThemeData(
      color: colorScheme.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

  static FilledButtonThemeData _filledButtonTheme(ColorScheme colorScheme) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.onSurfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.onSurface,
        side: BorderSide(color: colorScheme.outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    final radius = BorderRadius.circular(16);

    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerLow,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: colorScheme.primary, width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: colorScheme.error, width: 1.2),
      ),
      hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14),
    );
  }

  static DividerThemeData _dividerTheme(ColorScheme colorScheme) {
    return DividerThemeData(color: colorScheme.outlineVariant, thickness: 1, space: 1);
  }
}

class _ThemePalette {
  final Color background;
  final Color surface;
  final Color surfaceLow;
  final Color surfaceHighest;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color border;
  final Color divider;

  const _ThemePalette({
    required this.background,
    required this.surface,
    required this.surfaceLow,
    required this.surfaceHighest,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.border,
    required this.divider,
  });

  static const light = _ThemePalette(
    background: CulculColors.lightBackground,
    surface: CulculColors.lightSurface,
    surfaceLow: CulculColors.lightSurfaceLow,
    surfaceHighest: CulculColors.lightSurfaceHighest,
    textPrimary: CulculColors.lightTextPrimary,
    textSecondary: CulculColors.lightTextSecondary,
    textTertiary: CulculColors.lightTextTertiary,
    border: CulculColors.lightBorder,
    divider: CulculColors.lightDivider,
  );

  static const dark = _ThemePalette(
    background: CulculColors.darkBackground,
    surface: CulculColors.darkSurface,
    surfaceLow: CulculColors.darkSurfaceLow,
    surfaceHighest: CulculColors.darkSurfaceHighest,
    textPrimary: CulculColors.darkTextPrimary,
    textSecondary: CulculColors.darkTextSecondary,
    textTertiary: CulculColors.darkTextTertiary,
    border: CulculColors.darkBorder,
    divider: CulculColors.darkDivider,
  );
}
