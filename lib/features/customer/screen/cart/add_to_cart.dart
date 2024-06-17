import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/utils/global_colors.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back),

        ),
      ),
      body: Center(
        child: Text("Cart Page",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),


    );
  }
}
