import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YearlyGrowthLineChart extends StatelessWidget {
  const YearlyGrowthLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 3),
              const FlSpot(1, 4),
              const FlSpot(2, 5),
              const FlSpot(3, 5),
              // Add more data points for each year
            ],
            isCurved: true,
          ),
        ],
      ),
    );
  }
}
