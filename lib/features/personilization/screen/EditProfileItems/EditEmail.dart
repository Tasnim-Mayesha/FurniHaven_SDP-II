import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../profile/profile.dart';



class EditEmail extends StatefulWidget {
  const EditEmail({super.key});

  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  final _emailController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _emailController.addListener(() {
      setState(() {
        _isEmailValid = _validateEmail(_emailController.text);
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[^@]+@[^@]+\.[^@]+',
    );
    return emailRegExp.hasMatch(email);
  }

  Future<void> _updateEmail() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'email': _emailController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your Email has been Updated Successfully'.tr),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.grey,
        ),
      );
      Get.off(() => ProfileView()); // Navigate back to SellerProfileView and refresh it
    } catch (e) {
      print('Failed to update email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update email'.tr),
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
        title: Text('Change Email'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                prefixIcon: Icon(
                  Icons.email,
                  color: _isFocused ? Colors.deepOrange : Colors.grey,
                ),
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'We will send verification to your Email address'.tr,
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
            const SizedBox(height: 16.0),
            if (_isEmailValid)
              ButtonTheme(
                height: 160.0,
                child: ElevatedButton(
                  onPressed: _isEmailValid ? _updateEmail : null,
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
