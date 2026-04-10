part of 'culcul_theme.dart';

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
