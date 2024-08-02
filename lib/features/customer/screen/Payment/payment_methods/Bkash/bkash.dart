import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/order_history/order_history.dart';
import '../../../../../../common/widgets/button.dart';
import '../../../../../../common/widgets/success_screen.dart';

class Bkash extends StatefulWidget {
  const Bkash({super.key});

  @override
  _BkashState createState() => _BkashState();
}

class _BkashState extends State<Bkash> {
  bool _isObscured = true;

  Future<void> _addOrderToFirestore(List<dynamic> cartItems, String paymentMethod, double totalCost, Map<String, String> selectedAddress) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final ordersCollection = FirebaseFirestore.instance.collection('Orders');
      final timestamp = Timestamp.now();

      // Iterate over each item in cartItems
      for (var item in cartItems) {
        await ordersCollection.add({
          'productID': item['id'],  // Assuming 'id' is the product ID
          'userID': user.uid,
          'sellerEmail': item['sellerEmail'],
          'quantity': item['quantity'],
          'price': item['price'],
          'totalPrice': totalCost,
          'paymentMethod': paymentMethod,
          'address': selectedAddress,
          'timestamp': timestamp
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalCost = Get.arguments['totalCost'] as double;
    final cartItems = Get.arguments['cartItems'] as List<dynamic>;
    final selectedAddress = Get.arguments['selectedAddress'] as Map<String, String>;

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
                              contentPadding: EdgeInsets.symmetric(vertical: 4.0),
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
                              contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
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
                  onTap: () async {
                    await _addOrderToFirestore(cartItems, 'Bkash', totalCost, selectedAddress);

                    Get.to(() => SuccessScreen(
                      image: 'assets/images/success.png',
                      title: 'Payment Successful',
                      subTitle: 'Your payment was successfully completed. Your product will be delivered to your door.',
                      onPressed: () {
                        Get.to(() => const OrderHistoryPage());
                      },
                      buttonTitle: 'See your order',
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}