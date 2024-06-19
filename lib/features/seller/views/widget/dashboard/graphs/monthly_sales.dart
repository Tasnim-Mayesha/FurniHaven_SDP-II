import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlySalesBarChart extends StatelessWidget {
  const MonthlySalesBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
                toY: 8, color: Colors.blue) // Changed 'colors' to 'color' here
          ]),
          // Add more groups for each month
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
                toY: 10, color: Colors.red) // Example for another month
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(toY: 5, color: Colors.green) // Another example
          ]),
          // Continue adding data for up to 12 months
        ],
        alignment: BarChartAlignment.spaceAround,
        titlesData: const FlTitlesData(show: true),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
      ),
    );
  }
}
