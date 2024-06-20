import 'package:flutter/material.dart';
import 'package:sdp2/features/personilization/screen/ChangePassword/ChangePassword.dart';
// import 'package:sdp2/common/widgets/appbar/custom_appbar_in.dart';
import 'package:sdp2/features/personilization/screen/EditProfileItems/EditEmail.dart';
import 'package:sdp2/features/personilization/screen/AddContact/AddContact.dart';
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),

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
                    leading: const Icon(Icons.email, color: Colors.deepOrange),
                    title: Row(
                      children: [
                        Text(
                          'Email:     ',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF00008B),

                          ),
                        ),
                        Text('shitolsadia@gmail.com', style: TextStyle(
                          color: Colors.grey
                        ),),
                      ],
                    ),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditEmail()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone_android_sharp, color: Colors.deepOrange),
                    title: Row(
                      children: [
                        Text(
                          'Add Phone Number    ',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                              color: Color(0xFF00008B),

                          ),
                        ),

                      ],
                    ),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddContact()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.lock, color: Colors.deepOrange),
                    title: Row(
                      children: [
                        Text(
                          'Password:  ',
                          style: TextStyle(fontWeight: FontWeight.w900,
                              color: Color(0xFF00008B),
                          ),
                        ),
                        Text('********',style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangePassword()),
                      );
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
