import 'package:flutter/material.dart';
import 'package:sdp2/common/widgets/button.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(


      body: Center(
        child: SizedBox(width: 320,child: CustomButton(text: 'Checkout',))
      ),


    );
  }
}
