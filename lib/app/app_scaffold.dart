import 'package:flutter/widgets.dart';
import 'package:midas_coffee_app/core/ui/app_scroll_behavior.dart';

class CoffeeAppScaffold extends StatelessWidget {
  final Widget child;
  const CoffeeAppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      child: ScrollConfiguration(behavior: AppScrollBehavior(), child: child),
    );
  }
}
