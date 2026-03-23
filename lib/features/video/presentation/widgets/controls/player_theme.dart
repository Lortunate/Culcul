import 'package:culcul/app/theme/culcul_colors.dart';
import 'package:flutter/material.dart';

class PlayerTheme {
  // Dimensions
  static const double topBarHeight = 48.0;
  static const double bottomBarHeight = 82.0;
  static const double iconSize = 24.0;
  static const double smallIconSize = 20.0;
  static const double centerPlayBtnSize = 48.0;

  // Spacing
  static const double horizontalPadding = 12.0;
  static const double elementSpacing = 16.0;

  // Text Styles
  static const TextStyle timeStyle = TextStyle(
    color: Colors.white,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    fontFeatures: [FontFeature.tabularFigures()],
    shadows: [
      Shadow(offset: Offset(0, 1), blurRadius: 2, color: Colors.black45),
    ],
  );

  static const TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    shadows: [
      Shadow(offset: Offset(0, 1), blurRadius: 2, color: Colors.black45),
    ],
  );

  static const TextStyle subtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    height: 1.2,
    fontWeight: FontWeight.w600,
    shadows: [
      Shadow(offset: Offset(0, 1), blurRadius: 2, color: Colors.black),
      Shadow(offset: Offset(0, -1), blurRadius: 2, color: Colors.black),
      Shadow(offset: Offset(1, 0), blurRadius: 2, color: Colors.black),
      Shadow(offset: Offset(-1, 0), blurRadius: 2, color: Colors.black),
    ],
  );

  // Slider Theme
  static SliderThemeData get sliderTheme => SliderThemeData(
    trackHeight: 3,
    thumbShape: const RoundSliderThumbShape(
      enabledThumbRadius: 7,
      elevation: 2,
    ),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    activeTrackColor: CulculColors.brand,
    inactiveTrackColor: Colors.white24,
    secondaryActiveTrackColor: Colors.white54,
    thumbColor: Colors.white,
    overlayColor: CulculColors.brand.withValues(alpha: 0.2),
    trackShape: const RectangularSliderTrackShape(),
    activeTickMarkColor: Colors.transparent,
    inactiveTickMarkColor: Colors.transparent,
  );

  // Gradients
  static const LinearGradient topGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.black87, Colors.black54, Colors.transparent],
    stops: [0.0, 0.4, 1.0],
  );

  static const LinearGradient bottomGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Colors.black87, Colors.black54, Colors.transparent],
    stops: [0.0, 0.4, 1.0],
  );

  // Button Styles
  static final ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    minimumSize: Size.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    textStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      shadows: [
        Shadow(offset: Offset(0, 1), blurRadius: 2, color: Colors.black45),
      ],
    ),
  );

  // Colors
  static final Color overlayBackgroundColor = Colors.black.withValues(
    alpha: 0.6,
  );
}
