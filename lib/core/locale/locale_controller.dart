import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gemico/core/locale/app_locale_resolver.dart';
import 'package:gemico/core/settings/user_settings_store.dart';

/// Holds the active app [locale] and persists the user override in [UserSettingsStore].
class LocaleController extends ChangeNotifier {
  LocaleController(this._store);

  final UserSettingsStore _store;

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> load() async {
    final platform = PlatformDispatcher.instance.locale;
    final code = await _store.getLocaleOverrideCode();
    _locale = AppLocaleResolver.resolve(
      platformLocale: platform,
      overrideCode: code,
    );
    notifyListeners();
  }

  Future<void> setOverrideCode(String code) async {
    await _store.setLocaleOverrideCode(code);
    final platform = PlatformDispatcher.instance.locale;
    _locale = AppLocaleResolver.resolve(
      platformLocale: platform,
      overrideCode: code,
    );
    notifyListeners();
  }
}
