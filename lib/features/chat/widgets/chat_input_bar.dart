import 'package:flutter/material.dart';
import 'package:gemico/core/theme/app_colors.dart';
import 'package:gemico/core/ui/app_text_field.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSubmit,
    required this.enabled,
  });

  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSubmit;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(10, 4, 10, 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 5,
              enabled: enabled,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSubmit(),
              style: const TextStyle(color: AppColors.onSurface),
              decoration: appOutlinedDecoration(
                hintText: hintText,
                radius: 22,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: enabled ? onSubmit : null,
            style: IconButton.styleFrom(
              backgroundColor: AppColors.sendButtonBg,
              foregroundColor: AppColors.sendButtonFg,
            ),
            icon: const Icon(Icons.arrow_upward_rounded),
          ),
        ],
      ),
    );
  }
}
