import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sdp2/features/seller/views/pages/controllers/SellerAddPhoneNumber/SellerAddPhoneNumber.dart';
import 'package:sdp2/features/seller/views/pages/controllers/SellerEditEmail/SellerEditEmail.dart';
import 'package:sdp2/features/seller/views/pages/controllers/SellerPasswordChange/SellerPasswordChange.dart';

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
  void initState() {
    super.initState();
    _loadProfilePicture();
  }

  Future<void> _loadProfilePicture() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        setState(() {
          _imageUrl = userDoc['profilePicture'];
          _userName = userDoc['userName'];
          _email = userDoc['email'];
        });
      }
    } catch (e) {
      print('Error loading profile picture: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile'.tr,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Center the title
        // backgroundColor: GlobalColors.mainColor, // Set the AppBar color
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the back button color to white
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
                      radius: 40.0,
                      backgroundImage: _imageUrl != null
                          ? NetworkImage(_imageUrl!)
                          : AssetImage('assets/images/profile.jpg') as ImageProvider,
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
                  _userName ?? 'User Name',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            if (_isLoading)
              Center(child: CircularProgressIndicator()),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email, color: Colors.deepOrange),
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Email: '.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16.0,
                              color: Color(0xFF2D2727),
                            ),
                          ),
                          TextSpan(
                            text: _email ?? 'Your Email',
                            style: TextStyle(
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
                        Get.to(() => EditEmail());
                      },
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.deepOrange),
                    title: Text(
                      'Phone Number'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16.0,
                        color: Color(0xFF2D2727),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.deepOrange),
                      onPressed: () {
                        Get.to(() => AddContact());
                      },
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.lock, color: Colors.deepOrange),
                    title: Text(
                      'Password'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16.0,
                        color: Color(0xFF2D2727),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.deepOrange),
                      onPressed: () {
                        Get.to(() => ChangePassword());
                      },
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
