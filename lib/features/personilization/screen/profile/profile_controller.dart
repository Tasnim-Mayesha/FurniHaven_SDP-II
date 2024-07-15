import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class ProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _imageUrl;
  String? _username;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfilePicture();
  }

  Future<void> loadProfilePicture() async {
    isLoading.value = true;
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        _imageUrl = userDoc['profilePicture'];
        _username = userDoc['userName'];
        update();
      }
    } catch (e) {
      print('Error loading profile picture: $e');
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
      UploadTask uploadTask =
          FirebaseStorage.instance.ref(fileName).putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('Users').doc(userId).set(
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

  XFile? get image => _image;
  String? get imageUrl => _imageUrl;
  String? get username => _username;
}
