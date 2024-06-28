import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:sdp2/common/onboarding/Onboarding2.dart';
import '../widgets/PaginationIndicator/paginationIndicator.dart';
import '../widgets/bottomnavbar/customer_starting.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove default back button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0, right: 14.0),
              child: TextButton(
                onPressed: () {
                   Get.to(CustMainPage());
                  //Get.to(const LoginOption());
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 130.0),
            child: PaginationIndicator(
              totalPages: 3,
              currentPage: 0,
            ),
          ),
          Text(
            'Next'.tr,
            style: TextStyle(color: Colors.deepOrange, fontSize: 16),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 50.0,
            height: 50.0,
            child: FloatingActionButton(
              onPressed: () {
                Get.to(const Onboarding2());
              },
              backgroundColor: Colors.deepOrange,
              elevation: 4,
              mini: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    25.0), // Adjust the circular border radius
              ), // Set mini to true to make the button smaller
              child: const Icon(Icons.arrow_right_alt,
                  size: 24.0, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24.0),
                height: 300.0, // Set a fixed height for the image
                width: double.infinity, // Set the width to fill the container
                child: Image.asset(
                  'assets/onboarding/1.png',
                  fit: BoxFit.cover, // Ensure the image covers the container
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Choose your furniture'.tr,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Welcome to a World of Limitless Choices \n Your Perfect Furniture Awaits!',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
