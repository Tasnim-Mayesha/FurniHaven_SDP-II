import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdp2/features/personilization/screen/profile/profile.dart';
import 'package:sdp2/features/personilization/screen/Login/login_option.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _selectedIndex = -1;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
              Get.to(() => const ProfileView());
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            2,
            Icons.location_on,
            'My Address'.tr,
                () {
              //
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            2,
            Iconsax.heart5,
            'My Wishlist'.tr,
                () {
              //
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            2,
            Icons.shopping_cart,
            'My Cart'.tr,
                () {
              //
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            2,
            Icons.shopping_bag,
            'My Order List',
                () {
              //
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            4,
            Icons.logout,
            'Log Out',
                () {
              // Handle logout
              Get.to(() => const LoginOption());
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
    return InkWell(
      onTap: () {
        _onTap(index);
        onTap();
      },
      child: Container(
        color: _selectedIndex == index ? Colors.blue.withOpacity(0.1) : null,
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
  }
}
