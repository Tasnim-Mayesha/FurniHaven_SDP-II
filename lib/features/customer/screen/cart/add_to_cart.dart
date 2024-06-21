import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/cart/widget/add_remove_button.dart';
import 'package:sdp2/features/customer/screen/cart/widget/cart_item.dart';
import '../../../../utils/global_colors.dart';
import '../shipping/shipping.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: 32),
          itemCount: 4,
          itemBuilder: (_, index) => const Column(
            children: [
              CartItem(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 70),
                      AddRemoveButton(),
                    ],
                  ),
                  Text(
                    '10000 Tk',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 320,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.to(const ShippingPage());
            // Add your logic here for adding the item to the cart
          },
          label: const Text('Checkout',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
          backgroundColor: GlobalColors.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
      ),
    );
  }
}
