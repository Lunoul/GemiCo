import 'package:flutter/material.dart';
import 'package:gemico/core/theme/app_colors.dart';
import 'package:gemico/features/chat/chat_controller.dart';
import 'package:gemico/features/chat/chat_session.dart';
import 'package:gemico/features/chat/widgets/chat_formatters.dart';

class ChatDrawer extends StatelessWidget {
  const ChatDrawer({
    super.key,
    required this.controller,
    required this.historyTitle,
    required this.newChatLabel,
    required this.settingsLabel,
    required this.onNewChat,
    required this.onOpenSettings,
    required this.onConfirmDelete,
  });

  final ChatController controller;
  final String historyTitle;
  final String newChatLabel;
  final String settingsLabel;
  final Future<void> Function() onNewChat;
  final Future<void> Function() onOpenSettings;
  final Future<void> Function(BuildContext context, ChatSession session)
      onConfirmDelete;

  @override
  Widget build(BuildContext context) {
    final sessions = controller.sessions;
    final currentId = controller.currentSessionId;

    return Drawer(
      backgroundColor: AppColors.drawer,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
              child: Row(
                children: [
                  Text(
                    historyTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryFg,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () async {
                      Navigator.pop(context);
                      await onNewChat();
                    },
                    icon: const Icon(Icons.add, size: 20, color: AppColors.primaryFg),
                    label: Text(newChatLabel),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryFg,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  final session = sessions[index];
                  final selected = session.id == currentId;
                  return ListTile(
                    selected: selected,
                    selectedTileColor: AppColors.selectedTile,
                    title: Text(
                      session.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.onSurface,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      formatChatUpdated(session.updatedAt),
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                      ),
                    ),
                    onTap: () {
                      controller.selectChat(session.id);
                      Navigator.pop(context);
                    },
                    onLongPress: () => onConfirmDelete(context, session),
                  );
                },
              ),
            ),
            const Divider(height: 1, color: AppColors.divider),
            ListTile(
              leading: const Icon(
                Icons.settings_outlined,
                color: AppColors.mutedIcon,
              ),
              title: Text(
                settingsLabel,
                style: const TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                await onOpenSettings();
              },
            ),
          ],
        ),
      ),
    );
  }
}
