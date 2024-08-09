import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp2/features/customer/screen/Payment/payment_methods/Bkash/bkash.dart';
import 'package:sdp2/features/customer/screen/Payment/payment_methods/Nagad/nagad.dart';
import 'package:sdp2/features/customer/screen/order_history/order_history.dart';
import '../../../../../../common/widgets/success_screen.dart';

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var max = size.width;
    var dashWidth = 5;
    var dashSpace = 3;
    double startX = 0;

    while (startX < max) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Payment extends StatelessWidget {
  const Payment({super.key});

  Future<void> _addOrderToFirestore(List<dynamic> cartItems, String paymentMethod, double totalCost, Map<String, String> selectedAddress) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final ordersCollection = FirebaseFirestore.instance.collection('Orders');
      final timestamp = Timestamp.now();

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
        title: Text('Payment'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ListView(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/payment/bkash.png'),
              ),
              title: Text('Bkash'.tr),
              onTap: () {
                Get.to(() => Bkash(), arguments: {
                  'totalCost': totalCost,
                  'cartItems': cartItems,
                  'selectedAddress': selectedAddress,
                });
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/payment/nagad.png'),
              ),
              title: Text('Nagad'.tr),
              onTap: () {
                Get.to(() => Nagad(), arguments: {
                  'totalCost': totalCost,
                  'cartItems': cartItems,
                  'selectedAddress': selectedAddress,
                });
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/payment/cash-on-delivery.png'),
              ),
              title: Text('Cash on Delivery'.tr),
              onTap: () async {
                await _addOrderToFirestore(cartItems, 'Cash on Delivery', totalCost, selectedAddress);

                Get.to(() => SuccessScreen(
                  image: 'assets/images/success.png',
                  title: 'Order Placed Successfully',
                  subTitle: 'Your order has been placed. You will pay upon delivery.',
                  onPressed: () {
                    Get.to(() => const OrderHistoryPage());
                  },
                  buttonTitle: 'See your order',
                ));
              },
            ),
            const SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black26,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Items(${cartItems.length})'.tr,
                          style: TextStyle(color: Color(0xFF9098B1)),
                        ),
                        Text(
                          '${totalCost.toStringAsFixed(2)} Tk'.tr,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping'.tr,
                          style: TextStyle(color: Color(0xFF9098B1)),
                        ),
                        Text(
                          '40 Tk'.tr,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Import Charges'.tr,
                          style: TextStyle(color: Color(0xFF9098B1)),
                        ),
                        Text(
                          '200 Tk'.tr,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomPaint(
                      size: const Size(double.infinity, 1),
                      painter: DottedLinePainter(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price'.tr,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${(totalCost + 40 + 200).toStringAsFixed(2)} Tk'.tr,
                          style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
