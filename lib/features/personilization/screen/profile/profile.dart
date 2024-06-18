import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:sdp2/common/widgets/appbar/custom_appbar_in.dart';
import 'package:sdp2/utils/global_colors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 10.0),
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage('assets/images/profile_cust.png'),
                ),
                SizedBox(width: 16.0),
                Text(
                  'Sadia Shitol',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 32.0),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.email,color:Colors.deepOrange),
                    title: Text('shitolsadia@gmail.com'),
                    trailing: Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      // Handle email tap
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone,color:Colors.deepOrange),
                    title: Text('+8801972130208'),
                    trailing: Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      // Handle email tap
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.lock,color:Colors.deepOrange),
                    title: Text('********'),
                    trailing: Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      // Handle change password tap
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
