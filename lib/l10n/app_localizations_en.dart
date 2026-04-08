// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GemiCO';

  @override
  String get historyTitle => 'History';

  @override
  String get newChat => 'New';

  @override
  String get settings => 'Settings';

  @override
  String get askGeminiPlaceholder => 'Ask Gemini something';

  @override
  String get messageHint => 'Write a message…';

  @override
  String get deleteChatTitle => 'Delete chat?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get errorPrefix => 'Error:';

  @override
  String get settingsGeminiKey => 'Gemini API key';

  @override
  String get settingsGeminiKeySubtitle => 'Required — from Google AI Studio';

  @override
  String get settingsPlus18 => '+18 prompt';

  @override
  String get settingsPlus18Subtitle => 'System prompt for +18 mode';

  @override
  String get settingsModel => 'Gemini model';

  @override
  String get settingsModelSubtitle => 'Model used for requests';

  @override
  String get settingsLanguage => 'Interface language';

  @override
  String get settingsLanguageSubtitle => 'Russian, English, or auto';

  @override
  String get languageTitle => 'Interface language';

  @override
  String get languageOptionAuto => 'Auto (by device)';

  @override
  String get languageOptionRu => 'Russian';

  @override
  String get languageOptionEn => 'English';

  @override
  String get saved => 'Saved';

  @override
  String get saveSuccessSnackbar => 'Successfully saved.';

  @override
  String get save => 'Save';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get plus18Title => '+18 prompt';

  @override
  String get plus18Description =>
      'This text is sent as the system prompt in +18 mode.';

  @override
  String get apiKeyTitle => 'Gemini API key';

  @override
  String get apiKeyDescription =>
      'Create a key in Google AI Studio and paste it here. It is stored only on this device.';

  @override
  String get apiKeyFieldLabel => 'API key';

  @override
  String get apiKeyRequiredSnackbar => 'Enter your Gemini API key to save.';

  @override
  String get apiKeyMissing =>
      'Add your Gemini API key in Settings to send messages.';

  @override
  String get modelTitle => 'Gemini model';

  @override
  String get modeDefault => 'Standart';

  @override
  String get modePlus18 => '+18';

  @override
  String get newChatTooltip => 'New chat';

  @override
  String get chatHistoryTooltip => 'Chat history';

  @override
  String get newChatSessionTitle => 'New chat';

  @override
  String get deleteAllChatsAction => 'Delete all chats';

  @override
  String get deleteAllChatsTitle => 'Delete all chats?';

  @override
  String get deleteAllChatsConfirm =>
      'This will permanently delete the entire chat history. Continue?';

  @override
  String get deleteAllChatsDone => 'All chats deleted.';

  @override
  String get networkErrorDetail =>
      'Could not reach Gemini (DNS or network issue).\n\n• Check internet (browser loads pages).\n• On Android: Settings → Network → Private DNS — off or Automatic.\n• Try another network (mobile data vs Wi‑Fi).\n• If your region blocks Google — use a VPN.\n\nTechnical: hostname generativelanguage.googleapis.com could not be resolved.';

  @override
  String get timeoutError =>
      'Request timed out. Check your connection and try again.';

  @override
  String geminiApiError(int code, String body) {
    return 'Gemini API error $code: $body';
  }

  @override
  String get geminiEmptyResponse => 'Gemini returned an empty response.';

  @override
  String httpError(String message, String detail) {
    return 'Network: $message\n$detail';
  }
}
