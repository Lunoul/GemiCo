import 'package:flutter/material.dart';
import 'package:gemico/l10n/app_localizations.dart';
import 'package:gemico/core/gemini/gemini_model_catalog.dart';
import 'package:gemico/core/settings/user_settings_store.dart';
import 'package:gemico/core/theme/app_colors.dart';
import 'package:gemico/core/ui/app_loading.dart';

class GeminiModelScreen extends StatefulWidget {
  const GeminiModelScreen({super.key});

  @override
  State<GeminiModelScreen> createState() => _GeminiModelScreenState();
}

class _GeminiModelScreenState extends State<GeminiModelScreen> {
  final UserSettingsStore _store = UserSettingsStore();
  String _selectedId = GeminiModelCatalog.defaultModelId;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final id = await _store.getGeminiModelId();
    if (!mounted) return;
    setState(() {
      _selectedId = id;
      _loading = false;
    });
  }

  Future<void> _select(String id) async {
    await _store.setGeminiModelId(id);
    if (!mounted) return;
    setState(() => _selectedId = id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: Text(l10n.modelTitle),
      ),
      body: _loading
          ? const AppLoadingIndicator()
          : ListView(
              children: [
                for (final m in GeminiModelCatalog.models)
                  RadioListTile<String>(
                    value: m.id,
                    groupValue: _selectedId,
                    onChanged: (v) {
                      if (v != null) _select(v);
                    },
                    title: Text(
                      m.label,
                      style: const TextStyle(color: AppColors.onSurface),
                    ),
                    subtitle: Text(
                      m.id,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
