import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/data/repositories/seller/seller_repository.dart';
import 'package:sdp2/features/authentication/screen/login/login_view.dart';
import 'package:sdp2/features/seller/views/main_page.dart';

import '../../../seller/authentication_seller/screen/login/login_view.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double
                      .infinity, // Ensures the container takes the full width
                  height:
                      200, // Adjust based on your logo aspect ratio and desired size
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/furnihaven_logo.png'), // Path to your logo asset
                      fit: BoxFit
                          .contain, // Ensures the logo is contained within the container without stretching
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Welcome To FurniHaven'.tr,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'Continue As'.tr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    ExpandedButton(
                        label: 'Customer',
                        onPressed: () {
                          Get.to(LoginView());
                        }),
                    const SizedBox(height: 20), // Spacing between the buttons
                    ExpandedButton(
                      label: 'Seller',
                      onPressed: () async {
                        final sellerRepository = SellerRepository.instance;
                        final uid = await sellerRepository.getCachedSellerUid();

                        if (uid != null) {
                          // Fetch seller data
                          // SellerModel seller = await sellerRepository.getSellerData(uid);
                          // Navigate to MainPage
                          Get.off(() => MainPage());
                        } else {
                          // Navigate to Login Page
                          Get.to(() => SellerLoginView());
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ExpandedButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: Text(label.tr),
          ),
        ),
      ],
    );
  }
}
