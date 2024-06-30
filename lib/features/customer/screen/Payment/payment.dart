import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Bkash/bkash.dart';

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

  @override
  Widget build(BuildContext context) {
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
                Get.to( const Bkash());
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/payment/nagad.png'), // Replace with your image asset
              ),
              title: Text('Nagad'.tr),
              onTap: () {

              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/payment/cash-on-delivery.png'), // Replace with your image asset
              ),
              title: Text('Cash on Delivery'.tr),
              onTap: () {

              },
            ),
            const SizedBox(height: 200,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black26, // You can change the border color here
                    width: 1.0, // Border width
                  ),
                  //borderRadius: BorderRadius.circular(4.0), // Optional: for rounded corners
                ),
                child: Column(
                  children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // To space out the texts
                      children: [
                        Text(
                          'Items(3)'.tr,
                          style: TextStyle(color: Color(0xFF9098B1)),
                        ),
                        Text(
                          '20000 Tk'.tr,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
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
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Import Charges'.tr,
                          style: TextStyle(color: Color(0xFF9098B1)),
                        ),
                        Text(
                          '200 Tk'.tr,
                          style: TextStyle(color:Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    CustomPaint(
                      size: const Size(double.infinity, 1),
                      painter: DottedLinePainter(),
                    ),
                    const SizedBox(height: 16,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price'.tr,
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '20240 Tk'.tr,
                          style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}