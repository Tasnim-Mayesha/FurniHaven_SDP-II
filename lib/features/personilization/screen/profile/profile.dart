import 'package:flutter/material.dart';
// import 'package:sdp2/common/widgets/appbar/custom_appbar_in.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
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
            const SizedBox(height: 32.0),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email,color:Colors.deepOrange),
                    title: const Text('shitolsadia@gmail.com'),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      // Handle email tap
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone,color:Colors.deepOrange),
                    title: const Text('+8801972130208'),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      // Handle email tap
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.lock,color:Colors.deepOrange),
                    title: const Text('********'),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
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
