import 'package:flutter/widgets.dart';
import 'package:midas_coffee_app/ui/common/controls/buttons.dart';

class PopNavigatorUnderlay extends StatelessWidget {
  const PopNavigatorUnderlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: AppBtn.basic(
        onPressed: () => Navigator.of(context).pop(),
        semanticLabel: '',
        child: const SizedBox.expand(),
      ),
    );
  }
}
