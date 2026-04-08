import 'package:flutter/material.dart';
import 'package:gemico/core/theme/app_colors.dart';

/// Centered indeterminate progress used for first-load and form screens.
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.size = 28, this.strokeWidth = 2.2});

  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: AppColors.loading,
        ),
      ),
    );
  }
}
