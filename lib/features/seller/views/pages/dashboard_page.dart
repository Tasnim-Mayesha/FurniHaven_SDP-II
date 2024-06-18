import 'package:flutter/material.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/monthly_sales.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/today_sales.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/yearly_growth.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/total_profit_sales.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Welcome Back!'),
            Text(
              'Hi, Mr. Shovo',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDashboardContainer(
                      context: context,
                      iconData: Icons.pie_chart,
                      title: "Today's Sale",
                      child: TodaySalesPieChart(),
                      height: 230,
                    ),
                    SizedBox(height: 10),
                    _buildDashboardContainer(
                      context: context,
                      iconData: Icons.show_chart,
                      title: "Yearly Growth",
                      child: YearlyGrowthLineChart(),
                      height: 250,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDashboardContainer(
                      context: context,
                      iconData: Icons.bar_chart,
                      title: "Monthly Sales",
                      child: MonthlySalesBarChart(),
                      height: 300,
                    ),
                    SizedBox(height: 10),
                    _buildDashboardContainer(
                      context: context,
                      iconData: Icons.attach_money,
                      title: "Total Sales",
                      child: TotalSalesBox(),
                      height: 150,
                    ),
                    SizedBox(height: 10),
                    _buildDashboardContainer(
                      context: context,
                      iconData: Icons.money_off,
                      title: "Total Profit",
                      child: TotalProfitBox(),
                      height: 150,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContainer({
    required BuildContext context,
    required IconData iconData,
    required String title,
    required Widget child,
    required double height,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 8), // Matching top and left padding
            leading: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(
                    0xFFFAFAFA), // Light grey color for the icon background
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  // Soft shadow for the icon
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Icon(iconData, color: Theme.of(context).primaryColor),
            ),
            title: Text(title),
            horizontalTitleGap: 10,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
