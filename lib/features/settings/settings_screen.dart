import 'package:flutter/material.dart';
import 'package:gemico/l10n/app_localizations.dart';
import 'package:gemico/core/locale/locale_scope.dart';
import 'package:gemico/core/theme/app_colors.dart';
import 'package:gemico/features/settings/gemini_api_key_screen.dart';
import 'package:gemico/features/settings/gemini_model_screen.dart';
import 'package:gemico/features/settings/language_screen.dart';
import 'package:gemico/features/settings/plus18_prompt_screen.dart';
import 'package:gemico/features/settings/widgets/settings_nav_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.onDeleteAllChats,
  });

  final Future<void> Function() onDeleteAllChats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeController = LocaleScope.of(context);

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          SettingsNavTile(
            icon: Icons.key_outlined,
            title: l10n.settingsGeminiKey,
            subtitle: l10n.settingsGeminiKeySubtitle,
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (context) => const GeminiApiKeyScreen(),
                ),
              );
            },
          ),
          SettingsNavTile(
            icon: Icons.speaker_notes_outlined,
            title: l10n.settingsPlus18,
            subtitle: l10n.settingsPlus18Subtitle,
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (context) => const Plus18PromptScreen(),
                ),
              );
            },
          ),
          SettingsNavTile(
            icon: Icons.psychology_outlined,
            title: l10n.settingsModel,
            subtitle: l10n.settingsModelSubtitle,
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (context) => const GeminiModelScreen(),
                ),
              );
            },
          ),
          SettingsNavTile(
            icon: Icons.language_outlined,
            title: l10n.settingsLanguage,
            subtitle: l10n.settingsLanguageSubtitle,
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (context) => LanguageScreen(
                    localeController: localeController,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () async {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.dialogBg,
                    title: Text(l10n.deleteAllChatsTitle),
                    content: Text(l10n.deleteAllChatsConfirm),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: Text(l10n.no),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: Text(l10n.yes),
                      ),
                    ],
                  ),
                );
                if (shouldDelete == true) {
                  await onDeleteAllChats();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.deleteAllChatsDone),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: Text(
                l10n.deleteAllChatsAction,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
