import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:sdp2/view/login_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Schedule a navigation to LoginView after 2 seconds
    Timer(const Duration(seconds: 2), () {
      // Ensuring we are not adding multiple instances to the navigation stack
      // by checking if the current route is not already the LoginView
      if (ModalRoute.of(context)?.settings.name != '/login') {
        Get.off(LoginView(),
            transition: Transition
                .fade); // Using Get.off() to replace the current route
      }
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
