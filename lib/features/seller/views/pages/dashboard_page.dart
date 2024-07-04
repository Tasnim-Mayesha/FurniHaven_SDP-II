import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/monthly_sales.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/today_sales.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/yearly_growth.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/total_profit_sales.dart';

import 'package:sdp2/features/seller/views/widget/dashboard/graphs/today_sales_dialog.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/yearly_growth_dialog.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/monthly_sales_dialog.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                const EdgeInsets.only(bottom: 20.0), // Add some padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back!'.tr,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Hi, Mr. Shovo'.tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
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
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const TodaySalesDialog();
                                },
                              );
                            },
                            child: const TodaySalesPieChart(),
                          ),
                          height: 230,
                        ),
                        const SizedBox(height: 10),
                        _buildDashboardContainer(
                          context: context,
                          iconData: Icons.show_chart,
                          title: "Yearly Growth",
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const YearlyGrowthDialog();
                                },
                              );
                            },
                            child: const YearlyGrowthLineChart(),
                          ),
                          height: 250,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDashboardContainer(
                          context: context,
                          iconData: Icons.bar_chart,
                          title: "Monthly Sales",
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const MonthlySalesDialog();
                                },
                              );
                            },
                            child: const MonthlySalesBarChart(),
                          ),
                          height: 300,
                        ),
                        const SizedBox(height: 10),
                        _buildDashboardContainer(
                          context: context,
                          iconData: Icons.attach_money,
                          title: "Total Sales",
                          child: const TotalSalesBox(),
                          height: 150,
                        ),
                        const SizedBox(height: 10),
                        _buildDashboardContainer(
                          context: context,
                          iconData: Icons.money_off,
                          title: "Total Profit",
                          child: const TotalProfitBox(),
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ],
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 8), // Matching top and left padding
            leading: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(
                    0xFFFAFAFA), // Light grey color for the icon background
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  // Soft shadow for the icon
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Icon(iconData, color: Theme.of(context).primaryColor),
            ),
            title: Text(title.tr),
            horizontalTitleGap: 10,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
