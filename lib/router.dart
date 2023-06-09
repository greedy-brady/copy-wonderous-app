import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:midas_coffee_app/main.dart';

import 'logic/data/wonder_type.dart';
import 'ui/app_scaffold.dart';
import 'ui/screens/home/screen.dart';

class ScreenPaths {
  static String splash = '/';
  static String intro = '/welcome';
  static String home = '/home';
  static String profile = '/profile';
  static String wonderDetails(WonderType type, {int tabIndex = 0}) =>
      '/wonder/${type.name}?t=$tabIndex';
  static String collection(String id) => '/collection?id=$id';
  static String timeline(WonderType? type) =>
      '/timeline?type=${type?.name ?? ''}';
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
          AppRoute(
              ScreenPaths.splash,
              (_) => Container(
                  color: $styles.colors.greyStrong)), // This will be hidden
          AppRoute(ScreenPaths.home, (_) => HomeScreen()),
        ])
  ],
);

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = false})
      : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}
