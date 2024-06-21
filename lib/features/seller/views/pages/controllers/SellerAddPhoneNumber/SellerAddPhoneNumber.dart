import 'package:flutter/material.dart';

class SellerAddContact extends StatefulWidget {
  const SellerAddContact({super.key});

  @override
  _SellerAddContactState createState() => _SellerAddContactState();
}

class _SellerAddContactState extends State<SellerAddContact> {
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
        title: const Text('Phone Number'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Column(
            children: [
              Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color:Color(0xFF00008B),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
                    Navigator.pop(context);
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    //padding: EdgeInsets.symmetric(horizontal: 150.0),
                    minimumSize: const Size(double.infinity, 50.0),
                  ),
                  child: const Text('Save'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
