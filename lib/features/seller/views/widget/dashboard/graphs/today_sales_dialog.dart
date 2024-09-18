import 'package:flutter/material.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/today_sales.dart';

class TodaySalesDialog extends StatelessWidget {
  final int soldProducts;
  final int unsoldProducts;

  const TodaySalesDialog({
    required this.soldProducts,
    required this.unsoldProducts,
    Key? key,
  }) : super(key: key);

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Example legend items; replace with your actual data
    final legendItems = [
      _buildLegendItem(Colors.yellow, "Products Unsold"),
      _buildLegendItem(Colors.orange, "Products Sold"),
    ];

    return AlertDialog(
      title: const Text("Today's Sales"),
      content: SizedBox(
        height: 450, // Adjusted height to accommodate the legend
        width: 300,
        child: Column(
          children: [
            // Legend
            Padding(
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: legendItems,
              ),
            ),
            // Chart
            Expanded(
                child: TodaySalesPieChart(
              soldProducts: soldProducts,
              unsoldProducts: unsoldProducts,
            )),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
