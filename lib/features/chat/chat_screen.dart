import 'package:flutter/material.dart';
import 'package:gemico/l10n/app_localizations.dart';
import 'package:gemico/core/gemini/gemini_localized_errors.dart';
import 'package:gemico/core/theme/app_colors.dart';
import 'package:gemico/core/ui/app_loading.dart';
import 'package:gemico/features/chat/chat_controller.dart';
import 'package:gemico/features/chat/chat_session.dart';
import 'package:gemico/features/chat/mode_selector.dart';
import 'package:gemico/features/chat/widgets/chat_drawer.dart';
import 'package:gemico/features/chat/widgets/chat_empty_state.dart';
import 'package:gemico/features/chat/widgets/chat_input_bar.dart';
import 'package:gemico/features/chat/widgets/chat_message_bubble.dart';
import 'package:gemico/features/chat/widgets/chat_typing_indicator.dart';
import 'package:gemico/features/settings/settings_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatController _chatController;
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _didScheduleLoad = false;

  @override
  void initState() {
    super.initState();
    _chatController = ChatController()
      ..addListener(() {
        if (!mounted) return;
        setState(() {});
        _scrollToBottom();
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didScheduleLoad) return;
    _didScheduleLoad = true;
    final l10n = AppLocalizations.of(context)!;
    _chatController.ensureLoaded(newChatTitle: l10n.newChatSessionTitle);
  }

  @override
  void dispose() {
    _chatController.dispose();
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _inputController.text;
    final l10n = AppLocalizations.of(context)!;
    _inputController.clear();
    await _chatController.sendMessage(
      text,
      GeminiLocalizedErrors.from(l10n),
    );
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _confirmDelete(BuildContext context, ChatSession session) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.dialogBg,
        title: Text(
          l10n.deleteChatTitle,
          style: const TextStyle(color: AppColors.onSurface),
        ),
        content: Text(
          session.title,
          style: const TextStyle(color: AppColors.secondaryFg),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await _chatController.deleteChat(
        id: session.id,
        newChatTitle: l10n.newChatSessionTitle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (!_chatController.ready) {
      return const Scaffold(
        body: AppLoadingIndicator(),
      );
    }

    final messages = _chatController.messages;

    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: MediaQuery.sizeOf(context).width * 0.5,
      drawer: ChatDrawer(
        controller: _chatController,
        historyTitle: l10n.historyTitle,
        newChatLabel: l10n.newChat,
        settingsLabel: l10n.settings,
        onNewChat: () => _chatController.newChat(
              newChatTitle: l10n.newChatSessionTitle,
            ),
        onOpenSettings: () async {
          await Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (context) => SettingsScreen(
                onDeleteAllChats: () => _chatController.deleteAllChats(
                  newChatTitle: l10n.newChatSessionTitle,
                ),
              ),
            ),
          );
          if (!context.mounted) return;
          _chatController.clearErrorBanner();
        },
        onConfirmDelete: _confirmDelete,
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
            tooltip: l10n.chatHistoryTooltip,
          ),
        ),
        title: Image.asset(
          'icon/shorted_ico.png',
          height: 30,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: l10n.newChatTooltip,
            onPressed: _chatController.isLoading
                ? null
                : () {
                    _chatController.newChat(
                      newChatTitle: l10n.newChatSessionTitle,
                    );
                  },
            icon: const Icon(Icons.edit_note_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: ModeSelector(
                currentMode: _chatController.mode,
                onChanged: _chatController.setMode,
                defaultLabel: l10n.modeDefault,
                plus18Label: l10n.modePlus18,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? ChatEmptyState(message: l10n.askGeminiPlaceholder)
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    itemCount: messages.length +
                        (_chatController.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (_chatController.isLoading &&
                          index == messages.length) {
                        return const ChatTypingIndicator();
                      }
                      final message = messages[index];
                      return ChatMessageBubble(message: message);
                    },
                  ),
          ),
          if (_chatController.errorText != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
              child: SelectableText(
                _chatController.errorText!,
                style: const TextStyle(
                  color: AppColors.error,
                  fontSize: 12.5,
                ),
              ),
            ),
          ChatInputBar(
            controller: _inputController,
            hintText: l10n.messageHint,
            enabled: !_chatController.isLoading,
            onSubmit: _submit,
          ),
        ],
      ),
    );
  }
}
