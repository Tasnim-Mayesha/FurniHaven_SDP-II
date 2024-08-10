import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortBy extends StatefulWidget {
  const SortBy({super.key});

  @override
  _SortByState createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  String? _selectedOption = 'none'; // Initial selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sort By'.tr,
          style: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 10.0),
              child: Text(
                'Best Match'.tr,
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  RadioListTile<String>(
                    title: Text('New arrivals'.tr),
                    value: 'New arrivals',
                    groupValue: _selectedOption,
                    activeColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Discount'.tr),
                    value: 'Discount',
                    groupValue: _selectedOption,
                    activeColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Price: Low to High'.tr),
                    value: 'PriceLtH',
                    groupValue: _selectedOption,
                    activeColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Price: High to Low'.tr),
                    value: 'PriceHtL',
                    groupValue: _selectedOption,
                    activeColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Pass the selected option back to the previous page
                        Get.back(result: _selectedOption);
                      },
                      child: Text('Apply'.tr),
                    ),
                  ),
                ],
              ),
            ),
          ], //children
        ),
      ),
    );
  }
}