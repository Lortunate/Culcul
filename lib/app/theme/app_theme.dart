import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';
import 'app_component_theme.dart';

class AppTheme {
  AppTheme._();


  static ThemeData get light {
    final colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      tertiary: AppColors.tertiary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: Colors.white,
      outline: AppColors.border,
      outlineVariant: AppColors.divider,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: colorScheme,
      splashColor: AppColors.splashColor,
      highlightColor: AppColors.highlightColor,

      textTheme: AppTextTheme.light,

      appBarTheme: AppComponentTheme.appBar(false),
      tabBarTheme: AppComponentTheme.tabBar(false),
      bottomNavigationBarTheme: AppComponentTheme.bottomNavBar(false),
      cardTheme: AppComponentTheme.card(false),

      filledButtonTheme: AppComponentTheme.filledButton(),
      textButtonTheme: AppComponentTheme.textButton(false),
      outlinedButtonTheme: AppComponentTheme.outlinedButton(false),

      inputDecorationTheme: AppComponentTheme.inputDecoration(false),
      dividerTheme: AppComponentTheme.divider(false),
    );
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      tertiary: AppColors.tertiary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      error: AppColors.error,
      onError: Colors.white,
      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkDivider,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: colorScheme,
      splashColor: AppColors.splashColor,
      highlightColor: AppColors.highlightColor,

      textTheme: AppTextTheme.dark,

      appBarTheme: AppComponentTheme.appBar(true),
      tabBarTheme: AppComponentTheme.tabBar(true),
      bottomNavigationBarTheme: AppComponentTheme.bottomNavBar(true),
      cardTheme: AppComponentTheme.card(true),

      filledButtonTheme: AppComponentTheme.filledButton(),
      textButtonTheme: AppComponentTheme.textButton(true),
      outlinedButtonTheme: AppComponentTheme.outlinedButton(true),

      inputDecorationTheme: AppComponentTheme.inputDecoration(true),
      dividerTheme: AppComponentTheme.divider(true),
    );
  }
}
