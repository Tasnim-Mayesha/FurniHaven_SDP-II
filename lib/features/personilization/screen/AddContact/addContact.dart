import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../profile/profile.dart';


class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _addContactController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isContactValid = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _addContactController.addListener(() {
      setState(() {
        _isContactValid = _validateContact(_addContactController.text);
      });
    });
  }

  @override
  void dispose() {
    _addContactController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool _validateContact(String contact) {
    // Simple validation for a phone number
    final RegExp contactRegExp = RegExp(r'^\d{11,15}$');
    return contactRegExp.hasMatch(contact);
  }

  Future<void> _updateContact() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);

      // Fetch the current list of phone numbers
      DocumentSnapshot userDoc = await userDocRef.get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      List<dynamic> currentPhones = userData['phones'] ?? [];

      // Add the new phone number to the list if it doesn't already exist
      String newPhone = _addContactController.text;
      if (!currentPhones.contains(newPhone)) {
        currentPhones.add(newPhone);
      }

      // Update the Firestore document with the modified list
      await userDocRef.update({
        'phones': currentPhones,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Phone Number has been Added'.tr),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.grey,
        ),
      );
      Get.off(() => ProfileView()); // Navigate back to ProfileView and refresh it
    } catch (e) {
      print('Failed to update phone number: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update phone number'.tr),
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
        title: Text('Add Phone Number'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _addContactController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Enter your contact number',
                prefixIcon: Icon(
                  Icons.phone_android_sharp,
                  color: _isFocused ? Colors.deepOrange : Colors.grey,
                ),
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16.0),
            if (_isContactValid)
              ButtonTheme(
                height: 160.0,
                child: ElevatedButton(
                  onPressed: _isContactValid ? _updateContact : null,
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
