import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/bottomnavbar/customer_starting.dart';
import '../widgets/PaginationIndicator/paginationIndicator.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BackButton(),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, right: 14.0),
              child: TextButton(
                onPressed: () {
                  Get.to(()=> CustMainPage());
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.deepOrange, fontSize: 16),
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
              currentPage: 2,
            ),
          ),
          const Text(
            'Next',
            style: TextStyle(color: Colors.deepOrange, fontSize: 16),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 50.0,
            height: 50.0,
            child: FloatingActionButton(
              onPressed: () {
                Get.to( CustMainPage());
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
                  'assets/onboarding/3.png',
                  fit: BoxFit.cover, // Ensure the image covers the container
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Deliver at your door step',
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
                  'From Our Doorstep to Yours-Swift, Secure, \n and Contactless Delivery',
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
