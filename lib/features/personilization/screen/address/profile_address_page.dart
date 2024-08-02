import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdp2/features/personilization/screen/address/widgets/profile_address_card.dart';

import '../../../personilization/model/user_models.dart';
import '../../../personilization/screen/address/address_page.dart';

class ProfileAddressPage extends StatefulWidget {
  const ProfileAddressPage({super.key});

  @override
  _ProfileAddressPageState createState() => _ProfileAddressPageState();
}

class _ProfileAddressPageState extends State<ProfileAddressPage> {
  List<Map<String, String>> addresses = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    _fetchUserAddresses();
  }

  Future<void> _fetchUserAddresses() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final userDocRef = _firestore.collection('Users').doc(user.uid);
      final userDoc = await userDocRef.get();
      if (userDoc.exists) {
        setState(() {
          userModel = UserModel.fromSnapshot(userDoc);

          int maxLength = userModel.addresses.length > userModel.phones.length
              ? userModel.addresses.length
              : userModel.phones.length;

          addresses = List.generate(maxLength, (index) {
            final address = index < userModel.addresses.length
                ? userModel.addresses[index]
                : '';
            final phone = index < userModel.phones.length
                ? userModel.phones[index]
                : '';

            return {
              'address': address,
              'name': userModel.userName,
              'phone': phone,
            };
          });
        });
      }
    }
  }

  void _deleteAddress(int index) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final userDocRef = _firestore.collection('Users').doc(user.uid);

      try {
        final userDoc = await userDocRef.get();
        if (userDoc.exists) {
          final List<String> updatedAddresses = List.from(userModel.addresses);
          final List<String> updatedPhones = List.from(userModel.phones);

          updatedAddresses.removeAt(index);
          updatedPhones.removeAt(index);

          await userDocRef.update({
            'addresses': updatedAddresses,
            'phones': updatedPhones,
          });

          setState(() {
            addresses.removeAt(index);
          });

          Get.snackbar(
            'Deleted',
            'Address and phone number deleted successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to delete address and phone number',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  void _editAddress(int index) {
    final TextEditingController addressController =
    TextEditingController(text: addresses[index]['address']);
    final TextEditingController phoneController =
    TextEditingController(text: addresses[index]['phone']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                final User? user = _auth.currentUser;
                if (user != null) {
                  final userDocRef = _firestore.collection('Users').doc(user.uid);

                  try {
                    final userDoc = await userDocRef.get();
                    if (userDoc.exists) {
                      final List<String> updatedAddresses = List.from(userModel.addresses);
                      final List<String> updatedPhones = List.from(userModel.phones);

                      updatedAddresses[index] = addressController.text;
                      updatedPhones[index] = phoneController.text;

                      await userDocRef.update({
                        'addresses': updatedAddresses,
                        'phones': updatedPhones,
                      });

                      setState(() {
                        addresses[index]['address'] = addressController.text;
                        addresses[index]['phone'] = phoneController.text;
                      });

                      Navigator.of(context).pop();

                      Get.snackbar(
                        'Updated',
                        'Address and phone number updated successfully',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      );
                    }
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      'Failed to update address and phone number',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addresses'.tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newAddress = await Get.to(const AddAddressPage());
              if (newAddress != null) {
                _addAddress(newAddress);
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return ProfileAddressCard(
            address: addresses[index],
            onDelete: () => _deleteAddress(index),
            onEdit: () => _editAddress(index),
          );
        },
      ),
    );
  }

  void _addAddress(Map<String, String> newAddress) {
    setState(() {
      addresses.add(newAddress);
      Get.snackbar(
        'Success',
        'Address added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    });
  }
}
