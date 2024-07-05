import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/home/home_controller/home_controller.dart';
import 'package:sdp2/features/customer/screen/home/widgets/banner_slider.dart';
import 'package:sdp2/features/customer/screen/home/widgets/category_grid.dart';
import 'package:sdp2/utils/global_colors.dart';

import '../../../../common/products/product_cards/card.dart';
import '../product/product_page.dart';
import 'brand/widgets/brand_grid.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      //appBar: customAppBarIn(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                height: 50.0, // Set the desired height
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0), // Add padding around the search bar
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search here".tr,
                    prefixIcon:
                        Icon(Icons.search, color: GlobalColors.mainColor),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0), // Adjust vertical padding
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                          color: Colors.grey), // Customize the border color
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                          color: Colors
                              .grey), // Border color when the TextField is not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                          color: GlobalColors
                              .mainColor), // Border color when the TextField is focused
                    ),
                  ),
                ),
              ),
            ),
            //const SizedBox(height: 10),
            BannerSlider(), // The banner slider
            //const SizedBox(height: 10),
            CategoryGrid(), // The category grid
            //const SizedBox(height: 10),
            PopularBrandsGrid(), // The popular brands grid
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 12), // Adjust the padding value as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommendation for you Mayesha'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Based on your Activity'.tr,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Obx(
                      () => Column(
                        children: [
                          GridView.builder(
                            itemCount: controller.products.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 335,
                            ),
                            itemBuilder: (_, index) {
                              final product = controller.products[index];
                              final originalPrice = product["price"] is int
                                  ? product["price"]
                                  : (product["price"] as double).toInt();
                              final discount = product["discount"] ?? 0;

                              return ProductCard(
                                imageUrl: product["imageUrl"] ?? '',
                                productName: product["title"] ?? '',
                                brandName: product["brandName"] ?? 'Unknown',
                                discount: discount,
                                originalPrice: originalPrice,
                                discountedPrice:
                                    (originalPrice * (1 - (discount / 100)))
                                        .round(),
                                rating: product["rating"] ?? 0,
                                onTap: () {
                                  Get.to(() => const ProductPage());
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      //bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
