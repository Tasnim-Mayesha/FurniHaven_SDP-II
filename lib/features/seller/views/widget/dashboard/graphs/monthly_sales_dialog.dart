import 'package:flutter/material.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/monthly_sales.dart';

class MonthlySalesDialog extends StatelessWidget {
  const MonthlySalesDialog({super.key});

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
      _buildLegendItem(Colors.red, "January"),
      _buildLegendItem(Colors.blue, "February"),
      _buildLegendItem(Colors.green, "March"),
    ];

    return AlertDialog(
      title: const Text("Monthly Sales"),
      content: SizedBox(
        height: 450, // Adjusted height to accommodate the legend
        width: 300,
        child: Column(
          children: [
            // Legend
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: legendItems,
              ),
            ),
            // Chart
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: const MonthlySalesBarChart(),
              ),
            ),
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
