import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../utils/global_colors.dart';
import '../../../personilization/model/user_models.dart';
import '../../../personilization/screen/address/address_page.dart';
import '../../../personilization/screen/address/widgets/address_card.dart';
import '../Payment/payment.dart';

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  _ShippingPageState createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  List<Map<String, String>> addresses = [];
  int? _selectedAddressIndex;

  double totalCost = 0.0;
  List<dynamic> cartItems = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>;
    totalCost = arguments['totalCost'] as double;
    cartItems = arguments['cartItems'] as List<dynamic>;
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

          // Ensure both lists are of equal length by filling with empty strings if necessary
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

          // Remove the address and corresponding phone
          updatedAddresses.removeAt(index);
          updatedPhones.removeAt(index);

          // Update Firestore
          await userDocRef.update({
            'addresses': updatedAddresses,
            'phones': updatedPhones,
          });

          // Update local state
          setState(() {
            addresses.removeAt(index);
            if (_selectedAddressIndex == index) {
              _selectedAddressIndex = null;
            } else if (_selectedAddressIndex != null && _selectedAddressIndex! > index) {
              _selectedAddressIndex = _selectedAddressIndex! - 1;
            }
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

  void _selectAddress(int index) {
    setState(() {
      _selectedAddressIndex = index;
    });
  }

  void _navigateToPayment() {
    if (addresses.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add an address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } else if (_selectedAddressIndex == null) {
      Get.snackbar(
        'Error',
        'Please select an address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } else {
      Get.to(() => const Payment(), arguments: {
        'totalCost': totalCost,
        'cartItems': cartItems,
        'selectedAddress': addresses[_selectedAddressIndex!],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ship To'.tr),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return AddressCard(
                  address: addresses[index],
                  isSelected: index == _selectedAddressIndex,
                  onSelect: () => _selectAddress(index),
                  onDelete: () => _deleteAddress(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _navigateToPayment,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: GlobalColors.mainColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text('Next'.tr),
            ),
          ),
        ],
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
