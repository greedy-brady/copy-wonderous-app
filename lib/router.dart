import 'package:flutter/widgets.dart';
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
  initialLocation: ScreenPaths.home,
  routes: [
    ShellRoute(
        builder: (context, state, navigator) {
          return CoffeeAppScaffold(child: navigator);
        },
        routes: [
          GoRoute(
            path: ScreenPaths.home,
            builder: (context, state) {
              return const Text("hello");
            },
          ),
        ])
  ],
);
