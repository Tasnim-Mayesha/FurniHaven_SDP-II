import 'package:flutter/material.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text("Coupon Page",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
