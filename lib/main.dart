import 'package:flutter/material.dart';
import 'package:gemico/l10n/app_localizations.dart';
import 'package:gemico/core/locale/locale_controller.dart';
import 'package:gemico/core/locale/locale_scope.dart';
import 'package:gemico/core/settings/user_settings_store.dart';
import 'package:gemico/core/theme/app_theme.dart';
import 'package:gemico/features/chat/chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localeController = LocaleController(UserSettingsStore());
  await localeController.load();
  runApp(GeminiChatApp(localeController: localeController));
}

class GeminiChatApp extends StatelessWidget {
  const GeminiChatApp({super.key, required this.localeController});

  final LocaleController localeController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: localeController,
      builder: (context, _) {
        return LocaleScope(
          controller: localeController,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: localeController.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            title: 'GemiCO',
            theme: buildAppTheme(),
            home: const ChatScreen(),
          ),
        );
      },
    );
  }
}
