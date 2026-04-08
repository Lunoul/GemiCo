import 'package:flutter/material.dart';
import 'package:gemico/core/theme/app_colors.dart';

/// Short floating confirmation (e.g. after save); visible on dark theme, auto-dismiss.
void showAppSnackBar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(milliseconds: 1500),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: AppColors.onSurface,
          fontSize: 15,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.surface,
      duration: duration,
    ),
  );
}
