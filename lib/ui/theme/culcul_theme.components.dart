part of 'culcul_theme.dart';

TextTheme _buildTextTheme({
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

AppBarTheme _appBarTheme(ColorScheme colorScheme) {
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

TabBarThemeData _tabBarTheme(ColorScheme colorScheme) {
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

BottomNavigationBarThemeData _bottomNavigationBarTheme(ColorScheme colorScheme) {
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

CardThemeData _cardTheme(ColorScheme colorScheme) {
  return CardThemeData(
    color: colorScheme.surface,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
      side: BorderSide(color: colorScheme.outlineVariant),
    ),
    clipBehavior: Clip.antiAlias,
  );
}

FilledButtonThemeData _filledButtonTheme(ColorScheme colorScheme) {
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

TextButtonThemeData _textButtonTheme(ColorScheme colorScheme) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colorScheme.onSurfaceVariant,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme colorScheme) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: colorScheme.onSurface,
      side: BorderSide(color: colorScheme.outline),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
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

DividerThemeData _dividerTheme(ColorScheme colorScheme) {
  return DividerThemeData(color: colorScheme.outlineVariant, thickness: 1, space: 1);
}
