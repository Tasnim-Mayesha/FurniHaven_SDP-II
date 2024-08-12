import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/personilization/screen/Login/login_option.dart';
import 'package:sdp2/features/seller/controllers/nav_controller.dart';
import 'package:sdp2/features/seller/views/pages/controllers/SellerProfile/sellerProfile.dart';
import 'package:sdp2/data/repositories/seller/seller_repository.dart';

import '../main_page.dart';

class SellerAccountPage extends StatefulWidget {
  const SellerAccountPage({super.key});

  @override
  _SellerAccountPageState createState() => _SellerAccountPageState();
}

class _SellerAccountPageState extends State<SellerAccountPage> {
  final NavController navController = Get.find<NavController>();

  int _selectedIndex = -1;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() async {
    final sellerRepository = SellerRepository.instance;
    await sellerRepository.clearCachedSellerUid();
    navController.currentIndex.value = 0;
    Get.offAll(() => const LoginOption());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildListTile(
            context,
            0,
            Icons.person,
            'Profile'.tr,
            () {
              Get.to(() => const SellerProfileView());
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            1,
            Icons.discount,
            'Coupons'.tr,
            () {
              final controller1 = Get.find<NavController>();
              controller1.changePage(3);
              Get.to(() => MainPage());
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            2,
            Icons.message_sharp,
            'Messages',
            () {
              final controller1 = Get.find<NavController>();
              controller1.changePage(1);
              Get.to(() => MainPage());
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            3,
            Icons.shopping_cart,
            'Products',
            () {
              final controller1 = Get.find<NavController>();
              controller1.changePage(2);
              Get.to(() => MainPage());
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            4,
            Icons.logout,
            'LogOut',
            _logout,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    int index,
    IconData icon,
    String title,
    VoidCallback onTap, {
    Widget? trailing,
  }) {
    return InkWell(
      onTap: () {
        _onTap(index);
        onTap();
      },
      child: Container(
        color: _selectedIndex == index ? Colors.blue.withOpacity(0.1) : null,
        child: ListTile(
          leading: Icon(icon, color: Colors.deepOrange),
          title: Row(
            children: [
              Text(title.tr),
              if (index == 0) ...[
                const SizedBox(width: 8.0),
              ],
            ],
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
