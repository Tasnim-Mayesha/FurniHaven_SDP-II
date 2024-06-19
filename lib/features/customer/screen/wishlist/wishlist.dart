import 'package:flutter/material.dart';


import '../../../../common/products/product_cards/card.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: Center(
          child: ProductCard()
      ),


    );
  }
}
