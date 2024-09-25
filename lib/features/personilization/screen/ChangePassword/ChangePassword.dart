import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isCurrentPasswordVisible = false; // Visibility state for current password
  bool _isNewPasswordVisible = false; // Visibility state for new password
  bool _isConfirmPasswordVisible = false; // Visibility state for confirm password
  bool _isCurrentPasswordValid = false;
  bool _isNewPasswordValid = false;
  bool _isConfirmPasswordValid = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(validatePasswords);
    _newPasswordController.addListener(validatePasswords);
    _confirmPasswordController.addListener(validatePasswords);
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void validatePasswords() {
    setState(() {
      _isCurrentPasswordValid = _currentPasswordController.text.isNotEmpty &&
          _currentPasswordController.text.length >= 6;
      _isNewPasswordValid = _newPasswordController.text.isNotEmpty &&
          _newPasswordController.text.length >= 6 &&
          _newPasswordController.text.contains(RegExp(r'[A-Z]')) && // contains a capital letter
          _newPasswordController.text.contains(RegExp(r'[0-9]')) && // contains a number
          _newPasswordController.text.contains(RegExp(r'[a-zA-Z]')); // contains a letter
      _isConfirmPasswordValid = _confirmPasswordController.text.isNotEmpty &&
          _confirmPasswordController.text.length >= 6;
    });
  }

  bool validateForm() {
    return _isCurrentPasswordValid && _isNewPasswordValid && _isConfirmPasswordValid;
  }

  Future<void> _changePassword() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Reauthenticate the user
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _currentPasswordController.text,
        );
        await user.reauthenticateWithCredential(credential);

        // Update the password
        await user.updatePassword(_newPasswordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Your password has been changed.'.tr),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.orange,
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to change password: $e'.tr),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _onSave() {
    if (_currentPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Current password cannot be empty'.tr),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_newPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('New password cannot be empty'.tr),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Confirm password cannot be empty'.tr),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('New password and confirm password do not match'.tr),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Proceed to change password if all validations are passed
    if (validateForm()) {
      _changePassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'.tr),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextFieldHeader('Current Password'),
              TextField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  hintText: 'Enter current password',
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isCurrentPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                      });
                    },
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(),
                ),
                obscureText: !_isCurrentPasswordVisible,
              ),
              const SizedBox(height: 16.0),
              _buildTextFieldHeader('New Password'),
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  hintText: 'Enter new password',
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(),
                ),
                obscureText: !_isNewPasswordVisible,
              ),
              const SizedBox(height: 16.0),
              _buildTextFieldHeader('Confirm Password'),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirm new password',
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(),
                ),
                obscureText: !_isConfirmPasswordVisible,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _onSave,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  minimumSize: const Size(double.infinity, 50.0),
                ),
                child: Text('Save'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text.tr,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Color(0xFF00008B),
          ),
        ),
      ),
    );
  }
}
