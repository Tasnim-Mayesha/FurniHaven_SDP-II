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
                  final newCoupon = Coupon(
                    code: codeController.text,
                    discount: double.parse(discountController.text),
                    expiryDate: DateTime.parse(expiryDateController.text),
                    email: '', // Will be set in the controller
                  );
                  controller.addCoupon(newCoupon);
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
              child: Text('Add Coupon'),
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
