import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:sdp2/common/products/product_cards/card.dart';
import 'package:sdp2/features/customer/screen/wishlist/wishlist_controller.dart';

import '../product/product_page.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  Future<Map<String, dynamic>?> fetchProductData(String id) async {
    try {
      // Fetch the document from Firestore using the product ID
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Products').doc(id).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print("No such product!");
        return null;
      }
    } catch (e) {
      print("Error fetching product: $e");
      return null;
    }
  }

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
                onTap: () async {
                  var productData = await fetchProductData(product["id"]);
                  if (productData != null) {
                    Get.to(() => ProductPage(
                      id: productData["id"] as String? ?? '',
                      imageUrl: productData["imageUrl"] as String? ?? '',
                      productName: productData["title"] as String? ?? 'Unknown',
                      brandName: productData["brandName"] as String? ?? 'Unknown',
                      sellerEmail: productData["sellerEmail"] as String? ?? 'Unknown',
                      discount: (productData["discount"] as num?)?.toInt() ?? 0,
                      originalPrice: (productData["price"] as num?)?.toInt() ?? 0,
                      discountedPrice: (productData["discountedPrice"] as num?)?.toInt() ?? 0,
                      rating: (productData["rating"] as num?)?.toDouble() ?? 0.0,
                      modelUrl: productData["modelUrl"] as String? ?? '',
                      description: productData["description"] as String? ?? '',
                    ));
                  }
                },
              );
            },
          );
        }),
      ),
    );
  }
}
