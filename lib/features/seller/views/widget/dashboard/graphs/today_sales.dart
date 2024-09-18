import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sdp2/utils/global_colors.dart';

class TodaySalesPieChart extends StatelessWidget {
  final int soldProducts;
  final int unsoldProducts;

  const TodaySalesPieChart({
    required this.soldProducts,
    required this.unsoldProducts,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalProducts = soldProducts + unsoldProducts;

    // Avoid division by zero and cast to double
    final double soldPercentage =
        totalProducts > 0 ? (soldProducts / totalProducts) * 100.0 : 0.0;
    final double unsoldPercentage =
        totalProducts > 0 ? (unsoldProducts / totalProducts) * 100.0 : 0.0;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        PieChart(
          PieChartData(
            centerSpaceRadius: 40,
            sections: [
              PieChartSectionData(
                value: soldPercentage, // Ensure value is double
                color: GlobalColors.mainColor,
                title: '$soldProducts', // You can keep the title as string
              ),
              PieChartSectionData(
                value: unsoldPercentage, // Ensure value is double
                color: GlobalColors.secondary,
                title: '$unsoldProducts', // You can keep the title as string
              ),
            ],
            sectionsSpace: 0,
            borderData: FlBorderData(show: false),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min, // Use min size for the content
          children: <Widget>[
            const Text(
              'Products:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              ),
            ),
            Text(
              '$totalProducts', // Total number of products
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
