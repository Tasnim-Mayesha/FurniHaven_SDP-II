import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/utils/global_colors.dart';

import '../bottomnavbar/starting_controller.dart';

class LanguageSelectorButton extends StatelessWidget {
  final List<Map<String, dynamic>> locale = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'বাংলা', 'locale': Locale('bn', 'BD')},
  ];

  LanguageSelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language, color: Colors.white), // Set icon color to white
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

AppBar customAppBarIn(BuildContext context) {
  CustNavController navController = Get.find<CustNavController>();

  return AppBar(
    backgroundColor: GlobalColors.mainColor,
    title: Obx(
          () => Text(
        navController.pageTitles[navController.currentIndex.value],
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white), // Set title color to white
      ),
    ),
    centerTitle: true,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu, color: Colors.white), // Set icon color to white
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    ),
    actions: [
      LanguageSelectorButton(), // Add the language selector button here
    ],
  );
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarIn(context),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 150.0,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 80),
              padding: EdgeInsets.zero,
              child: Image.asset('assets/images/furnihaven_logo.png',
                  fit: BoxFit.contain),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(child: Text('Your main content here')),
    );
  }
}
