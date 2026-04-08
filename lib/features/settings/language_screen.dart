import 'package:flutter/material.dart';
import 'package:gemico/l10n/app_localizations.dart';
import 'package:gemico/core/locale/app_locale_resolver.dart';
import 'package:gemico/core/locale/locale_controller.dart';
import 'package:gemico/core/settings/user_settings_store.dart';
import 'package:gemico/core/theme/app_colors.dart';
import 'package:gemico/core/ui/app_loading.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({
    super.key,
    required this.localeController,
  });

  final LocaleController localeController;

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final UserSettingsStore _store = UserSettingsStore();
  String _code = AppLocaleResolver.overrideAuto;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final code = await _store.getLocaleOverrideCode();
    if (!mounted) return;
    setState(() {
      _code = code;
      _loading = false;
    });
  }

  Future<void> _setCode(String code) async {
    await widget.localeController.setOverrideCode(code);
    if (!mounted) return;
    setState(() => _code = code);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: Text(l10n.languageTitle),
      ),
      body: _loading
          ? const AppLoadingIndicator()
          : ListView(
              children: [
                RadioListTile<String>(
                  value: AppLocaleResolver.overrideAuto,
                  groupValue: _code,
                  onChanged: (v) {
                    if (v != null) _setCode(v);
                  },
                  title: Text(
                    l10n.languageOptionAuto,
                    style: const TextStyle(color: AppColors.onSurface),
                  ),
                ),
                RadioListTile<String>(
                  value: AppLocaleResolver.overrideRu,
                  groupValue: _code,
                  onChanged: (v) {
                    if (v != null) _setCode(v);
                  },
                  title: Text(
                    l10n.languageOptionRu,
                    style: const TextStyle(color: AppColors.onSurface),
                  ),
                ),
                RadioListTile<String>(
                  value: AppLocaleResolver.overrideEn,
                  groupValue: _code,
                  onChanged: (v) {
                    if (v != null) _setCode(v);
                  },
                  title: Text(
                    l10n.languageOptionEn,
                    style: const TextStyle(color: AppColors.onSurface),
                  ),
                ),
              ],
            ),
    );
  }
}
