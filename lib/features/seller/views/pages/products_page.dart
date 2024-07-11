import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/views/pages/add_edit_product.dart';
import 'package:sdp2/features/seller/views/pages/controllers/products_controller.dart';
import 'package:sdp2/common/products/product_cards/seller_product_card.dart';
import 'package:sdp2/features/seller/models/Product.dart';

class ProductsPage extends StatelessWidget {
  final ProductsController controller = Get.put(ProductsController());
  final ScrollController _scrollController = ScrollController();

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
                        fillColor: Colors.orange.withOpacity(0.3),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 20),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.deepOrange),
                      ),
                      onChanged: (value) => controller.searchProducts(value),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    margin: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      iconSize: 24,
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () => Get.to(() => AddEditProductPage()),
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
                    controller:
                        _scrollController, // Add the scroll controller here
                    itemCount: controller.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      Product product = controller.products[index];
                      return SellerProductCard(
                        product: product,
                        onTap: () {
                          Get.to(() => AddEditProductPage(product: product));
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
