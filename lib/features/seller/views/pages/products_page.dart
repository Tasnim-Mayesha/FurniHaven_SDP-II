import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/views/pages/add_edit_product.dart';
import 'package:sdp2/features/seller/views/pages/controllers/products_controller.dart';
import 'package:sdp2/common/products/product_cards/seller_product_card.dart';
import 'package:sdp2/features/seller/models/Product.dart';

class ProductsPage extends StatelessWidget {
  final ProductsController controller = Get.put(ProductsController());

  ProductsPage({super.key});

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
                            Colors.orange.withOpacity(0.3), // 30% opacity
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 20),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 15), // Icon position
                          child: Icon(Icons.search, color: Colors.deepOrange),
                        ),
                      ),
                      onChanged: (value) => controller.searchProducts(value),
                    ),
                  ),
                  const SizedBox(
                      width: 8), // Space between search box and button
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor, // Primary color
                      shape: BoxShape.circle, // Fully rounded
                    ),
                    margin: const EdgeInsets.only(
                        left: 8), // Adjust based on your need
                    child: IconButton(
                      iconSize: 24, // Smaller icon
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        Get.to(() => AddEditProductPage());
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Obx(
                  () => GridView.builder(
                    itemCount: controller.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                        onTap: () {
                          // Assuming your product has a unique identifier like 'id'
                          Product editableProduct = Product(
                              // id: product["id"],
                              title: product["productName"],
                              imageFile:
                                  null, // Handle file differently if necessary
                              price: product["discountedPrice"].toDouble(),
                              quantity:
                                  1, // Set default or derive from existing data
                              is3DEnabled:
                                  false, // Default or derive from existing data
                              category:
                                  'Electronics' // Default or derive from existing data
                              );
                          Get.to(() =>
                              AddEditProductPage(product: editableProduct));
                        },
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
