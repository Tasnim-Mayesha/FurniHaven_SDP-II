import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/views/pages/add_coupon_page.dart';
import 'package:sdp2/features/seller/views/pages/edit_coupon_page.dart';
import 'package:sdp2/features/seller/views/pages/controllers/Coupon/coupon_controller.dart';

class CouponPage extends StatelessWidget {
  final CouponController controller = Get.put(CouponController());

  CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => ListView.builder(
            itemCount: controller.coupons.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final coupon = controller.coupons[index];
              return Dismissible(
                key: Key(coupon.code), // Use code as unique key for Dismissible
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  return await showDeleteConfirmationDialog(context);
                },
                onDismissed: (direction) {
                  controller.removeCoupon(
                      coupon.code); // Remove the coupon after confirmation
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white, size: 36),
                ),
                child: Card(
                  color: Colors.orange.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: ListTile(
                    title: Text(coupon.code),
                    subtitle: Text(
                        'Discount: ${coupon.discount}% - Expires on: ${coupon.expiryDate.toString().substring(0, 10)}'),
                    onTap: () {
                      Get.to(() => EditCouponPage(coupon: coupon));
                    },
                  ),
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddCouponPage());
        },
        backgroundColor: Colors.orange.shade200,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you wish to delete this coupon?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("CANCEL"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("DELETE"),
            ),
          ],
        );
      },
    );
  }
}
