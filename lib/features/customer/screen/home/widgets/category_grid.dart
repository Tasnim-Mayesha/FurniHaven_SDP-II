import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../product_suggestion/product_suggestion_category.dart';



class CategoryGrid extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Sofas'.tr, image: 'assets/categories/sofa.png'),
    Category(name: 'Beds'.tr, image: 'assets/categories/bed.png'),
    Category(name: 'Dining'.tr, image: 'assets/categories/dining.png'),
    Category(name: 'Shoe Rack'.tr, image: 'assets/categories/shoe_rack.png'),
    Category(name: 'Study Table'.tr, image: 'assets/categories/study_table.png'),
    Category(name: 'Chair'.tr, image: 'assets/categories/chair.png'),
    Category(name: 'Cupboard'.tr, image: 'assets/categories/cupboard.png'),
    Category(name: 'Book Shelf'.tr, image: 'assets/categories/book_shelf.png'),
  ];

   CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Browse Popular Categories'.tr,
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
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (categories[index].name == 'Chair'.tr) {
                      Get.to(() => ProductSuggestionCategory(category: categories[index].name));
                    }
                    else if (categories[index].name == 'Beds'.tr) {
                      Get.to(() => ProductSuggestionCategory(category: categories[index].name));
                    }
                    else if (categories[index].name == 'Sofas'.tr) {
                      Get.to(() => ProductSuggestionCategory(category: categories[index].name));
                    }
                    else if (categories[index].name == 'Dining'.tr) {
                      Get.to(() => ProductSuggestionCategory(category: categories[index].name));
                    }
                    else if (categories[index].name == 'Shoe Rack'.tr) {
                      Get.to(() => ProductSuggestionCategory(category: categories[index].name));
                    }
                    else if (categories[index].name == 'Study Table'.tr) {
                      Get.to(() => ProductSuggestionCategory(category: categories[index].name));
                    }
                    else if (categories[index].name == 'Cupboard'.tr) {
                      Get.to(() => ProductSuggestionCategory(category: categories[index].name));
                    }
                    else if (categories[index].name == 'Bookshelf'.tr) {
                      Get.to(() => ProductSuggestionCategory(category: categories[index].name));
                    }
                  },
                  child: Column(
                    children: [
                      Image.asset(categories[index].image, height: 50),
                      const SizedBox(height: 5),
                      Text(
                        categories[index].name.tr,
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

class Category {
  final String name;
  final String image;
  final String? page; // Correctly marking 'page' as optional

  Category({required this.name, required this.image, this.page});
}
