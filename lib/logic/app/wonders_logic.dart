import 'package:collection/collection.dart';
import 'package:midas_coffee_app/logic/data/wonder_data.dart';
import 'package:midas_coffee_app/logic/data/wonder_type.dart';
import 'package:midas_coffee_app/logic/data/wonders_data/great_wall_data.dart';

class WondersLogic {
  List<WonderData> all = [GreatWallData()];

  final int timelineStartYear = -3000;
  final int timelineEndYear = 2200;

  WonderData getData(WonderType value) {
    WonderData? result = all.firstWhereOrNull((w) => w.type == value);
    if (result == null) throw ('Could not find data for wonder type $value');
    return result;
  }

  void init() {
    all = [
      GreatWallData(),
      // PetraData(),
      // ColosseumData(),
      // ChichenItzaData(),
      // MachuPicchuData(),
      // TajMahalData(),
      // ChristRedeemerData(),
      // PyramidsGizaData(),
    ];
  }
}
