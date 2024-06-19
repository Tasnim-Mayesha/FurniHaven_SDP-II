import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/views/pages/account_page.dart';
import 'package:sdp2/features/seller/views/pages/chat_page.dart';
import 'package:sdp2/features/seller/views/pages/coupon_page.dart';
import 'package:sdp2/features/seller/views/pages/dashboard_page.dart';
import 'package:sdp2/features/seller/views/pages/products_page.dart';
import 'package:sdp2/features/seller/views/widget/custom_app_bar_seller.dart';

import 'package:sdp2/utils/global_colors.dart';

import '../controllers/nav_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final NavController navController = Get.put(NavController());

  final List<Widget> pages = [
    const DashboardPage(),
    const ChatPage(),
    const ProductsPage(),
    const CouponPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
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
              leading: const Icon(Icons.home),
              title: const Text('Home'),
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
      body: Obx(() => pages[navController.currentIndex.value]),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: GlobalColors.white,
            currentIndex: navController.currentIndex.value,
            onTap: (index) {
              navController.changePage(index);
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: GlobalColors.mainColor,
            unselectedItemColor: Colors.grey,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_offer),
                label: 'Coupons',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
