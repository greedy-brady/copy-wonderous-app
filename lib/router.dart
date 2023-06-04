import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:midas_coffee_app/screens/home/index.dart';

import 'screens/profile/index.dart';

class ScreenPaths {
  static String splash = '/';
  static String intro = '/welcome';
  static String home = '/home';
  static String profile = '/profile';
  // menu
  // game
  // order
}

final appRouter = GoRouter(
  initialLocation: ScreenPaths.home,
  routes: [
    GoRoute(
      path: ScreenPaths.home,
      builder: (context, state) => GetBuilder(
        builder: (controller) => const HomeView(),
        init: HomeController(),
        dispose: (state) => Get.delete<HomeController>(),
      ),
    ),
    GoRoute(
      path: ScreenPaths.profile,
      builder: (context, state) => GetBuilder(
        builder: (controller) => const ProfileView(),
        init: ProfileController(),
        dispose: (state) => Get.delete<ProfileController>(),
      ),
    )
  ],
);

// TODO @brady makeGetBuilder 공통화