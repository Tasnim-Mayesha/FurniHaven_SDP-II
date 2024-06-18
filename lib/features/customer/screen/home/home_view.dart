import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/home/widgets/banner_slider.dart';
import 'package:sdp2/utils/global_colors.dart';


import '../brand/widgets/brand_grid.dart';
import '../category/widget/category_grid.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search here".tr,
                  prefixIcon: Icon(Icons.search, color: GlobalColors.mainColor),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            BannerSlider(), // The banner slider
            const SizedBox(height: 10),
            CategoryGrid(), // The category grid
            const SizedBox(height: 10),
            PopularBrandsGrid(), // The popular brands grid
          ],
        ),
      ),
    );
  }
}
