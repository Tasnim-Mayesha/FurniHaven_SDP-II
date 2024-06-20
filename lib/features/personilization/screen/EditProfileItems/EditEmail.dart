import 'package:flutter/material.dart';

class EditEmail extends StatefulWidget {
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
        title: Text('Email'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Column(
            children: [
              Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Change Email',
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
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 8.0), // Spacer between TextField and additional text
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text(
                    'We will send verification to your Email address',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),

                SizedBox(height: 16.0),
                if (_isEmailValid)
        ButtonTheme(
        height: 160.0,
        child: ElevatedButton(
          onPressed: _isEmailValid
              ? () {
            // Handle update action
            print('New Email: ${_emailController.text}');
            Navigator.pop(context);
          }
              : null,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            //padding: EdgeInsets.symmetric(horizontal: 150.0),
            minimumSize: Size(double.infinity, 50.0),
          ),
               child: Text('Save'),
                  ),
               ),
             ],
            ),
      ),
    );
  }
}
