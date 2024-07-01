import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/views/pages/add_coupon_page.dart';
import 'package:sdp2/features/seller/views/pages/edit_coupon_page.dart'; // Ensure this import is correct
import 'package:sdp2/features/seller/views/pages/controllers/Coupon/coupon_controller.dart';

class CouponPage extends StatelessWidget {
  final CouponController controller = Get.put(CouponController());

  CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => ListView.builder(
            itemCount: controller.coupons.length,
            padding: EdgeInsets.all(8), // General padding around the list
            itemBuilder: (context, index) {
              final coupon = controller.coupons[index];
              return Dismissible(
                key: Key(coupon.id), // Unique key for Dismissible
                direction: DismissDirection
                    .endToStart, // Allows only right to left swipe for delete
                confirmDismiss: (direction) async {
                  return await showDeleteConfirmationDialog(
                      context); // Show delete confirmation
                },
                onDismissed: (direction) {
                  controller.removeCoupon(
                      coupon.id); // Remove the coupon after confirmation
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white, size: 36),
                ),
                child: Card(
                  color:
                      Colors.orange.shade100, // Light shade orange background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  margin: EdgeInsets.symmetric(
                      vertical: 5, horizontal: 5), // Spacing between cards
                  child: ListTile(
                    title: Text(coupon.code),
                    subtitle: Text(
                        'Discount: ${coupon.discount}% - Expires on: ${coupon.expiryDate.toString().substring(0, 10)}'),
                    onTap: () {
                      // Navigate to the Edit Coupon Page when the item is tapped
                      Get.to(() => EditCouponPage(coupon: coupon));
                    },
                  ),
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Add Coupon Page
          Get.to(() => AddCouponPage());
        },
        backgroundColor:
            Colors.orange.shade200, // Use global color or specify a new one
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

  Widget slideRightBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20),
      child: Icon(Icons.edit, color: Colors.white, size: 36),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      child: const Center(
        child: Text("Coupon Page",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
