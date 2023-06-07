import 'package:go_router/go_router.dart';

import 'ui/app_scaffold.dart';

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
  routes: [
    ShellRoute(
      builder: (context, state, child) => CoffeeAppScaffold(child: child),
    )
  ],
);
