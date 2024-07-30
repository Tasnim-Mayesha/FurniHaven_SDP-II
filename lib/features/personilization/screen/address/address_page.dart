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
                    icon: Icon(Icons.map,color: GlobalColors.mainColor,),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.back(result: {
                      'name': _nameController.text,
                      'address': _addressController.text,
                      'phone': _phoneController.text,
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
}
