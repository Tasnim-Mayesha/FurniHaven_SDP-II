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

  EditCouponPage({Key? key, required this.coupon})
      : codeController = TextEditingController(text: coupon.code),
        discountController =
            TextEditingController(text: coupon.discount.toString()),
        expiryDateController = TextEditingController(
            text: coupon.expiryDate.toString().substring(0, 10)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Coupon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // Makes button stretch to fit the width
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Discount Percentage',
                border: OutlineInputBorder(),
              ),
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
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30), // Horizontal padding
              child: ElevatedButton(
                onPressed: () {
                  if (codeController.text.isNotEmpty &&
                      discountController.text.isNotEmpty &&
                      expiryDateController.text.isNotEmpty) {
                    controller.updateCoupon(Coupon(
                      id: coupon.id,
                      code: codeController.text,
                      discount: double.parse(discountController.text),
                      expiryDate: DateTime.parse(expiryDateController.text),
                    ));
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 6), // Adds vertical padding inside the button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
