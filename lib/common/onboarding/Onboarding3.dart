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
              currentPage: 2,
            ),
          ),
          const Text(
            'NEXT',
            style: TextStyle(color: Colors.deepOrange, fontSize: 16),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Get.to(CustMainPage());
            },
            backgroundColor: Colors.deepOrange,
            elevation: 10,
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
                  'assets/images/image 77.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
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
                padding: EdgeInsets.symmetric(horizontal: 15.0),
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
