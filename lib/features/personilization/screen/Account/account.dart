import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:sdp2/features/customer/screen/About%20Us/about_us.dart';
import 'package:sdp2/features/customer/screen/order_history/order_history.dart';
import 'package:sdp2/features/personilization/screen/Account/account_controller.dart';

import 'package:sdp2/features/personilization/screen/Login/login_option.dart';
import 'package:sdp2/features/personilization/screen/address/profile_address_page.dart';

import '../../../../common/widgets/bottomnavbar/customer_starting.dart';
import '../../../../common/widgets/bottomnavbar/starting_controller.dart';
import '../profile/profile.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});

  final AccountController _accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: user == null ? _buildLoginPrompt() : _buildAccountList(),
    );
  }

  // Function to build the UI for the logged-in state
  Widget _buildAccountList() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildListTile(
          0,
          Icons.person,
          'Profile'.tr,
              () {
            Get.to(() => ProfileView());
          },
        ),
        const Divider(),
        _buildListTile(
          1,
          Icons.location_on,
          'My Address'.tr,
              () {
            Get.to(() => ProfileAddressPage());
          },
        ),
        const Divider(),
        _buildListTile(
          2,
          Iconsax.heart5,
          'My Wishlist'.tr,
              () {
            final controller = Get.find<CustNavController>();
            controller.changePage(3);
            Get.to(() => CustMainPage());
          },
        ),
        const Divider(),
        _buildListTile(
          3,
          Icons.shopping_cart,
          'My Cart'.tr,
              () {
            final controller = Get.find<CustNavController>();
            controller.changePage(2);
            Get.to(() => CustMainPage());
          },
        ),
        const Divider(),
        _buildListTile(
          4,
          Icons.shopping_bag,
          'My Order List',
              () {
            Get.to(() => OrderHistoryPage());
          },
        ),
        const Divider(),
        _buildListTile(
          5,
          Icons.people,
          'About Us',
              () {
            Get.to(() => AboutUsPage());
          },
        ),
        const Divider(),
        _buildListTile(
          6,
          Icons.logout,
          'Log Out',
              () async {
            await _accountController.logout();
            Get.offAll(() => const LoginOption());
          },
        ),
      ],
    );
  }

  // Function to build the UI for the not logged-in state
  Widget _buildLoginPrompt() {
    return Center(
      child: SizedBox(
        width: 150,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => const LoginOption());
          },
          child: Text('Login'.tr),
        ),
      ),
    );
  }

  Widget _buildListTile(
      int index,
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return Obx(() {
      return InkWell(
        onTap: () {
          _accountController.setSelectedIndex(index);
          onTap();
        },
        child: Container(
          color: _accountController.selectedIndex.value == index
              ? Colors.blue.withOpacity(0.1)
              : null,
          child: ListTile(
            leading: Icon(icon, color: Colors.deepOrange),
            title: Text(
              title.tr,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
    });
  }
}