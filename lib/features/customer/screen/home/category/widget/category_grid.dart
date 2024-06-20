import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bed.dart';
import '../bookshelf.dart';
import '../chair.dart';
import '../cupboard.dart';
import '../dining.dart';
import '../shoerack.dart';
import '../sofa.dart';
import '../studytable.dart'; // Import the category pages

class CategoryGrid extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Sofas'.tr, image: 'assets/categories/sofa.png', page: const SofasPage()),
    Category(name: 'Beds'.tr, image: 'assets/categories/bed.png', page: const BedsPage()),
    Category(name: 'Dining'.tr, image: 'assets/categories/dining.png', page: const DiningPage()),
    Category(name: 'Shoe Rack'.tr, image: 'assets/categories/shoe_rack.png', page: const ShoeRackPage()),
    Category(name: 'Study Table'.tr, image: 'assets/categories/study_table.png', page: const StudyTablePage()),
    Category(name: 'Chair'.tr, image: 'assets/categories/chair.png', page: const ChairPage()),
    Category(name: 'Cupboard'.tr, image: 'assets/categories/cupboard.png', page: const CupboardPage()),
    Category(name: 'Book Shelf'.tr, image: 'assets/categories/book_shelf.png', page: const BookShelfPage()),
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
                    Get.to(categories[index].page);
                  },
                  child: Column(
                    children: [
                      Image.asset(categories[index].image, height: 50),
                      const SizedBox(height: 5),
                      Text(
                        categories[index].name,
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
  final Widget page;

  Category({required this.name, required this.image, required this.page});
}
