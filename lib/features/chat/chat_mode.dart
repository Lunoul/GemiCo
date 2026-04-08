enum ChatMode {
  defaultMode,
  plus18,
}

extension ChatModeLabel on ChatMode {
  String get label {
    switch (this) {
      case ChatMode.defaultMode:
        return 'default';
      case ChatMode.plus18:
        return '+18';
    }
  }

  /// Persisted in [ChatSession] JSON.
  String get storageValue {
    switch (this) {
      case ChatMode.defaultMode:
        return 'default';
      case ChatMode.plus18:
        return 'plus18';
    }
  }
}

ChatMode chatModeFromStorage(String? value) {
  switch (value) {
    case 'plus18':
      return ChatMode.plus18;
    default:
      return ChatMode.defaultMode;
  }
}
