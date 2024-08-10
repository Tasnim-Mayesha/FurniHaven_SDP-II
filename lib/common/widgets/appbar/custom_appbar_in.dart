import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/notification/notification.dart';
import 'package:sdp2/features/customer/screen/order_history/order_history.dart';
import 'package:sdp2/features/customer/screen/wishlist/wishlist.dart';
import 'package:sdp2/utils/global_colors.dart';

import '../bottomnavbar/starting_controller.dart';

class LanguageSelectorButton extends StatelessWidget {
  final List<Map<String, dynamic>> locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'বাংলা', 'locale': const Locale('bn', 'BD')},
  ];

  LanguageSelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language, color: Colors.white),
      onSelected: (String language) {
        Map<String, dynamic> selectedLocale =
        locale.firstWhere((element) => element['name'] == language);
        updateLanguage(selectedLocale['locale']);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        for (var lang in locale)
          PopupMenuItem<String>(
            value: lang['name'.tr],
            child: Text(lang['name'.tr]),
          ),
      ],
    );
  }

  void updateLanguage(Locale locale) {
    Get.updateLocale(locale);
  }
}

AppBar customAppBarIn(BuildContext context) {
  CustNavController navController = Get.find<CustNavController>();

  return AppBar(
    backgroundColor: GlobalColors.mainColor,
    title: Obx(
          () => Text(
        navController.pageTitles[navController.currentIndex.value],
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    ),
    centerTitle: true,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications, color: Colors.white),
        onPressed: () {
          Get.to(()=> NotificationsPage() );
        },
      ),
      LanguageSelectorButton(),
    ],
  );
}
