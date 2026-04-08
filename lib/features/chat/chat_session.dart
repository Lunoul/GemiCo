import 'package:gemico/features/chat/chat_message.dart';
import 'package:gemico/features/chat/chat_mode.dart';

class ChatSession {
  ChatSession({
    required this.id,
    required this.title,
    required this.mode,
    required this.messages,
    required this.updatedAt,
  });

  final String id;
  String title;
  ChatMode mode;
  List<ChatMessage> messages;
  DateTime updatedAt;

  factory ChatSession.empty({
    required String id,
    required String title,
    ChatMode mode = ChatMode.defaultMode,
  }) {
    return ChatSession(
      id: id,
      title: title,
      mode: mode,
      messages: [],
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'mode': mode.storageValue,
      'messages': messages.map((m) => m.toJson()).toList(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    final rawMessages = json['messages'] as List<dynamic>?;
    return ChatSession(
      id: json['id'] as String,
      title: json['title'] as String? ?? 'Chat',
      mode: chatModeFromStorage(json['mode'] as String?),
      messages: rawMessages == null
          ? []
          : rawMessages
              .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
              .toList(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}
