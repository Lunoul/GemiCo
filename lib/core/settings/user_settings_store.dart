import 'package:gemico/core/gemini/gemini_model_catalog.dart';
import 'package:gemico/core/locale/app_locale_resolver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsStore {
  static const defaultPlus18Prompt = 'Представь что ты чатгпт';
  static const _keyPlus18 = 'plus18_system_prompt';
  static const _keyGeminiApiKey = 'gemini_api_key_override';
  static const _keyGeminiModelId = 'gemini_model_id';
  static const _keyLocaleOverride = 'locale_override';

  /// Raw saved value; `null` if user never saved; may be empty string.
  Future<String?> getPlus18PromptRaw() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_keyPlus18)) return null;
    return prefs.getString(_keyPlus18);
  }

  Future<void> setPlus18Prompt(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPlus18, value);
  }

  /// `null` — user never touched the API key field.
  Future<String?> getGeminiApiKeyOverrideRaw() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_keyGeminiApiKey)) return null;
    return prefs.getString(_keyGeminiApiKey);
  }

  Future<void> setGeminiApiKeyOverride(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyGeminiApiKey, value);
  }

  /// Non-empty trimmed key from settings, or `null` if unset or blank.
  Future<String?> getGeminiApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_keyGeminiApiKey)) return null;
    final trimmed = prefs.getString(_keyGeminiApiKey)?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    return trimmed;
  }

  /// One of [AppLocaleResolver.overrideAuto], [overrideRu], [overrideEn].
  Future<String> getLocaleOverrideCode() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyLocaleOverride);
    if (raw == null || raw.isEmpty) {
      return AppLocaleResolver.overrideAuto;
    }
    if (raw == AppLocaleResolver.overrideRu ||
        raw == AppLocaleResolver.overrideEn ||
        raw == AppLocaleResolver.overrideAuto) {
      return raw;
    }
    return AppLocaleResolver.overrideAuto;
  }

  Future<void> setLocaleOverrideCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    if (code == AppLocaleResolver.overrideAuto) {
      await prefs.remove(_keyLocaleOverride);
      return;
    }
    await prefs.setString(_keyLocaleOverride, code);
  }

  /// Persisted model id for `generateContent`; validated against [GeminiModelCatalog].
  Future<String> getGeminiModelId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_keyGeminiModelId)?.trim();
    if (id == null || id.isEmpty) {
      return GeminiModelCatalog.defaultModelId;
    }
    if (GeminiModelCatalog.byId.containsKey(id)) {
      return id;
    }
    return GeminiModelCatalog.defaultModelId;
  }

  Future<void> setGeminiModelId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyGeminiModelId, id);
  }
}
