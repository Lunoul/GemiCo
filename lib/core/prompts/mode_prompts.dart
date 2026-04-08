import 'package:gemico/core/settings/user_settings_store.dart';
import 'package:gemico/features/chat/chat_mode.dart';

class ModePrompts {
  static String systemInstructionFor(
    ChatMode mode, {
    required String? storedPlus18Raw,
  }) {
    switch (mode) {
      case ChatMode.defaultMode:
        return '''
You are GemiCo assistant.
Rules:
- Be concise, useful, and friendly.
- Provide practical, direct answers.
- Keep responses clean and structured when helpful.
''';
      case ChatMode.plus18:
        final t = (storedPlus18Raw ?? '').trim();
        return t.isEmpty
            ? UserSettingsStore.defaultPlus18Prompt
            : t;
    }
  }
}
