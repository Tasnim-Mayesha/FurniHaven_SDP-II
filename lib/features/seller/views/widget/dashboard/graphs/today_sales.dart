import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sdp2/utils/global_colors.dart';

class TodaySalesPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        PieChart(
          PieChartData(
            centerSpaceRadius: 40,
            sections: [
              PieChartSectionData(
                value: 70, // example percentage of sold products
                color: GlobalColors.mainColor,
                title: '2520',
              ),
              PieChartSectionData(
                value: 30, // example percentage of unsold products
                color: GlobalColors.secondary,
                title: '1080',
              ),
            ],
            sectionsSpace: 0,
            borderData: FlBorderData(show: false),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min, // Use min size for the content
          children: <Widget>[
            Text(
              'Products:',
              style: TextStyle(
                fontSize: 16, // Adjust the font size as needed
                fontWeight: FontWeight.w200, // Optional: change the font weight
                color: Colors.black, // Adjust the text color as needed
              ),
            ),
            Text(
              '3600',
              style: TextStyle(
                fontSize: 16, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Optional: change the font weight
                color: Colors.black, // Adjust the text color as needed
              ),
            ),
          ],
        ),
      ],
    );
  }
}
