import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/utils/global_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // Determine if the theme is dark or light
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Set the back button icon based on the theme
    Icon backButtonIcon = isDarkMode
        ? const Icon(Icons.arrow_back_ios_new, color: GlobalColors.white)
        : const Icon(Icons.arrow_back_ios_new, color: GlobalColors.black);

    // Determine the current route
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    return AppBar(
      leading: (currentRoute != '/LoginView')
          ? IconButton(
              icon: backButtonIcon,
              onPressed: () => Navigator.of(context).pop(),
            )
          : null, // Do not show the back button if on the sign-in route
      actions: [
        LanguageSelectorButton(),
      ],
    );
  }
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
