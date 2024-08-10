import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp2/common/products/product_cards/card.dart';
import 'package:sdp2/features/customer/screen/wishlist/wishlist_controller.dart';

import '../product/product_page.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  Future<Map<String, dynamic>?> fetchProductData(String id) async {
    try {
      // Fetch the document from Firestore using the product ID
      DocumentSnapshot productDoc = await FirebaseFirestore.instance.collection('Products').doc(id).get();
      if (productDoc.exists) {
        Map<String, dynamic> productData = productDoc.data() as Map<String, dynamic>;
        String sellerEmail = productData["sellerEmail"];

        // Fetch the seller data from Firestore using the sellerEmail
        QuerySnapshot sellerSnapshot = await FirebaseFirestore.instance
            .collection('Sellers')
            .where('email', isEqualTo: sellerEmail)
            .limit(1)
            .get();

        if (sellerSnapshot.docs.isNotEmpty) {
          Map<String, dynamic> sellerData = sellerSnapshot.docs.first.data() as Map<String, dynamic>;
          productData["brandName"] = sellerData["brandName"];
        } else {
          print("No matching seller found!");
          productData["brandName"] = 'Unknown';
        }

        return productData;
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
                brandName: product["brandName"], // Will be updated later
                sellerEmail: product["sellerEmail"],
                discount: product["discount"],
                originalPrice: product["originalPrice"],
                discountedPrice: product["discountedPrice"],
                rating: product["rating"],
                onTap: () async {
                  var productData = await fetchProductData(product["id"]);
                  if (productData != null) {
                    print("brand name: ${productData["brandName"]}");
                    print("discounted price: ${productData["discountedPrice"]}");
                    Get.to(() => ProductPage(
                      id: productData["id"] as String? ?? '',
                      imageUrl: productData["imageUrl"] as String? ?? '',
                      productName: productData["title"] as String? ?? 'Unknown',
                      brandName: productData["brandName"] as String? ?? 'Unknown',
                      sellerEmail: productData["sellerEmail"] as String? ?? 'Unknown',
                      discount: (productData["discount"] as num?)?.toInt() ?? 0,
                      originalPrice: (productData["price"] as num?)?.toInt() ?? 0,
                      discountedPrice: (product["discountedPrice"] as num?)?.toInt() ?? 0,
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