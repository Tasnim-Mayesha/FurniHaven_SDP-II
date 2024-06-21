import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/bottomnavbar/customer_starting.dart';
import 'package:sdp2/features/seller/views/main_page.dart';

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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/furnihaven_logo.png'), // Path to your logo asset
                      fit: BoxFit
                          .contain, // Ensures the logo is contained within the container without stretching
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome To FurniHaven',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Log In As',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    ExpandedButton(
                        label: 'Customer',
                        onPressed: () {
                          Get.to(CustMainPage());
                        }),
                    SizedBox(height: 20), // Spacing between the buttons
                    ExpandedButton(
                        label: 'Seller',
                        onPressed: () {
                          Get.to(MainPage());
                        }),
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
            child: Text(label),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
