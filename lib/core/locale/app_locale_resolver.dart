import 'package:flutter/material.dart';

/// Resolves app [Locale] from explicit user choice or device locale (auto).
///
/// Auto mode maps many Cyrillic-script language codes to Russian; everything
/// else falls back to English.
abstract final class AppLocaleResolver {
  /// Language codes commonly written in Cyrillic; UI defaults to Russian.
  static const Set<String> cyrillicLanguageCodes = {
    'ru',
    'uk',
    'be',
    'bg',
    'mk',
    'sr',
    'kk',
    'ky',
    'mn',
    'tg',
    'ce',
    'os',
    'ab',
    'ba',
    'kv',
    'cu',
    'rue',
    'sah',
  };

  static const String overrideAuto = 'auto';
  static const String overrideRu = 'ru';
  static const String overrideEn = 'en';

  /// [platformLocale] is typically [PlatformDispatcher.instance.locale].
  /// [overrideCode] is [overrideAuto], [overrideRu], or [overrideEn].
  static Locale resolve({
    required Locale platformLocale,
    required String overrideCode,
  }) {
    switch (overrideCode) {
      case overrideRu:
        return const Locale('ru');
      case overrideEn:
        return const Locale('en');
      default:
        final code = platformLocale.languageCode.toLowerCase();
        if (cyrillicLanguageCodes.contains(code)) {
          return const Locale('ru');
        }
        return const Locale('en');
    }
  }
}
