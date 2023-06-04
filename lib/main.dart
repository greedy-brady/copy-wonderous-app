import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

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
    // return const HomeScreen();
    return GetMaterialApp.router(
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      routerDelegate: appRouter.routerDelegate,
      backButtonDispatcher: appRouter.backButtonDispatcher,
    );
  }
}

void registerSingletons() {}
