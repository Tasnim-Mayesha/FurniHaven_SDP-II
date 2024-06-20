import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/Sort/sortBy.dart';
import '../../../../common/products/product_cards/card.dart';
import '../../../../utils/global_colors.dart';
import '../Filter/filterBy.dart';

class ProductSuggestionCategory extends StatelessWidget {
  const ProductSuggestionCategory({super.key, required String category});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> products = [
      {
        "imageUrl": "assets/products/ar_chair.png",
        "productName": "Aesthetic Fabric Blue Chair",
        "brandName": "Hatil",
        "discount": 25,
        "originalPrice": 24000,
        "discountedPrice": 17000,
        "rating": 4,
      },
      {
        "imageUrl": "assets/products/Eve Fabric Dhouble Chair.png",
        "productName": "Eve Fabric Double Chair",
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
      {
        "imageUrl": "assets/products/Full house sell orange chair.png",
        "productName": "Full house sell orange chair",
        "brandName": "Otobi",
        "discount": 15,
        "originalPrice": 18000,
        "discountedPrice": 12750,
        "rating": 3,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 4.0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40.0,
            width: MediaQuery.of(context).size.width * 0.65,// Set the desired height
            child: TextField(
              decoration: InputDecoration(
                hintText: "Chairs".tr,
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
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.deepOrange),
            onPressed: () {
              Get.to(() => const SortBy());
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter, color: Colors.deepOrange),
            onPressed: () {
              Get.to(() => const FilterBy());
            },
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('25 Results',style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold
                ),),
              ),
              SizedBox(height: 8,),
              Expanded(
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
    );
  }
}
