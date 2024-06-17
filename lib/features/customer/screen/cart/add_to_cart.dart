import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/appbar/custom_appbar_in.dart';
import 'package:sdp2/utils/global_colors.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text("Cart Page",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),


    );
  }
}
