import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerChangePassword extends StatefulWidget {
  const SellerChangePassword({super.key});

  @override
  _SellerChangePasswordState createState() => _SellerChangePasswordState();
}

class _SellerChangePasswordState extends State<SellerChangePassword> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _currentPasswordFocus = FocusNode();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  bool _isCurrentPasswordFocused = false;
  bool _isNewPasswordFocused = false;
  bool _isConfirmPasswordFocused = false;
  bool _isNewPasswordValid = false;
  bool _isConfirmPasswordValid = false;
  bool _isCurrentPasswordValid = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordFocus.addListener(() {
      setState(() {
        _isCurrentPasswordFocused = _currentPasswordFocus.hasFocus;
      });
    });
    _newPasswordFocus.addListener(() {
      setState(() {
        _isNewPasswordFocused = _newPasswordFocus.hasFocus;
      });
    });
    _confirmPasswordFocus.addListener(() {
      setState(() {
        _isConfirmPasswordFocused = _confirmPasswordFocus.hasFocus;
      });
    });
    _currentPasswordController.addListener(validatePasswords);
    _newPasswordController.addListener(validatePasswords);
    _confirmPasswordController.addListener(validatePasswords);
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void validatePasswords() {
    setState(() {
      _isCurrentPasswordValid = _currentPasswordController.text.isNotEmpty &&
          _currentPasswordController.text.length >= 6;
      _isNewPasswordValid = _newPasswordController.text.isNotEmpty &&
          _newPasswordController.text.length >= 6 &&
          _newPasswordController.text == _confirmPasswordController.text &&
          _newPasswordController.text != _currentPasswordController.text;
      _isConfirmPasswordValid = _confirmPasswordController.text.isNotEmpty &&
          _confirmPasswordController.text.length >= 6 &&
          _newPasswordController.text == _confirmPasswordController.text &&
          _confirmPasswordController.text != _currentPasswordController.text;
    });
  }

  bool validateForm() {
    return _isCurrentPasswordValid && _isNewPasswordValid && _isConfirmPasswordValid;
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextFieldHeader('Current Password'),
            TextField(
              controller: _currentPasswordController,
              focusNode: _currentPasswordFocus,
              decoration: InputDecoration(
                hintText: 'Enter current password',
                prefixIcon: Icon(
                  Icons.lock,
                  color: _isCurrentPasswordFocused ? Colors.deepOrange : Colors.grey,
                ),
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            _buildTextFieldHeader('New Password'),
            TextField(
              controller: _newPasswordController,
              focusNode: _newPasswordFocus,
              decoration: InputDecoration(
                hintText: 'Enter new password',
                prefixIcon: Icon(
                  Icons.lock,
                  color: _isNewPasswordFocused ? Colors.deepOrange : Colors.grey,
                ),
                suffixIcon: _newPasswordController.text.isNotEmpty
                    ? _isNewPasswordValid
                    ? const Icon(Icons.check, color: Colors.green)
                    : const Icon(Icons.close, color: Colors.red)
                    : null,
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            _buildTextFieldHeader('Confirm Password'),
            TextField(
              controller: _confirmPasswordController,
              focusNode: _confirmPasswordFocus,
              decoration: InputDecoration(
                hintText: 'Confirm new password',
                prefixIcon: Icon(
                  Icons.lock,
                  color: _isConfirmPasswordFocused ? Colors.deepOrange : Colors.grey,
                ),
                suffixIcon: _confirmPasswordController.text.isNotEmpty
                    ? _isConfirmPasswordValid
                    ? const Icon(Icons.check, color: Colors.green)
                    : const Icon(Icons.close, color: Colors.red)
                    : null,
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            if (validateForm())
              ButtonTheme(
                height: 50.0,
                minWidth: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle update action
                    print('Changed Password: ${_newPasswordController.text}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Your Password has been Changed'.tr),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.grey,
                      ),
                    );
                    Navigator.pop(context);
                  },
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
