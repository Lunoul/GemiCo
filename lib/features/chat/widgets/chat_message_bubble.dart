import 'package:flutter/material.dart';
import 'package:gemico/core/theme/app_colors.dart';
import 'package:gemico/features/chat/chat_message.dart';
import 'package:gemico/features/chat/widgets/chat_message_markdown_body.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final align = message.isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color =
        message.isUser ? AppColors.bubbleUser : AppColors.bubbleAssistant;
    final textColor = AppColors.onSurface;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft: Radius.circular(message.isUser ? 18 : 4),
      bottomRight: Radius.circular(message.isUser ? 4 : 18),
    );

    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        constraints: const BoxConstraints(maxWidth: 320),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius,
          border: Border.all(color: AppColors.bubbleBorder),
        ),
        child: ChatMessageMarkdownBody(
          text: message.text,
          textColor: textColor,
        ),
      ),
    );
  }
}
