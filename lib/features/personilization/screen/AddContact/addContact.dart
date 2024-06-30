import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final RegExp contactRegExp = RegExp(r'^\d{10,15}$');
    return contactRegExp.hasMatch(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Phone Number'.tr,
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        backgroundColor: Colors.deepOrange, // Set the background color to deep orange
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
                  onPressed: _isContactValid
                      ? () {
                    // Handle update action
                    print('Phone Number: ${_addContactController.text}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Your Contact Number has been Added'.tr),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.grey,
                      ),
                    );
                    Navigator.pop(context);
                  }
                      : null,
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
