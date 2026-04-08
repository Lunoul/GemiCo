import 'package:flutter/material.dart';
import 'package:gemico/core/theme/app_colors.dart';

/// Dark outlined field matching chat and settings inputs.
InputDecoration appOutlinedDecoration({
  String? hintText,
  String? labelText,
  Widget? suffixIcon,
  EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 12,
  ),
  double radius = 16,
}) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: const BorderSide(color: AppColors.borderSubtle),
  );
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    hintStyle: const TextStyle(color: AppColors.hint),
    labelStyle: const TextStyle(color: AppColors.muted),
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: AppColors.inputFill,
    contentPadding: contentPadding,
    border: border,
    enabledBorder: border,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: const BorderSide(color: AppColors.borderStrong),
    ),
  );
}
