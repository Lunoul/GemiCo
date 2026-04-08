import 'package:flutter/material.dart';
import 'package:gemico/core/theme/app_colors.dart';

/// Settings list row: icon, title, subtitle, chevron.
class SettingsNavTile extends StatelessWidget {
  const SettingsNavTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.mutedIcon),
          title: Text(
            title,
            style: const TextStyle(
              color: AppColors.onSurface,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 13,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: AppColors.muted,
          ),
          onTap: onTap,
        ),
        const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }
}
