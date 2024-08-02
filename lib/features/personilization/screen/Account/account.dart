import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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
    return Scaffold(
      // appBar: customAppBarIn(context),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildListTile(
            context,
            0,
            Icons.person,
            'Profile'.tr,
            () {
              Get.to(() => ProfileView());
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            1,
            Icons.location_on,
            'My Address'.tr,
            () {
              Get.to(()=>ProfileAddressPage());
            },
          ),
          const Divider(),
          _buildListTile(
            context,
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
            context,
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
            context,
            4,
            Icons.shopping_bag,
            'My Order List',
            () {
              Get.to(()=> OrderHistoryPage());
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            5,
            Icons.logout,
            'Log Out',
            () async {
              await _accountController.logout();
              Get.offAll(() => const LoginOption());
            },
          ),
        ],
      ),
      // bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildListTile(
    BuildContext context,
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
            // trailing: Icon(Icons.navigate_next, color: Colors.deepOrange),
          ),
        ),
      );
    });
  }
}
