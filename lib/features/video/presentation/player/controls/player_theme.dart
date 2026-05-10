import 'package:flutter/material.dart';

class PlayerTheme {
  static const double topBarHeight = 48.0;
  static const double bottomBarHeight = 82.0;
  static const double iconSize = 24.0;
  static const double smallIconSize = 20.0;
  static const double centerPlayBtnSize = 48.0;

  static const double horizontalPadding = 12.0;
  static const double elementSpacing = 16.0;

  static TextStyle timeStyle(ColorScheme colorScheme) => TextStyle(
    color: colorScheme.onPrimary,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    fontFeatures: const [FontFeature.tabularFigures()],
    shadows: [
      Shadow(
        offset: const Offset(0, 1),
        blurRadius: 2,
        color: colorScheme.shadow.withValues(alpha: 0.45),
      ),
    ],
  );

  static TextStyle titleStyle(ColorScheme colorScheme) => TextStyle(
    color: colorScheme.onPrimary,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    shadows: [
      Shadow(
        offset: const Offset(0, 1),
        blurRadius: 2,
        color: colorScheme.shadow.withValues(alpha: 0.45),
      ),
    ],
  );

  static TextStyle subtitleStyle(ColorScheme colorScheme) => TextStyle(
    color: colorScheme.onPrimary,
    fontSize: 16,
    height: 1.2,
    fontWeight: FontWeight.w600,
    shadows: [
      Shadow(offset: const Offset(0, 1), blurRadius: 2, color: colorScheme.shadow),
      Shadow(offset: const Offset(0, -1), blurRadius: 2, color: colorScheme.shadow),
      Shadow(offset: const Offset(1, 0), blurRadius: 2, color: colorScheme.shadow),
      Shadow(offset: const Offset(-1, 0), blurRadius: 2, color: colorScheme.shadow),
    ],
  );

  static SliderThemeData sliderTheme(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliderThemeData(
      trackHeight: 3,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7, elevation: 2),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
      activeTrackColor: colorScheme.primary,
      inactiveTrackColor: colorScheme.onSurface.withValues(alpha: 0.2),
      secondaryActiveTrackColor: colorScheme.onSurface.withValues(alpha: 0.35),
      thumbColor: colorScheme.primary,
      overlayColor: colorScheme.primary.withValues(alpha: 0.2),
      trackShape: const RectangularSliderTrackShape(),
      activeTickMarkColor: Colors.transparent,
      inactiveTickMarkColor: Colors.transparent,
    );
  }

  static SliderThemeData progressSliderTheme(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return sliderTheme(context).copyWith(
      activeTrackColor: colorScheme.primary,
      inactiveTrackColor: colorScheme.onSurface.withValues(alpha: 0.2),
      secondaryActiveTrackColor: colorScheme.onSurface.withValues(alpha: 0.35),
      thumbColor: colorScheme.primary,
      overlayColor: colorScheme.primary.withValues(alpha: 0.18),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
      showValueIndicator: ShowValueIndicator.onDrag,
      valueIndicatorTextStyle: TextStyle(color: colorScheme.onPrimary, fontSize: 12),
      valueIndicatorColor: colorScheme.primary,
    );
  }

  static const LinearGradient topGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(0, 0, 0, 0.87),
      Color.fromRGBO(0, 0, 0, 0.54),
      Colors.transparent,
    ],
    stops: [0.0, 0.4, 1.0],
  );

  static const LinearGradient bottomGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color.fromRGBO(0, 0, 0, 0.87),
      Color.fromRGBO(0, 0, 0, 0.54),
      Colors.transparent,
    ],
    stops: [0.0, 0.4, 1.0],
  );

  static ButtonStyle textButtonStyle(ColorScheme colorScheme) => TextButton.styleFrom(
    foregroundColor: colorScheme.onPrimary,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    minimumSize: Size.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    textStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      shadows: [
        Shadow(
          offset: const Offset(0, 1),
          blurRadius: 2,
          color: colorScheme.shadow.withValues(alpha: 0.45),
        ),
      ],
    ),
  );

  static Color overlayBackgroundColor(ColorScheme colorScheme) =>
      colorScheme.scrim.withValues(alpha: 0.6);
}
