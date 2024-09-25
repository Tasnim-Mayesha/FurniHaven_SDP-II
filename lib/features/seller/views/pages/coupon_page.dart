import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdp2/features/seller/views/pages/add_coupon_page.dart';
import 'package:sdp2/features/seller/views/pages/edit_coupon_page.dart';
import 'package:sdp2/features/seller/views/pages/controllers/Coupon/coupon_controller.dart';

import '../../authentication_seller/screen/login/login_view.dart';


class CouponPage extends StatelessWidget {
  final CouponController controller = Get.put(CouponController());

  CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // If the auth state is loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // If no user is logged in, show the login button
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => SellerLoginView());
                },
                child: const Text("Login"),
              ),
            );
          }

          // If the user is logged in, display the coupon list
          return Obx(() => ListView.builder(
            itemCount: controller.coupons.length,
            padding: const EdgeInsets.all(8),
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
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white, size: 36),
                ),
                child: Card(
                  color: Colors.orange.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
          ));
        },
      ),
      floatingActionButton: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // If the user is logged in, show the Add Coupon button
          if (snapshot.hasData && snapshot.data != null) {
            return FloatingActionButton(
              onPressed: () {
                Get.to(() => AddCouponPage());
              },
              backgroundColor: Colors.orange.shade200,
              child: const Icon(Icons.add),
            );
          }

          // If no user is logged in, do not show the Add Coupon button
          return const SizedBox.shrink();
        },
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
