import 'package:flutter/material.dart';

import '../../../../common/products/product_cards/card.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    // List of product details
    final List<Map<String, dynamic>> products = [
      {
        "imageUrl": "assets/products/ar_chair.png",
        "productName": "Eve Fabric Double Chair",
        "brandName": "Hatil",
        "discount": 25,
        "originalPrice": 24000,
        "discountedPrice": 17000,
        "rating": 4,
      },
      {
        "imageUrl": "assets/products/Round Dining Table.png",
        "productName": "Round 4 Seater Dining Table",
        "brandName": "Regal",
        "discount": 20,
        "originalPrice": 150000,
        "discountedPrice": 120000,
        "rating": 5,
      },
      {
        "imageUrl": "assets/products/Furnish Modern Chair.png",
        "productName": "Furnish White Modern Chair",
        "brandName": "Brothers",
        "discount": 15,
        "originalPrice": 18000,
        "discountedPrice": 12750,
        "rating": 4,
      },
    ];

    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            mainAxisExtent: 335,
          ),
          itemBuilder: (_, index) {
            final product = products[index];
            return ProductCard(
              imageUrl: product["imageUrl"],
              productName: product["productName"],
              brandName: product["brandName"],
              discount: product["discount"],
              originalPrice: product["originalPrice"],
              discountedPrice: product["discountedPrice"],
              rating: product["rating"],
            );
          },
        ),
      ),
    );
  }
}