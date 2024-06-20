import 'package:flutter/material.dart';
import 'package:sdp2/features/personilization/screen/profile/profile.dart';
// import 'package:get/get.dart'; // Assuming you're not using this in the current snippet
// import 'package:sdp2/common/widgets/bottomnavbar/customer_starting.dart'; // Assuming you're not using this in the current snippet

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

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildListTile(
            context,
            0,
            Icons.person,
            'Profile',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileView()),
              );
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            1,
            Icons.shopping_bag,
            'Order',
                () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => OrderPage()),
              // );
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            2,
            Icons.location_on,
            'Address',
                () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AddressPage()),
              // );
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            3,
            Icons.payment,
            'Payment',
                () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PaymentPage()),
              // );
            },
          ),
          const Divider(),
          _buildListTile(
            context,
            4,
            Icons.logout,
            'LogOut',
                () {
              // Handle logout
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => LogoutPage()),
              // );
            },
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

