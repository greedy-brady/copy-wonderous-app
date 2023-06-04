import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(controller.hello.value)),
      ),
    );
  }
}
