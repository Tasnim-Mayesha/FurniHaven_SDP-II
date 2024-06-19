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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 14.0),
              child: TextButton(
                onPressed: () {
                  Get.to(CustMainPage());
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.deepOrange,fontSize: 20),
                ),
              ),
            )
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
          const Text(
            'NEXT',
            style: TextStyle(color: Colors.deepOrange, fontSize: 16),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Get.to(const Onboarding2());
            },
            backgroundColor: Colors.deepOrange,
            elevation: 4,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.arrow_right_alt, size: 30.0, color: Colors.white),
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
                padding: const EdgeInsets.all(25.0),
                child: Image.asset(
                  'assets/images/image 78.jpg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Choose your furniture',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
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
