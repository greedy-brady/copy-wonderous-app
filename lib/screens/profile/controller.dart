import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString hello = 'Hello Hello'.obs;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      hello.value = 'Bye Bye 222';
    });
  }
}
