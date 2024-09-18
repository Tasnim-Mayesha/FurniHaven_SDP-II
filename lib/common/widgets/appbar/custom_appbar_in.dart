import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth for login state check
import 'package:sdp2/features/customer/screen/notification/notification.dart';
import 'package:sdp2/features/personilization/screen/Login/login_option.dart';
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
  NotificationController notificationController = Get.put(NotificationController());
  final User? currentUser = FirebaseAuth.instance.currentUser; // Get the current user from Firebase Auth

  // Initialize listener
  initCouponListener(notificationController);

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

    // Moved Login button to the `actions` list
    actions: [
      // Show "Login" button if the user is not logged in
      if (currentUser == null)
        TextButton(
          onPressed: () {
            Get.to(() => LoginOption()); // Navigate to the login option page
          },
          child:  Text(
            'Login'.tr,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),
          ),
        ),
      Obx(
            () => Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                notificationController.resetNotificationCount();
                Get.to(() => NotificationsPage());
              },
            ),
            if (notificationController.notificationCount.value > 0)
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${notificationController.notificationCount.value}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
      LanguageSelectorButton(),
    ],
  );
}
