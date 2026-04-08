import 'package:flutter/material.dart';
import 'package:gemico/core/theme/app_colors.dart';

/// Dark Material 3 theme shared across the app.
ThemeData buildAppTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffold,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryFg,
      secondary: AppColors.secondaryFg,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
    ),
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.45,
        color: AppColors.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        height: 1.4,
        color: Color(0xFFDADADA),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.scaffold,
      foregroundColor: AppColors.primaryFg,
      elevation: 0,
    ),
  );
}
