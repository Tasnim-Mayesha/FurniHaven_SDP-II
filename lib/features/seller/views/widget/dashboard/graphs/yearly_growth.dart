import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YearlyGrowthLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 3),
              FlSpot(1, 4),
              FlSpot(2, 5),
              FlSpot(3, 5),
              // Add more data points for each year
            ],
            isCurved: true,
          ),
        ],
      ),
    );
  }
}
