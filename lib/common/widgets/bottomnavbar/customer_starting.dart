import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sdp2/common/widgets/bottomnavbar/bottom_nav_bar.dart';
import 'package:sdp2/common/widgets/bottomnavbar/starting_controller.dart';
import 'package:sdp2/features/customer/screen/About%20Us/about_us.dart';
import 'package:sdp2/features/customer/screen/cart/add_to_cart.dart';
import 'package:sdp2/features/customer/screen/home/home_view.dart';
import 'package:sdp2/features/customer/screen/message/message_list.dart';
import 'package:sdp2/features/customer/screen/order_history/order_history.dart';
import 'package:sdp2/features/customer/screen/wishlist/wishlist.dart';
import 'package:sdp2/features/personilization/screen/Account/account.dart';
import '../appbar/custom_appbar_in.dart';

class CustMainPage extends StatelessWidget {
  CustMainPage({Key? key}) : super(key: key);
  final CustNavController custNavController = Get.put(CustNavController());
  final GetStorage storage = GetStorage();

  final List<Widget> pages = [
    const HomeView(),
    const MessageList(),
    const CartView(),
    const WishlistView(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = storage.read('IsFirstTime') ?? true;
    print('isFirstTime on cust start: $isFirstTime');
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
              child: Image.asset('assets/images/furnihaven_logo.png',
                  fit: BoxFit.contain),
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
                Get.to(() => CustMainPage());
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.heart5, color: Colors.deepOrange),
              title: Text('Cart'.tr),
              onTap: () {
                final controller = Get.find<CustNavController>();
                controller.changePage(2);
                Get.to(() => CustMainPage());
              },
            ),
            ListTile(
              leading:
              const Icon(Icons.shopping_cart, color: Colors.deepOrange),
              title: Text('Wishlist'.tr),
              onTap: () {
                final controller = Get.find<CustNavController>();
                controller.changePage(3);
                Get.to(() => CustMainPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.deepOrange),
              title: Text('Account'.tr),
              onTap: () {
                final controller = Get.find<CustNavController>();
                controller.changePage(4);
                Get.to(() => CustMainPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.deepOrange),
              title: Text('Order History'.tr),
              onTap: () {
                Get.to(() => OrderHistoryPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Colors.deepOrange),
              title: Text('About Us'.tr),
              onTap: () {
                Get.to(() => AboutUsPage());
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