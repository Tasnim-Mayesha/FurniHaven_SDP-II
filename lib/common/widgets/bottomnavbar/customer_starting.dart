import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sdp2/common/widgets/bottomnavbar/bottom_nav_bar.dart';
import 'package:sdp2/common/widgets/bottomnavbar/starting_controller.dart';
import 'package:sdp2/features/customer/screen/cart/add_to_cart.dart';
import 'package:sdp2/features/customer/screen/home/home_view.dart';
import 'package:sdp2/features/customer/screen/message/message_list.dart';
import 'package:sdp2/features/customer/screen/wishlist/wishlist.dart';
import 'package:sdp2/features/personilization/screen/Account/account.dart';
import '../appbar/custom_appbar_in.dart';

class CustMainPage extends StatelessWidget {
  CustMainPage({Key? key}) : super(key: key);

  final CustNavController custNavController = Get.put(CustNavController());

  final List<Widget> pages = [
    const HomeView(),
    const MessageList(),
    const CartView(),
    const WishlistView(),
    const AccountPage()
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
              leading: const Icon(Icons.home, color: Colors.deepOrange),
              title: Text('Home'.tr),
              onTap: () {
                final controller = Get.find<CustNavController>();
                controller.changePage(0);
                Get.to(() => CustMainPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.deepOrange),
              title: Text('Messages'.tr),
              onTap: () {
                final controller = Get.find<CustNavController>();
                controller.changePage(1);
                Get.to(() => const MessageList());
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.heart5, color: Colors.deepOrange),
              title: Text('Wishlist'.tr),
              onTap: () {
                final controller = Get.find<CustNavController>();
                controller.changePage(2);
                Get.to(() => const WishlistView());
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.deepOrange),
              title: Text('Cart'.tr),
              onTap: () {
                final controller = Get.find<CustNavController>();
                controller.changePage(3);
                Get.to(() => const CartView());
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.deepOrange),
              title: Text('Account'.tr),
              onTap: () {
                final controller = Get.find<CustNavController>();
                controller.changePage(4);
                Get.to(() => const AccountPage());
              },
            ),
          ],
        ),
      ),
      body: Obx(() => pages[custNavController.currentIndex.value]),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
