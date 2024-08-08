import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/models/coupon.dart';
import 'package:sdp2/features/seller/views/pages/controllers/Coupon/coupon_controller.dart';

class EditCouponPage extends StatelessWidget {
  final CouponController controller = Get.find<CouponController>();
  final Coupon coupon;
  final TextEditingController codeController;
  final TextEditingController discountController;
  final TextEditingController expiryDateController;

  EditCouponPage({required this.coupon})
      : codeController = TextEditingController(text: coupon.code),
        discountController =
            TextEditingController(text: coupon.discount.toString()),
        expiryDateController = TextEditingController(
            text: coupon.expiryDate.toIso8601String().substring(0, 10));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Coupon'),
        backgroundColor: Colors.deepOrange,
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
                  final updatedCoupon = Coupon(
                    code: codeController.text,
                    discount: double.parse(discountController.text),
                    expiryDate: DateTime.parse(expiryDateController.text),
                    email: coupon.email,
                  );
                  // Assuming you have the document ID stored
                  controller.updateCoupon(coupon.code, updatedCoupon);
                  Navigator.pop(context);
                } else {
                  Get.snackbar(
                    'Error',
                    'All fields are required!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text('Update Coupon'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
