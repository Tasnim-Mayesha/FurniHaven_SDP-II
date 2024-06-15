import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/seller/controllers/nav_controller.dart';

AppBar customAppBar(BuildContext context) {
  NavController navController = Get.find<NavController>();

  return AppBar(
    title: Obx(
      () => Text(
        navController.pageTitles[navController.currentIndex.value],
        textAlign: TextAlign.center,
      ),
    ),
    centerTitle: true,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    ),
  );
}
