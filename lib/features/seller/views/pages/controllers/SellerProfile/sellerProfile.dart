import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/views/pages/controllers/SellerAddPhoneNumber/SellerAddPhoneNumber.dart';
import 'package:sdp2/features/seller/views/pages/controllers/SellerEditEmail/SellerEditEmail.dart';
// import '../../../../utils/global_colors.dart';
// import '../ChangePassword/ChangePassword.dart';

class SellerProfileView extends StatelessWidget {
  const SellerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Center the title
       // backgroundColor: GlobalColors.mainColor, // Set the AppBar color
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the back button color to white
        ),
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
                  backgroundImage: AssetImage('assets/users/default.png'),
                ),
                SizedBox(width: 16.0),
                Text(
                  'Yamin Shovo',
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
                    title: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Email: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16.0,
                              color: Color(0xFF00008B),
                            ),
                          ),
                          TextSpan(
                            text: 'shovoyamin@gmail.com',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      Get.to(() => const SellerEditEmail());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone_android_sharp, color: Colors.deepOrange),
                    title: const Text(
                      'Add Phone Number',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF00008B),
                        fontSize: 16.0,
                      ),
                    ),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      Get.to(() => const SellerAddContact());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.lock, color: Colors.deepOrange),
                    title: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Password: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16.0,
                              color: Color(0xFF00008B),
                            ),
                          ),
                          TextSpan(
                            text: '********',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                    // onTap: () {
                    //   Get.to(() => const ChangePassword());
                    // },
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
