import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/appbar/custom_appbar_in.dart';
import 'package:sdp2/common/widgets/bottomnavbar/bottom_nav_bar.dart';
import 'package:sdp2/common/widgets/bottomnavbar/starting_controller.dart';
import 'package:sdp2/features/customer/screen/cart/add_to_cart.dart';
import 'package:sdp2/features/customer/screen/home/home_view.dart';
import 'package:sdp2/features/customer/screen/message/message_list.dart';
import 'package:sdp2/features/customer/screen/wishlist/wishlist.dart';
import 'package:sdp2/features/personilization/screen/profile/profile.dart';
import 'package:sdp2/utils/global_colors.dart';

class CustMainPage extends StatelessWidget {
  CustMainPage({Key? key}) : super(key: key);

  final CustNavController custNavController = Get.put(CustNavController());

  final List<Widget> pages = [
    HomeView(),
    MessageList(),
    CartView(),
    WishlistView(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarIn(context),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 150.0,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 80),
              padding: EdgeInsets.zero,
              child: Image.asset('assets/images/furnihaven_logo.png', fit: BoxFit.contain),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text('Home'.tr),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Obx(() => pages[custNavController.currentIndex.value]),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
