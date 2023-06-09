import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:midas_coffee_app/main.dart';
import 'package:midas_coffee_app/styles/styles.dart';
import 'package:midas_coffee_app/ui/common/app_scroll_behavior.dart';
import 'package:sized_context/sized_context.dart';

class CoffeeAppScaffold extends StatelessWidget {
  const CoffeeAppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;
  static AppStyle get style => _style;
  static AppStyle _style = AppStyle();

  @override
  Widget build(BuildContext context) {
    // Listen to the device size, and update AppStyle when it changes
    MediaQuery.of(context);
    appLogic.handleAppSizeChanged();
    // Set default timing for animations in the app
    Animate.defaultDuration = _style.times.fast;
    // Create a style object that will be passed down the widget tree
    _style = AppStyle(screenSize: context.sizePx);
    return KeyedSubtree(
      key: ValueKey($styles.scale),
      child: Theme(
        data: $styles.colors.toThemeData(),
        // Provide a default texts style to allow Hero's to render text properly
        child: DefaultTextStyle(
          style: $styles.text.body,
          // Use a custom scroll behavior across entire app
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: child,
          ),
        ),
      ),
    );
  }
}
