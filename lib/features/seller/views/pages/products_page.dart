import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/products/product_cards/seller_product_card.dart';
import 'package:sdp2/features/seller/views/pages/controllers/products_controller.dart';

class ProductsPage extends StatelessWidget {
  final ProductsController controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        fillColor:
                            Color(0xFFF09C39).withOpacity(0.3), // 30% opacity
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(left: 10, right: 20),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 15), // Icon position
                          child: Icon(Icons.search, color: Color(0xFFB47730)),
                        ),
                      ),
                      onChanged: (value) => controller.searchProducts(value),
                    ),
                  ),
                  SizedBox(width: 8), // Space between search box and button
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor, // Primary color
                      shape: BoxShape.circle, // Fully rounded
                    ),
                    margin:
                        EdgeInsets.only(left: 8), // Adjust based on your need
                    child: IconButton(
                      iconSize: 24, // Smaller icon
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        // Actions when the + icon is pressed
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Obx(
                  () => GridView.builder(
                    itemCount: controller.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      var product = controller.products[index];
                      return SellerProductCard(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
