import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdp2/features/personilization/screen/EditUserName/edit_user_name.dart';

import '../AddContact/addContact.dart';
import '../ChangePassword/ChangePassword.dart';
import '../EditProfileItems/EditEmail.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _imageUrl;
  String? _userName;
  String? _email;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').doc(userId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile information'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No profile data available'));
          }

          var userDoc = snapshot.data!;
          _imageUrl = userDoc['profilePicture'];
          _userName = userDoc['userName'];
          _email = userDoc['email'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage: _imageUrl != null
                              ? NetworkImage(_imageUrl!)
                              : const AssetImage('assets/images/profile.jpg') as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: const CircleAvatar(
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
                    const SizedBox(width: 16.0),
                    Text(
                      _userName ?? 'User Name',
                      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator()),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person, color: Colors.deepOrange),
                        title: Text(
                          'User Name'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                            color: Color(0xFF2D2727),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.deepOrange),
                          onPressed: () {
                            Get.to(() => const EditName());
                          },
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.email, color: Colors.deepOrange),
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Email: '.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16.0,
                                  color: Color(0xFF2D2727),
                                ),
                              ),
                              TextSpan(
                                text: _email ?? 'Your Email',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  color: Color(0xFF2D2727),
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.deepOrange),
                          onPressed: () {
                            Get.to(() => const EditEmail());
                          },
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.phone, color: Colors.deepOrange),
                        title: Text(
                          'Phone Number'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                            color: Color(0xFF2D2727),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.deepOrange),
                          onPressed: () {
                            Get.to(() => const AddContact());
                          },
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.lock, color: Colors.deepOrange),
                        title: Text(
                          'Password'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                            color: Color(0xFF2D2727),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.deepOrange),
                          onPressed: () {
                            Get.to(() => const ChangePassword());
                          },
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
      await _uploadImage(File(_image!.path));
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String fileName = 'profile_pictures/$userId.jpg';
      UploadTask uploadTask = FirebaseStorage.instance.ref(fileName).putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('Users').doc(userId).set(
        {'profilePicture': downloadUrl},
        SetOptions(merge: true),
      );
      setState(() {
        _imageUrl = downloadUrl;
      });
    } catch (e) {
      print('Failed to upload image: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

