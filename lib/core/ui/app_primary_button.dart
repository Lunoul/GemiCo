import 'package:flutter/material.dart';
import 'package:gemico/core/theme/app_colors.dart';

/// Primary filled action button used on settings sub-screens.
Widget appPrimaryButton({
  required VoidCallback onPressed,
  required String label,
}) {
  return FilledButton(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.filledButtonBg,
      foregroundColor: AppColors.filledButtonFg,
      padding: const EdgeInsets.symmetric(vertical: 14),
    ),
    child: Text(label),
  );
}
