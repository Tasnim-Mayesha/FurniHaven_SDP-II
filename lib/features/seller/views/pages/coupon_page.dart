import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Coupon Page".tr,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
