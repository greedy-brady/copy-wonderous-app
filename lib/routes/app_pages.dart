import 'package:get/get.dart';
import 'package:midas_coffee_app/modules/root/index.dart';
import 'package:midas_coffee_app/modules/splash/index.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ROOT,
      page: () => const RootScreen(),
      binding: RootBinding(),
    )
  ];
}
