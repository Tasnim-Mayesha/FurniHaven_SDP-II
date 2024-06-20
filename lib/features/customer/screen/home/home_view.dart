import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/home/widgets/banner_slider.dart';
import 'package:sdp2/utils/global_colors.dart';

import 'brand/widgets/brand_grid.dart';
import 'category/widget/category_grid.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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

          ],
        ),
      ),
    );
  }
}
