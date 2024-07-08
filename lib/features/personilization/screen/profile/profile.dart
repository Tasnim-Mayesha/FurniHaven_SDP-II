import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../../utils/global_colors.dart';
import '../AddContact/addContact.dart';
import '../ChangePassword/ChangePassword.dart';
import '../EditProfileItems/EditEmail.dart';
import 'package:image_picker/image_picker.dart'; // Import the image picker package

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile'.tr,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Center the title
        backgroundColor: GlobalColors.mainColor, // Set the AppBar color
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the back button color to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: _image != null
                          ? FileImage(File(_image!.path))
                          : AssetImage('assets/images/profile.jpg')
                      as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 12.0,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.add,
                            color: Colors.deepOrange,
                            size: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.0),
                Text(
                  'Sadia Shitol'.tr,
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
                          'Email: '.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 4.0), // Optional: add some spacing between the label and email
                        Expanded(
                          child: Text(
                            'shitolsadia@gmail.com'.tr,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      Get.to(() => const EditEmail());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone_android_sharp, color: Colors.deepOrange),
                    title: Text(
                      'Add Phone Number'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.orange,
                        fontSize: 16.0,
                      ),
                    ),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      Get.to(() => const AddContact());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.lock, color: Colors.deepOrange),
                    title: Row(
                      children: [
                        Text(
                          'Password: '.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            '********',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.ellipsis, // Ensure text does not overflow
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                    onTap: () {
                      Get.to(() => const ChangePassword());
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
