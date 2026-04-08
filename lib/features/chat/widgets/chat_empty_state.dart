import 'package:flutter/material.dart';
import 'package:gemico/core/theme/app_colors.dart';

class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: AppColors.emptyHint, fontSize: 15),
      ),
    );
  }
}
