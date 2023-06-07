import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:midas_coffee_app/styles/styles.dart';
import 'package:midas_coffee_app/ui/app_scaffold.dart';

import 'logic/app/app_logic.dart';
import 'logic/app/locale_logic.dart';
import 'logic/app/settings_logic.dart';
import 'router.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  registerSingletons();
  runApp(CoffeeApp());

  FlutterNativeSplash.remove();
}

class CoffeeApp extends StatelessWidget with GetItMixin {
  CoffeeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = watchX((SettingsLogic s) => s.currentLocale);
    return MaterialApp.router(
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      routerDelegate: appRouter.routerDelegate,
      // backButtonDispatcher: appRouter.backButtonDispatcher,
      locale: locale == null ? null : Locale(locale),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

void registerSingletons() {
  // Localizations
  GetIt.I.registerLazySingleton<LocaleLogic>(() => LocaleLogic());
  // Settings
  GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
  // Top level app controller
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
}

LocaleLogic get localeLogic => GetIt.I.get<LocaleLogic>();
SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();
AppLogic get appLogic => GetIt.I.get<AppLogic>();

AppLocalizations get $strings => localeLogic.strings;
AppStyle get $styles => CoffeeAppScaffold.style;
