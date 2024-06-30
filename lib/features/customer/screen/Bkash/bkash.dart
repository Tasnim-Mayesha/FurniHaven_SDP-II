import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/order_history/order_history.dart';

import '../../../../common/widgets/button.dart';
import '../../../../common/widgets/success_screen.dart';

class Bkash extends StatefulWidget {
  const Bkash({super.key});

  @override
  _BkashState createState() => _BkashState();
}

class _BkashState extends State<Bkash> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bkash'.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 200, top: 50),
              child: Center(
                child: Container(
                  width: 340,
                  height: 270,
                  color: const Color(0xFFD7005A),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Image.asset(
                        'assets/payment/bkash.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your phone number',
                              hintStyle: TextStyle(color: Color(0xFF979797)),
                              prefixIcon: Icon(Icons.phone, color: Colors.orange),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(vertical: 4.0),  // Adjust padding as needed
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            obscureText: _isObscured,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your pin',
                              hintStyle: const TextStyle(color: Color(0xFF979797)),
                              prefixIcon: const Icon(Icons.pin, color: Colors.orange),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscured ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.orange,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscured = !_isObscured;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 4.0),  // Adjust padding as needed
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 320,
                height: 50,
                child: CustomButton(
                  text: 'Pay',
                  onTap: () => Get.to(() => SuccessScreen(
                    image: 'assets/images/success.png',
                    title: 'Payment Successful',
                    subTitle: 'Your payment was successfully completed. Your product will be delivered to your door.',
                    onPressed: () {
                      Get.to(() => const OrderHistoryPage());
                    },
                    buttonTitle: 'See your order',
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
