import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midas_coffee_app/routes/app_pages.dart';

import 'app_binding.dart';

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Midas Coffee App by Brady',
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      initialRoute: Routes.SPLASH,
      enableLog: true,
    );
  }
}
