import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gemico/core/locale/locale_controller.dart';
import 'package:gemico/core/settings/user_settings_store.dart';
import 'package:gemico/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('app renders chat shell', (WidgetTester tester) async {
    final localeController = LocaleController(UserSettingsStore());
    await localeController.load();
    await tester.pumpWidget(GeminiChatApp(localeController: localeController));
    await tester.pumpAndSettle();
    final logoFinder = find.byWidgetPredicate((widget) {
      if (widget is! Image) return false;
      final provider = widget.image;
      return provider is AssetImage &&
          provider.assetName == 'icon/shorted_ico.png';
    });
    expect(logoFinder, findsOneWidget);

    final hasEnPlaceholder =
        find.text('Ask Gemini something').evaluate().isNotEmpty;
    final hasRuPlaceholder =
        find.text('Спроси что-нибудь у Gemini').evaluate().isNotEmpty;
    expect(hasEnPlaceholder || hasRuPlaceholder, isTrue);
  });
}
