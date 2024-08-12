import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../profile/profile.dart';

class EditName extends StatefulWidget {
  const EditName({super.key});

  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  final _nameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isNameValid = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _nameController.addListener(() {
      setState(() {
        _isNameValid = _validateName(_nameController.text);
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool _validateName(String name) {
    return name.isNotEmpty;
  }

  Future<void> _updateName() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'userName': _nameController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your Name has been Updated Successfully'.tr),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.grey,
        ),
      );
      Get.back(); // Navigate back to the previous page (ProfileView)
    } catch (e) {
      print('Failed to update name: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update name'.tr),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Name'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                prefixIcon: Icon(
                  Icons.person,
                  color: _isFocused ? Colors.deepOrange : Colors.grey,
                ),
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16.0),
            if (_isNameValid)
              ButtonTheme(
                height: 160.0,
                child: ElevatedButton(
                  onPressed: _isNameValid ? _updateName : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    minimumSize: const Size(double.infinity, 50.0),
                  ),
                  child: Text('Save'.tr),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
