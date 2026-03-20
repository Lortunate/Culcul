import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme get light => _buildTextTheme(
    AppColors.textPrimary,
    AppColors.textSecondary,
    AppColors.textTertiary,
  );

  static TextTheme get dark => _buildTextTheme(
    AppColors.darkTextPrimary,
    AppColors.darkTextSecondary,
    AppColors.darkTextTertiary,
  );

  static TextTheme _buildTextTheme(
    Color primary,
    Color secondary,
    Color tertiary,
  ) {
    return TextTheme(
      displayLarge: TextStyle(
        color: primary,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: primary,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: primary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        color: primary,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: primary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: primary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: primary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: primary,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(color: primary, fontSize: 15),
      bodyMedium: TextStyle(color: secondary, fontSize: 14),
      bodySmall: TextStyle(color: tertiary, fontSize: 12),
      labelLarge: TextStyle(
        color: primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(color: secondary, fontSize: 12),
      labelSmall: TextStyle(color: tertiary, fontSize: 10),
    );
  }
}
