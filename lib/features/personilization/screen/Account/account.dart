import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/appbar/custom_appbar_in.dart';
import 'package:sdp2/features/customer/screen/order_history/order_history.dart';
import 'package:sdp2/features/personilization/screen/profile/profile.dart';
import 'package:sdp2/features/personilization/screen/Login/login_option.dart';

import '../../../../common/widgets/bottomnavbar/bottom_nav_bar.dart';

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
            'Profile',
                () {
              Get.to(()=> const ProfileView());
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            1,
            Icons.shopping_bag,
            'Order',
                () {
              Get.to(()=> const OrderHistoryPage());
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            2,
            Icons.location_on,
            'Address',
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
              Get.to(()=> const LoginOption());
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
          title: Text(title),
          // trailing: Icon(Icons.navigate_next, color: Colors.deepOrange),
        ),
      ),
    );
  }
}

