import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/seller/controllers/nav_controller.dart';
import '../../../utils/global_colors.dart';


AppBar customAppBarIn(BuildContext context) {
  NavController navController = Get.find<NavController>();

  // Determine if the theme is dark or light
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

  // Set the back button icon based on the theme
  Icon backButtonIcon = isDarkMode
      ? const Icon(Icons.arrow_back_ios_new, color: GlobalColors.white)
      : const Icon(Icons.arrow_back_ios_new, color: GlobalColors.black);

  // Determine the current route
  String? currentRoute = ModalRoute.of(context)?.settings.name;

  return AppBar(
    backgroundColor: GlobalColors.mainColor,
    title: Obx(
          () => Text(
        navController.pageTitles[navController.currentIndex.value],
        textAlign: TextAlign.center,
      ),
    ),
    centerTitle: true,
    leading: (currentRoute != '/LoginView')
        ? Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: backButtonIcon,
          onPressed: () {
            if (Scaffold.of(context).hasDrawer) {
              Scaffold.of(context).openDrawer();
            } else {
              Navigator.of(context).pop();
            }
          },
        );
      },
    )
        : null, // Do not show the back button if on the login route
    actions: [
      LanguageSelectorButton(),
    ],
  );
}

class LanguageSelectorButton extends StatelessWidget {
  final List<Map<String, dynamic>> locale = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'বাংলা', 'locale': Locale('bn', 'BD')},
  ];

  LanguageSelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String language) {
        // Find the selected locale and update language
        Map<String, dynamic> selectedLocale =
        locale.firstWhere((element) => element['name'] == language);
        updateLanguage(selectedLocale['locale']);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        for (var lang in locale)
          PopupMenuItem<String>(
            value: lang['name'],
            child: Text(lang['name']),
          ),
      ],
    );
  }

  void updateLanguage(Locale locale) {
    Get.updateLocale(locale);
  }
}
