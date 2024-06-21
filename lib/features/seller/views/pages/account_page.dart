import 'package:flutter/material.dart';
import 'package:sdp2/features/personilization/screen/Login/login_option.dart';

class SellerAccountPage extends StatefulWidget {
  const SellerAccountPage({super.key});

  @override
  _SellerAccountPageState createState() => _SellerAccountPageState();
}

class _SellerAccountPageState extends State<SellerAccountPage> {
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const ProfileView()),
              // );
            },
            trailing: CircleAvatar(
              radius: 35.0,
              backgroundImage: AssetImage('assets/users/Seller.jpg'), // Replace with your image path
            ),
          ),
          const Divider(),
          _buildListTile(
            context,
            1,
            Icons.message_sharp,
            'Promotional Message',
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
            'Stores',
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
            'Payment Methods',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginOption()),
              );
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
              Text(title),
              if (index == 0) ...[
                SizedBox(width: 8.0), // Space between the text and the profile picture
              ],
            ],
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
