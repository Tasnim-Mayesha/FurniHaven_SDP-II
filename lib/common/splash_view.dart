import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/data/repositories/authentication/authentication_repository.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the AuthenticationRepository is initialized
    Get.put(AuthenticationRepository());

    // Remove the splash screen after a delay
    Future.delayed(const Duration(seconds: 5), () {
      AuthenticationRepository.instance.screenRedirect();
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
