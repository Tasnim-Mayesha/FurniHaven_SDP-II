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
    Category(name: 'Sofas', image: 'assets/categories/sofa.png', page: SofasPage()),
    Category(name: 'Beds', image: 'assets/categories/bed.png', page: BedsPage()),
    Category(name: 'Dining', image: 'assets/categories/dining.png', page: DiningPage()),
    Category(name: 'Shoe Rack', image: 'assets/categories/shoe_rack.png', page: ShoeRackPage()),
    Category(name: 'Study Table', image: 'assets/categories/study_table.png', page: StudyTablePage()),
    Category(name: 'Chair', image: 'assets/categories/chair.png', page: ChairPage()),
    Category(name: 'Cupboard', image: 'assets/categories/cupboard.png', page: CupboardPage()),
    Category(name: 'Book Shelf', image: 'assets/categories/book_shelf.png', page: BookShelfPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Browse Popular Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      SizedBox(height: 5),
                      Text(
                        categories[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
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
