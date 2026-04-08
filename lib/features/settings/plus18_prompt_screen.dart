import 'package:flutter/material.dart';
import 'package:gemico/l10n/app_localizations.dart';
import 'package:gemico/core/settings/user_settings_store.dart';
import 'package:gemico/core/theme/app_colors.dart';
import 'package:gemico/core/ui/app_loading.dart';
import 'package:gemico/core/ui/app_primary_button.dart';
import 'package:gemico/core/ui/app_snackbar.dart';
import 'package:gemico/core/ui/app_text_field.dart';

class Plus18PromptScreen extends StatefulWidget {
  const Plus18PromptScreen({super.key});

  @override
  State<Plus18PromptScreen> createState() => _Plus18PromptScreenState();
}

class _Plus18PromptScreenState extends State<Plus18PromptScreen> {
  final _store = UserSettingsStore();
  final _controller = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final raw = await _store.getPlus18PromptRaw();
    if (!mounted) return;
    setState(() {
      _controller.text = raw ?? UserSettingsStore.defaultPlus18Prompt;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await _store.setPlus18Prompt(_controller.text);
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    showAppSnackBar(context, l10n.saveSuccessSnackbar);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: Text(l10n.plus18Title),
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
                    l10n.plus18Description,
                    style: const TextStyle(
                      color: AppColors.emptyHint,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: AppColors.onSurface,
                      ),
                      decoration: appOutlinedDecoration(
                        hintText: UserSettingsStore.defaultPlus18Prompt,
                        radius: 12,
                        contentPadding: const EdgeInsets.all(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
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
