import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/personilization/screen/address/widgets/map.dart';
import '../../../../utils/global_colors.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late DocumentReference userDocRef;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      userDocRef = _firestore.collection('Users').doc(user.uid);
      final userDoc = await userDocRef.get();
      if (userDoc.exists) {
        setState(() {
          _nameController.text = userDoc['userName'] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'.tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an address';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.map, color: GlobalColors.mainColor),
                    onPressed: () async {
                      final result = await Get.to(() => SelectAddressPage());
                      if (result != null) {
                        setState(() {
                          _addressController.text = result;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  if (value.length != 11) {
                    return 'Phone number must be 11 digits and start with 01';
                  }
                  if (!value.startsWith('01')) {
                    return 'Phone number must start with "01"';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _saveAddressAndPhone();
                    // Return the new address and phone to the previous screen
                    Navigator.pop(context, {
                      'address': _addressController.text,
                      'phone': _phoneController.text,
                      'name': _nameController.text,
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: GlobalColors.mainColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text('Save'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAddressAndPhone() async {
    final String address = _addressController.text;
    final String phone = _phoneController.text;

    await userDocRef.update({
      'addresses': FieldValue.arrayUnion([address]),
      'phones': FieldValue.arrayUnion([phone]),
    });
  }
}
