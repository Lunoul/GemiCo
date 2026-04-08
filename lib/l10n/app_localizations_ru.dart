// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'GemiCO';

  @override
  String get historyTitle => 'История';

  @override
  String get newChat => 'Новый';

  @override
  String get settings => 'Настройки';

  @override
  String get askGeminiPlaceholder => 'Спроси что-нибудь у Gemini';

  @override
  String get messageHint => 'Написать сообщение…';

  @override
  String get deleteChatTitle => 'Удалить чат?';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get errorPrefix => 'Ошибка:';

  @override
  String get settingsGeminiKey => 'Ключ Gemini API';

  @override
  String get settingsGeminiKeySubtitle => 'Обязателен — из Google AI Studio';

  @override
  String get settingsPlus18 => '+18 prompt';

  @override
  String get settingsPlus18Subtitle => 'Системный промпт для режима +18';

  @override
  String get settingsModel => 'Модель Gemini';

  @override
  String get settingsModelSubtitle => 'Модель для запросов';

  @override
  String get settingsLanguage => 'Язык интерфейса';

  @override
  String get settingsLanguageSubtitle => 'Русский, English или авто';

  @override
  String get languageTitle => 'Язык интерфейса';

  @override
  String get languageOptionAuto => 'Авто (по устройству)';

  @override
  String get languageOptionRu => 'Русский';

  @override
  String get languageOptionEn => 'English';

  @override
  String get saved => 'Сохранено';

  @override
  String get saveSuccessSnackbar => 'Успешно сохранено.';

  @override
  String get save => 'Сохранить';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get plus18Title => 'Промпт +18';

  @override
  String get plus18Description =>
      'Этот текст уходит в system prompt при режиме +18.';

  @override
  String get apiKeyTitle => 'Ключ Gemini API';

  @override
  String get apiKeyDescription =>
      'Создайте ключ в Google AI Studio и вставьте сюда. Он хранится только на этом устройстве.';

  @override
  String get apiKeyFieldLabel => 'API ключ';

  @override
  String get apiKeyRequiredSnackbar =>
      'Введите ключ Gemini API, чтобы сохранить.';

  @override
  String get apiKeyMissing =>
      'Добавьте ключ Gemini API в настройках, чтобы отправлять сообщения.';

  @override
  String get modelTitle => 'Модель Gemini';

  @override
  String get modeDefault => 'Стандарт';

  @override
  String get modePlus18 => '+18';

  @override
  String get newChatTooltip => 'Новый чат';

  @override
  String get chatHistoryTooltip => 'История чатов';

  @override
  String get newChatSessionTitle => 'Новый чат';

  @override
  String get deleteAllChatsAction => 'Удалить все чаты';

  @override
  String get deleteAllChatsTitle => 'Удалить все чаты?';

  @override
  String get deleteAllChatsConfirm =>
      'Это действие безвозвратно удалит всю историю чатов. Продолжить?';

  @override
  String get deleteAllChatsDone => 'Все чаты удалены.';

  @override
  String get networkErrorDetail =>
      'Не удаётся достучаться до сервера Gemini (ошибка DNS или сети).\n\n• Убедитесь, что есть интернет (страницы в браузере открываются).\n• На Android: Настройки → Подключения → Частный DNS — отключите или «Автоматически».\n• Попробуйте другую сеть (мобильная сеть вместо Wi‑Fi или наоборот).\n• Если у провайдера или региона ограничен доступ к Google — используйте VPN.\n\nТехнически: не разрешается имя хоста generativelanguage.googleapis.com.';

  @override
  String get timeoutError =>
      'Превышено время ожидания ответа. Проверьте скорость интернета и попробуйте снова.';

  @override
  String geminiApiError(int code, String body) {
    return 'Ошибка Gemini API $code: $body';
  }

  @override
  String get geminiEmptyResponse => 'Gemini вернул пустой ответ.';

  @override
  String httpError(String message, String detail) {
    return 'Сеть: $message\n$detail';
  }
}
