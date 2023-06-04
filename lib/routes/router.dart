import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:midas_coffee_app/screens/home/index.dart';

class ScreenPaths {
  static String splash = '/';
  static String intro = '/welcome';
  static String home = '/home';
  static String settings = '/settings';
  // menu
  // game
  // profile
  // order
}

final appRouter = GoRouter(
  initialLocation: ScreenPaths.home,
  routes: [
    GoRoute(
      path: ScreenPaths.home,
      builder: (context, state) => GetBuilder(
        builder: (controller) => const HomeScreen(),
        init: HomeController(),
        dispose: (state) => Get.delete<HomeController>(),
      ),
    )
  ],
);
