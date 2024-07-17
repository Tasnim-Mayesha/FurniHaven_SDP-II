import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/utils/global_colors.dart';
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

  void _deleteAddress(int index) {
    setState(() {
      addresses.removeAt(index);
      if (_selectedAddressIndex == index) {
        _selectedAddressIndex = null;
      } else if (_selectedAddressIndex != null && _selectedAddressIndex! > index) {
        _selectedAddressIndex = _selectedAddressIndex! - 1;
      }
      Get.snackbar(
        'Deleted',
        'Address deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    });
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
      final totalCost = Get.arguments['totalCost'] as double;
      Get.to(() => const Payment(), arguments: {
        'totalCost': totalCost,
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
}
