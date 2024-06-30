import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/PriceRange/priceRange.dart';
import '../Sort/sortBy.dart';

class FilterBy extends StatelessWidget {
  const FilterBy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter By'.tr,
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  const ListTile(
                    title: PriceRange(),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                         Expanded(
                          child: Text('Brand_sortBy'.tr),
                        ),
                        IconButton(
                          icon: const Icon(Icons.navigate_next),
                          onPressed: () {
                            Get.to(() => const SortBy());
                          },
                        ),
                      ],
                    ),
                   ),
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(
                            child: Text('Color'.tr),
                        ),
                        IconButton(
                          icon: const Icon(Icons.navigate_next),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => BrandPage()),
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(child: Text('Style'.tr),
                        ),
                        IconButton(
                          icon: const Icon(Icons.navigate_next),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => BrandPage()),
                            // );
                          },
                        ),
                      ],
                    ),

                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(child: Text('Newest'.tr),
                        ),
                        IconButton(
                          icon: const Icon(Icons.navigate_next),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => BrandPage()),
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],//children
        ),
      ),
    );
  }
}