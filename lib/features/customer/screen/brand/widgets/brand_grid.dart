import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../regal.dart';
import '../brothers.dart';
import '../otobi.dart';
import '../hatil.dart'; // Import the brand pages

class PopularBrandsGrid extends StatelessWidget {
  final List<Brand> brands = [
    Brand(name: 'Regal', image: 'assets/brands/regal.png', page: RegalPage()),
    Brand(name: 'Brothers', image: 'assets/brands/brothers.png', page: BrothersPage()),
    Brand(name: 'Otobi', image: 'assets/brands/otobi.png', page: OtobiPage()),
    Brand(name: 'Hatil', image: 'assets/brands/hatil.png', page: HatilPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Browse Popular Brands',
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
              itemCount: brands.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(brands[index].page);
                  },
                  child: Column(
                    children: [
                      Image.asset(brands[index].image, height: 50),
                      SizedBox(height: 5),
                      Text(
                        brands[index].name,
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

class Brand {
  final String name;
  final String image;
  final Widget page;

  Brand({required this.name, required this.image, required this.page});
}
