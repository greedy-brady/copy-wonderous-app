import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/router.dart';

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

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
