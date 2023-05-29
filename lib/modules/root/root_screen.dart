import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midas_coffee_app/modules/root/tabs/index.dart';

import 'root_controller.dart';

class RootScreen extends GetView<RootController> {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() => _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return Scaffold(
      body: Center(
        child: _buildContent(controller.currentTab.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildNavigationBarItem(
            "Home",
            MainTabs.home == controller.currentTab.value
                ? "icon_home_activited.svg"
                : "icon_home.svg",
          ),
          _buildNavigationBarItem(
            "Discover",
            MainTabs.discover == controller.currentTab.value
                ? "icon_discover_activited.svg"
                : "icon_discover.svg",
          ),
          _buildNavigationBarItem(
            "Resource",
            "icon_resource.svg",
          ),
          _buildNavigationBarItem(
            "Inbox",
            MainTabs.inbox == controller.currentTab.value
                ? "icon_inbox_activited.svg"
                : "icon_inbox.svg",
          ),
          _buildNavigationBarItem(
            "Me",
            MainTabs.me == controller.currentTab.value
                ? "icon_me_activited.svg"
                : "icon_me.svg",
          )
        ],
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: ColorConstants.black,
        currentIndex: controller.getCurrentIndex(controller.currentTab.value),
        selectedItemColor: ColorConstants.black,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        onTap: (index) => controller.switchTab(index),
      ),
    );
  }

  Widget _buildContent(Tabs tab) {
    switch (tab) {
      case Tabs.home:
        return controller.mainTab;
      case Tabs.game:
        return controller.discoverTab;
      case Tabs.order:
        return controller.resourceTab;
      case Tabs.team:
        return controller.inboxTab;
      case Tabs.me:
        return controller.meTab;
      default:
        return controller.mainTab;
    }
  }
}
