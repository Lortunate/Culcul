import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppComponentTheme {
  AppComponentTheme._();

  static AppBarTheme appBar(bool isDark) {
    final surface = isDark ? AppColors.darkSurface : AppColors.surface;
    final text = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final overlayStyle = isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return AppBarTheme(
      backgroundColor: surface,
      foregroundColor: text,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(color: text, fontSize: 17, fontWeight: FontWeight.w600),
      iconTheme: IconThemeData(color: text, size: 24),
      systemOverlayStyle: overlayStyle.copyWith(statusBarColor: Colors.transparent),
    );
  }

  static TabBarThemeData tabBar(bool isDark) {
    final unselectedLabel = isDark
        ? AppColors.darkTextSecondary
        : AppColors.textSecondary;

    return TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: unselectedLabel,
      labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: AppColors.primary,
      dividerColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(AppColors.primary.withValues(alpha: 0.1)),
    );
  }

  static BottomNavigationBarThemeData bottomNavBar(bool isDark) {
    final surface = isDark ? AppColors.darkSurface : AppColors.surface;
    final unselectedItem = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return BottomNavigationBarThemeData(
      backgroundColor: surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: unselectedItem,
      selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  static CardThemeData card(bool isDark) {
    final color = isDark ? AppColors.darkCard : AppColors.card;
    final border = isDark ? AppColors.darkBorder : AppColors.border;

    return CardThemeData(
      color: color,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: border, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

  static FilledButtonThemeData filledButton() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size.fromHeight(44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  static TextButtonThemeData textButton(bool isDark) {
    final color = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButton(bool isDark) {
    final color = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final border = isDark ? AppColors.darkBorder : AppColors.border;

    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
    );
  }

  static InputDecorationTheme inputDecoration(bool isDark) {
    final fill = isDark ? AppColors.darkCard : AppColors.background;
    final hint = isDark ? AppColors.darkTextTertiary : AppColors.textTertiary;

    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 1),
      ),
      hintStyle: TextStyle(color: hint, fontSize: 14),
    );
  }

  static DividerThemeData divider(bool isDark) {
    final color = isDark ? AppColors.darkDivider : AppColors.divider;

    return DividerThemeData(color: color, thickness: 0.5, space: 1);
  }
}
