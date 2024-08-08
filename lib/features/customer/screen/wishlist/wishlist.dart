import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/products/product_cards/card.dart';
import 'package:sdp2/features/customer/screen/wishlist/wishlist_controller.dart';


class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.put(WishlistController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          return GridView.builder(
            itemCount: wishlistController.wishlistItems.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 335,
            ),
            itemBuilder: (_, index) {
              final product = wishlistController.wishlistItems[index];
              return ProductCard(
                id: product["id"],
                imageUrl: product["imageUrl"],
                productName: product["productName"],
                brandName: product["brandName"],
                sellerEmail: product["sellerEmail"],
                discount: product["discount"],
                originalPrice: product["originalPrice"],
                discountedPrice: product["discountedPrice"],
                rating: product["rating"],
                onTap: () {
                  // Handle card tap if necessary
                },
              );
            },
          );
        }),
      ),
    );
  }
}
