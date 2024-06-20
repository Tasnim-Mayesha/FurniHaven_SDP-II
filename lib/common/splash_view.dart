import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:sdp2/common/onboarding/Onboarding.dart';
//don't remove it

//import '../../seller/views/main_page.dart'; //don't remove it

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Get.off( const Onboarding(), transition: Transition.fade);
      //Get.off(MainPage(), transition: Transition.fade);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/furnihaven_logo.png',
              width: 300, // Adjust the size as needed
              height: 300,
            ),
            const SizedBox(height: 16), // Space between the image and text
            const Text(
              'FurniHaven',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'A Paradise for Furniture Lovers',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
