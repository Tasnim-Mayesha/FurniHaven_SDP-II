import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/PriceRange/priceRange.dart';
import '../Sort/sortBy.dart';

class CategoryFilterBy extends StatelessWidget {
  const CategoryFilterBy({super.key});

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
                ],
              ),
            ),
          ],//children
        ),
      ),
    );
  }
}