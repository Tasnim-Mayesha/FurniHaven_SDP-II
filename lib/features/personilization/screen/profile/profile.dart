import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../../utils/global_colors.dart';
import '../AddContact/addContact.dart';
import '../ChangePassword/ChangePassword.dart';
import '../EditProfileItems/EditEmail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _imageUrl;
  String? _email;
  String? _username;
  var isLoading = false.obs;

  get emailInput => null;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    isLoading.value = true;
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        _imageUrl = userDoc['profilePicture'];
        _username = userDoc['userName'];
        _email = userDoc['email'];
        update();
      }
    } catch (e) {
      print('Error loading profile data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = pickedFile;
      uploadImage(File(_image!.path));
    }
  }

  Future<void> uploadImage(File imageFile) async {
    isLoading.value = true;
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String fileName = 'profile_pictures/$userId.jpg';
      UploadTask uploadTask = FirebaseStorage.instance.ref(fileName).putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {'profilePicture': downloadUrl},
        SetOptions(merge: true),
      );
      _imageUrl = downloadUrl;
      update();
    } catch (e) {
      print('Failed to upload image: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateEmail(String newEmail) async {
    isLoading.value = true;
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {'email': newEmail},
        SetOptions(merge: true),
      );
      _email = newEmail;
      update();
    } catch (e) {
      print('Failed to update email: $e');
    } finally {
      isLoading.value = false;
    }
  }

  XFile? get image => _image;
  String? get imageUrl => _imageUrl;
  String? get email => _email;
  String? get username => _username;

  validateEmail(value) {}
}

class ProfileView extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile'.tr,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: GlobalColors.mainColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        if (_profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

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
                        radius: 35.0,
                        backgroundImage: _profileController.image != null
                            ? FileImage(File(_profileController.image!.path))
                            : _profileController.imageUrl != null
                            ? NetworkImage(_profileController.imageUrl!)
                            : AssetImage('assets/images/profile.jpg') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _profileController.pickImage,
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
                    _profileController.username ?? 'Sadia Shitol',
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
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              _profileController.email ?? 'Disgusting',
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
                              overflow: TextOverflow.ellipsis,
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
        );
      }),
    );
  }
}
