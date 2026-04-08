import 'package:flutter/foundation.dart';
import 'package:gemico/core/gemini/gemini_localized_errors.dart';
import 'package:gemico/core/gemini/gemini_service.dart';
import 'package:gemico/core/prompts/mode_prompts.dart';
import 'package:gemico/core/settings/user_settings_store.dart';
import 'package:gemico/core/storage/chat_history_store.dart';
import 'package:gemico/features/chat/chat_message.dart';
import 'package:gemico/features/chat/chat_mode.dart';
import 'package:gemico/features/chat/chat_session.dart';

class ChatController extends ChangeNotifier {
  ChatController({
    GeminiService? geminiService,
    ChatHistoryStore? store,
    UserSettingsStore? userSettingsStore,
  })  : _geminiService = geminiService ?? GeminiService(),
        _store = store ?? ChatHistoryStore(),
        _userSettingsStore = userSettingsStore ?? UserSettingsStore();

  final GeminiService _geminiService;
  final ChatHistoryStore _store;
  final UserSettingsStore _userSettingsStore;

  List<ChatSession> sessions = [];
  String? currentSessionId;
  bool isLoading = false;
  String? errorText;
  bool _loaded = false;

  bool get ready => _loaded;

  ChatSession? get _current {
    final id = currentSessionId;
    if (id == null) return null;
    try {
      return sessions.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  List<ChatMessage> get messages => List.unmodifiable(_current?.messages ?? []);

  ChatMode get mode => _current?.mode ?? ChatMode.defaultMode;

  Future<void> ensureLoaded({required String newChatTitle}) async {
    if (_loaded) return;
    final loaded = await _store.load();
    if (loaded.isEmpty) {
      final id = _newId();
      sessions = [
        ChatSession.empty(
          id: id,
          title: newChatTitle,
          mode: ChatMode.defaultMode,
        ),
      ];
      currentSessionId = id;
    } else {
      sessions = List<ChatSession>.from(loaded)
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      currentSessionId = sessions.first.id;
    }
    _loaded = true;
    notifyListeners();
  }

  String _newId() => DateTime.now().microsecondsSinceEpoch.toString();

  void setMode(ChatMode nextMode) {
    final c = _current;
    if (c == null || c.mode == nextMode) return;
    c.mode = nextMode;
    _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    await _store.save(sessions);
  }

  Future<void> newChat({required String newChatTitle}) async {
    final c = _current;
    final id = _newId();
    final session = ChatSession.empty(
      id: id,
      title: newChatTitle,
      mode: c?.mode ?? ChatMode.defaultMode,
    );
    sessions.insert(0, session);
    currentSessionId = id;
    errorText = null;
    await _persist();
    notifyListeners();
  }

  void selectChat(String id) {
    if (currentSessionId == id) return;
    currentSessionId = id;
    errorText = null;
    notifyListeners();
  }

  /// Clears the red error line under the chat (e.g. after saving API key in Settings).
  void clearErrorBanner() {
    if (errorText == null) return;
    errorText = null;
    notifyListeners();
  }

  Future<void> deleteChat({
    required String id,
    required String newChatTitle,
  }) async {
    sessions.removeWhere((s) => s.id == id);
    if (sessions.isEmpty) {
      final newId = _newId();
      sessions = [
        ChatSession.empty(
          id: newId,
          title: newChatTitle,
          mode: ChatMode.defaultMode,
        ),
      ];
      currentSessionId = newId;
    } else if (currentSessionId == id) {
      currentSessionId = sessions.first.id;
    }
    await _persist();
    notifyListeners();
  }

  Future<void> deleteAllChats({required String newChatTitle}) async {
    final newId = _newId();
    sessions = [
      ChatSession.empty(
        id: newId,
        title: newChatTitle,
        mode: ChatMode.defaultMode,
      ),
    ];
    currentSessionId = newId;
    errorText = null;
    await _persist();
    notifyListeners();
  }

  Future<void> sendMessage(
    String rawText,
    GeminiLocalizedErrors errors,
  ) async {
    final input = rawText.trim();
    if (input.isEmpty || isLoading) return;
    final c = _current;
    if (c == null) return;

    errorText = null;
    isLoading = true;
    final firstUserTurn = !c.messages.any((m) => m.isUser);
    c.messages.add(ChatMessage(text: input, isUser: true));
    if (firstUserTurn) {
      c.title = input.length > 40 ? '${input.substring(0, 40)}…' : input;
    }
    c.updatedAt = DateTime.now();
    await _persist();
    notifyListeners();

    try {
      final history = c.messages.take(c.messages.length - 1).toList();
      final plus18Raw = await _userSettingsStore.getPlus18PromptRaw();
      final apiKey = await _userSettingsStore.getGeminiApiKey();
      final modelId = await _userSettingsStore.getGeminiModelId();
      final systemInstruction = ModePrompts.systemInstructionFor(
        c.mode,
        storedPlus18Raw: plus18Raw,
      );
      if (apiKey == null || apiKey.isEmpty) {
        errorText = errors.apiKeyMissing;
        c.messages.add(
          ChatMessage(
            text: '${errors.errorPrefix} ${errors.apiKeyMissing}',
            isUser: false,
          ),
        );
      } else {
        final reply = await _geminiService.generateReply(
          modelId: modelId,
          messages: history,
          userInput: input,
          mode: c.mode,
          systemInstruction: systemInstruction,
          apiKey: apiKey,
          strings: errors,
        );
        c.messages.add(ChatMessage(text: reply, isUser: false));
      }
    } catch (error) {
      errorText = error.toString().replaceFirst('Exception: ', '');
      c.messages.add(
        ChatMessage(
          text: '${errors.errorPrefix} $errorText',
          isUser: false,
        ),
      );
    } finally {
      isLoading = false;
      c.updatedAt = DateTime.now();
      sessions.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      await _persist();
      notifyListeners();
    }
  }
}
