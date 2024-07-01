import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/views/pages/controllers/Coupon/coupon_controller.dart';
import 'package:sdp2/features/seller/models/coupon.dart';

class AddCouponPage extends StatelessWidget {
  final CouponController controller = Get.find<CouponController>();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  AddCouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Coupon'),
        // backgroundColor: Colors.deepOrange, // Adjust color to your theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Coupon Code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: discountController,
              decoration: InputDecoration(
                labelText: 'Discount Percentage',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: expiryDateController,
              decoration: InputDecoration(
                labelText: 'Expiry Date',
                hintText: 'YYYY-MM-DD',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (codeController.text.isNotEmpty &&
                    discountController.text.isNotEmpty &&
                    expiryDateController.text.isNotEmpty) {
                  final newCoupon = Coupon(
                    id: DateTime.now()
                        .millisecondsSinceEpoch
                        .toString(), // Generate a unique ID based on timestamp
                    code: codeController.text,
                    discount: double.parse(discountController.text),
                    expiryDate: DateTime.parse(expiryDateController.text),
                  );
                  controller.addCoupon(newCoupon);
                  Navigator.pop(context);
                }
              },
              child: Text('Add Coupon'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange, // Button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12), // Adds vertical padding inside the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
