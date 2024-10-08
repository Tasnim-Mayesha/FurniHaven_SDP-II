import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../product_suggestion/product_suggestion_brand.dart';




class PopularBrandsGrid extends StatelessWidget {
  final List<Brand> brands = [
    Brand(name: 'Regal', image: 'assets/brands/regal.png' ),
    Brand(name: 'Brothers', image: 'assets/brands/brothers.png'),
    Brand(name: 'Otobi', image: 'assets/brands/otobi.png'),
    Brand(name: 'Hatil', image: 'assets/brands/hatil.png'),
  ];

  PopularBrandsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Browse Popular Brands'.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: brands.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                       if (brands[index].name == 'Regal'.tr) {
                         Get.to(() =>  ProductSuggestionBrand(brandName: brands[index].name,));
                       }
                       else if (brands[index].name == 'Brothers'.tr) {
                         Get.to(() =>  ProductSuggestionBrand(brandName: brands[index].name,));
                       }
                       else if (brands[index].name == 'Otobi'.tr) {
                         Get.to(() =>  ProductSuggestionBrand(brandName: brands[index].name,));
                       }
                       else if (brands[index].name == 'Hatil'.tr) {
                         Get.to(() =>  ProductSuggestionBrand(brandName: brands[index].name,));
                       }

                  },
                  child: Column(
                    children: [
                      Image.asset(brands[index].image, height: 50),
                      const SizedBox(height: 5),
                      Text(
                        brands[index].name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Brand {
  final String name;
  final String image;
  final String? page; // Correctly marking 'page' as optional

  Brand({required this.name, required this.image, this.page});
}
