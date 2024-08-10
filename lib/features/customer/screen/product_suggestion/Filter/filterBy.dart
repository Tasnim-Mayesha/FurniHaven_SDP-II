import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/PriceRange/priceRange.dart';

class FilterBy extends StatefulWidget {
  const FilterBy({super.key});

  @override
  _FilterByState createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy> {
  RangeValues _selectedRange = const RangeValues(0, 10000); // Adjust initial range values

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter By'.tr,
          style: TextStyle(
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
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Price Range'.tr),
                    subtitle: PriceRange(
                      rangeValues: _selectedRange,
                      onChanged: (RangeValues newRange) {
                        setState(() {
                          _selectedRange = newRange;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(result: _selectedRange); // Pass the selected range back
                      },
                      child: Text("Apply".tr),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
