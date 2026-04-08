import 'package:flutter/material.dart';
import 'package:gemico/l10n/app_localizations.dart';
import 'package:gemico/core/settings/user_settings_store.dart';
import 'package:gemico/core/theme/app_colors.dart';
import 'package:gemico/core/ui/app_loading.dart';
import 'package:gemico/core/ui/app_primary_button.dart';
import 'package:gemico/core/ui/app_snackbar.dart';
import 'package:gemico/core/ui/app_text_field.dart';

class GeminiApiKeyScreen extends StatefulWidget {
  const GeminiApiKeyScreen({super.key});

  @override
  State<GeminiApiKeyScreen> createState() => _GeminiApiKeyScreenState();
}

class _GeminiApiKeyScreenState extends State<GeminiApiKeyScreen> {
  final _store = UserSettingsStore();
  final _controller = TextEditingController();
  bool _loading = true;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final raw = await _store.getGeminiApiKeyOverrideRaw();
    if (!mounted) return;
    setState(() {
      _controller.text = raw ?? '';
      _loading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    final trimmed = _controller.text.trim();
    if (trimmed.isEmpty) {
      showAppSnackBar(context, l10n.apiKeyRequiredSnackbar);
      return;
    }
    await _store.setGeminiApiKeyOverride(trimmed);
    if (!mounted) return;
    showAppSnackBar(context, l10n.saveSuccessSnackbar);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: Text(l10n.apiKeyTitle),
        actions: [
          TextButton(
            onPressed: _loading ? null : _save,
            child: Text(l10n.save),
          ),
        ],
      ),
      body: _loading
          ? const AppLoadingIndicator()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.apiKeyDescription,
                    style: const TextStyle(
                      color: AppColors.emptyHint,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _controller,
                    obscureText: _obscure,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.visiblePassword,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.onSurface,
                    ),
                    decoration: appOutlinedDecoration(
                      labelText: l10n.apiKeyFieldLabel,
                      radius: 12,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.muted,
                        ),
                        onPressed: () {
                          setState(() => _obscure = !_obscure);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: appPrimaryButton(
                      onPressed: _save,
                      label: l10n.save,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
