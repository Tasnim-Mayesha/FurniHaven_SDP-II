import 'package:flutter/material.dart';

class SellerEditEmail extends StatefulWidget {
  const SellerEditEmail({super.key});

  @override
  _SellerEditEmailState createState() => _SellerEditEmailState();
}

class _SellerEditEmailState extends State<SellerEditEmail> {
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
    // Regular expression for validating an email address
    final RegExp emailRegExp = RegExp(
      r'^[^@]+@[^@]+\.[^@]+',
    );
    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Email'),
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
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'We will send verification to your Email address',
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
            const SizedBox(height: 16.0),
            if (_isEmailValid)
              ButtonTheme(
                height: 160.0,
                child: ElevatedButton(
                  onPressed: _isEmailValid
                      ? () {
                    // Handle update action
                    print('New Email: ${_emailController.text}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Your Email has been Updated Successfully'),
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
                  child: const Text('Save'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
