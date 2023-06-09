import 'package:flutter/widgets.dart';
import 'package:midas_coffee_app/logic/data/wonder_type.dart';
import 'package:midas_coffee_app/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:midas_coffee_app/ui/wonder_illustrations/type/great_wall_illustration.dart';

/// Convenience class for showing an illustration when all you have is the type.
class WonderIllustration extends StatelessWidget {
  const WonderIllustration(this.type, {Key? key, required this.config})
      : super(key: key);
  final WonderIllustrationConfig config;
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case WonderType.chichenItza:
        // return ChichenItzaIllustration(config: config);
        return const Text('hello');
      case WonderType.christRedeemer:
        // return ChristRedeemerIllustration(config: config);
        return const Text('hello');
      case WonderType.colosseum:
        // return ColosseumIllustration(config: config);
        return const Text('hello');
      case WonderType.greatWall:
        return GreatWallIllustration(config: config);
      case WonderType.machuPicchu:
        // return MachuPicchuIllustration(config: config);
        return const Text('hello');
      case WonderType.petra:
        // return PetraIllustration(config: config);
        return const Text('hello');
      case WonderType.pyramidsGiza:
        // return PyramidsGizaIllustration(config: config);
        return const Text('hello');
      case WonderType.tajMahal:
        // return TajMahalIllustration(config: config);
        return const Text('hello');
    }
  }
}
