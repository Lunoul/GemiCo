import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'GemiCO'**
  String get appTitle;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @newChat.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newChat;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @askGeminiPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Ask Gemini something'**
  String get askGeminiPlaceholder;

  /// No description provided for @messageHint.
  ///
  /// In en, this message translates to:
  /// **'Write a message…'**
  String get messageHint;

  /// No description provided for @deleteChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete chat?'**
  String get deleteChatTitle;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @errorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Error:'**
  String get errorPrefix;

  /// No description provided for @settingsGeminiKey.
  ///
  /// In en, this message translates to:
  /// **'Gemini API key'**
  String get settingsGeminiKey;

  /// No description provided for @settingsGeminiKeySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Required — from Google AI Studio'**
  String get settingsGeminiKeySubtitle;

  /// No description provided for @settingsPlus18.
  ///
  /// In en, this message translates to:
  /// **'+18 prompt'**
  String get settingsPlus18;

  /// No description provided for @settingsPlus18Subtitle.
  ///
  /// In en, this message translates to:
  /// **'System prompt for +18 mode'**
  String get settingsPlus18Subtitle;

  /// No description provided for @settingsModel.
  ///
  /// In en, this message translates to:
  /// **'Gemini model'**
  String get settingsModel;

  /// No description provided for @settingsModelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Model used for requests'**
  String get settingsModelSubtitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Interface language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Russian, English, or auto'**
  String get settingsLanguageSubtitle;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Interface language'**
  String get languageTitle;

  /// No description provided for @languageOptionAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto (by device)'**
  String get languageOptionAuto;

  /// No description provided for @languageOptionRu.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageOptionRu;

  /// No description provided for @languageOptionEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageOptionEn;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @saveSuccessSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Successfully saved.'**
  String get saveSuccessSnackbar;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @plus18Title.
  ///
  /// In en, this message translates to:
  /// **'+18 prompt'**
  String get plus18Title;

  /// No description provided for @plus18Description.
  ///
  /// In en, this message translates to:
  /// **'This text is sent as the system prompt in +18 mode.'**
  String get plus18Description;

  /// No description provided for @apiKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Gemini API key'**
  String get apiKeyTitle;

  /// No description provided for @apiKeyDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a key in Google AI Studio and paste it here. It is stored only on this device.'**
  String get apiKeyDescription;

  /// No description provided for @apiKeyFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'API key'**
  String get apiKeyFieldLabel;

  /// No description provided for @apiKeyRequiredSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Enter your Gemini API key to save.'**
  String get apiKeyRequiredSnackbar;

  /// No description provided for @apiKeyMissing.
  ///
  /// In en, this message translates to:
  /// **'Add your Gemini API key in Settings to send messages.'**
  String get apiKeyMissing;

  /// No description provided for @modelTitle.
  ///
  /// In en, this message translates to:
  /// **'Gemini model'**
  String get modelTitle;

  /// No description provided for @modeDefault.
  ///
  /// In en, this message translates to:
  /// **'Standart'**
  String get modeDefault;

  /// No description provided for @modePlus18.
  ///
  /// In en, this message translates to:
  /// **'+18'**
  String get modePlus18;

  /// No description provided for @newChatTooltip.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get newChatTooltip;

  /// No description provided for @chatHistoryTooltip.
  ///
  /// In en, this message translates to:
  /// **'Chat history'**
  String get chatHistoryTooltip;

  /// No description provided for @newChatSessionTitle.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get newChatSessionTitle;

  /// No description provided for @deleteAllChatsAction.
  ///
  /// In en, this message translates to:
  /// **'Delete all chats'**
  String get deleteAllChatsAction;

  /// No description provided for @deleteAllChatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all chats?'**
  String get deleteAllChatsTitle;

  /// No description provided for @deleteAllChatsConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete the entire chat history. Continue?'**
  String get deleteAllChatsConfirm;

  /// No description provided for @deleteAllChatsDone.
  ///
  /// In en, this message translates to:
  /// **'All chats deleted.'**
  String get deleteAllChatsDone;

  /// No description provided for @networkErrorDetail.
  ///
  /// In en, this message translates to:
  /// **'Could not reach Gemini (DNS or network issue).\n\n• Check internet (browser loads pages).\n• On Android: Settings → Network → Private DNS — off or Automatic.\n• Try another network (mobile data vs Wi‑Fi).\n• If your region blocks Google — use a VPN.\n\nTechnical: hostname generativelanguage.googleapis.com could not be resolved.'**
  String get networkErrorDetail;

  /// No description provided for @timeoutError.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Check your connection and try again.'**
  String get timeoutError;

  /// No description provided for @geminiApiError.
  ///
  /// In en, this message translates to:
  /// **'Gemini API error {code}: {body}'**
  String geminiApiError(int code, String body);

  /// No description provided for @geminiEmptyResponse.
  ///
  /// In en, this message translates to:
  /// **'Gemini returned an empty response.'**
  String get geminiEmptyResponse;

  /// No description provided for @httpError.
  ///
  /// In en, this message translates to:
  /// **'Network: {message}\n{detail}'**
  String httpError(String message, String detail);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
