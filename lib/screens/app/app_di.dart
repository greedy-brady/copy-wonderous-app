import 'package:get/get.dart';
import 'package:midas_coffee_app/services/storage_service.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
  }
}
