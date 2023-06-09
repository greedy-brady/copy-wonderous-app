import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:midas_coffee_app/logic/app/settings_logic.dart';
import 'package:midas_coffee_app/main.dart';
import 'package:midas_coffee_app/ui/common/controls/buttons.dart';

class LocaleSwitcher extends StatelessWidget with GetItMixin {
  LocaleSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = watchX((SettingsLogic s) => s.currentLocale);
    Future<void> handleSwapLocale() async {
      final newLocale = Locale(locale == 'en' ? 'zh' : 'en');
      await settingsLogic.changeLocale(newLocale);
    }

    return AppBtn.from(
        text: $strings.localeSwapButton,
        onPressed: handleSwapLocale,
        padding: EdgeInsets.all($styles.insets.sm));
  }
}
