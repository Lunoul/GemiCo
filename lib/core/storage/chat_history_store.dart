import 'dart:convert';

import 'package:gemico/features/chat/chat_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHistoryStore {
  static const _key = 'gemico_chat_sessions_v1';

  Future<List<ChatSession>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) {
      return [];
    }
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => ChatSession.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(List<ChatSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(sessions.map((s) => s.toJson()).toList());
    await prefs.setString(_key, encoded);
  }
}
