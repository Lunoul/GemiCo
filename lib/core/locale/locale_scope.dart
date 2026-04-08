import 'package:flutter/widgets.dart';
import 'package:gemico/core/locale/locale_controller.dart';

/// Provides [LocaleController] to the widget tree above [MaterialApp].
class LocaleScope extends InheritedWidget {
  const LocaleScope({
    super.key,
    required this.controller,
    required super.child,
  });

  final LocaleController controller;

  static LocaleController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LocaleScope>();
    assert(scope != null, 'LocaleScope not found in context');
    return scope!.controller;
  }

  @override
  bool updateShouldNotify(LocaleScope oldWidget) =>
      oldWidget.controller != controller;
}
