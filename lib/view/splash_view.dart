import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:sdp2/view/login_view.dart';
import 'package:sdp2/view/onboarding/Onboarding.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Schedule a navigation to LoginScreen() after 5 seconds
    Timer(const Duration(seconds: 3), () {
      Get.to(Onboarding());
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
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