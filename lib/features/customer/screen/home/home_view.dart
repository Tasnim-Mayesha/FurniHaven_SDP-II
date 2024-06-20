import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/home/widgets/banner_slider.dart';
import 'package:sdp2/utils/global_colors.dart';

import '../../../../common/products/product_cards/card.dart';
import 'brand/widgets/brand_grid.dart';
import 'category/widget/category_grid.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        "imageUrl": "assets/products/almirah.png",
        "productName": "Round 4 Seater Dining Table",
        "brandName": "Regal",
        "discount": 20,
        "originalPrice": 150000,
        "discountedPrice": 120000,
        "rating": 5,
      },
      {
        "imageUrl": "assets/products/study table.png",
        "productName": "Furnish White Modern Chair",
        "brandName": "Brothers",
        "discount": 15,
        "originalPrice": 18000,
        "discountedPrice": 12750,
        "rating": 4,
      },
    ];
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                height: 50.0, // Set the desired height
                padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add padding around the search bar
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search here".tr,
                    prefixIcon: Icon(Icons.search, color: GlobalColors.mainColor),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0), // Adjust vertical padding
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Colors.grey), // Customize the border color
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Colors.grey), // Border color when the TextField is not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: GlobalColors.mainColor), // Border color when the TextField is focused
                    ),
                  ),
                ),
              )
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
              padding: const EdgeInsets.only(left: 12), // Adjust the padding value as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Recommendation for you Mayesha', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  const Text('Based on your Activity', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey),),
                  const SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
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
                ],
              ),
            ),
            const SizedBox(height: 8,)


          ],
        ),
      ),
    );
  }
}
