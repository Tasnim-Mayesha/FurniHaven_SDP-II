import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/monthly_sales.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/today_sales.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/yearly_growth.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/today_sales_dialog.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/yearly_growth_dialog.dart';
import 'package:sdp2/features/seller/views/widget/dashboard/graphs/monthly_sales_dialog.dart';
import 'package:sdp2/features/seller/views/pages/controllers/dashboard_controller.dart';

import '../../authentication_seller/screen/login/login_view.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardController dashboardController = Get.put(DashboardController());
  String sellerName = '';
  bool isLoggedIn = false; // To track if the seller is logged in

  @override
  void initState() {
    super.initState();
    _getSellerName();
  }

  Future<void> _getSellerName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        setState(() {
          isLoggedIn = true;
        });

        // Get the current seller ID
        String sellerId = user.uid;

        // Fetch the seller's name from the 'Sellers' collection
        DocumentSnapshot sellerDoc = await FirebaseFirestore.instance
            .collection('Sellers')
            .doc(sellerId)
            .get();

        if (sellerDoc.exists) {
          setState(() {
            sellerName = sellerDoc['sellerName'];
          });
        }
      } else {
        setState(() {
          isLoggedIn = false; // Seller is not logged in
        });
      }
    } catch (e) {
      print('Error fetching seller name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoggedIn ? _buildDashboardContent() : _buildLoginButton(), // Check login status
    );
  }

  Widget _buildLoginButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Get.to(() =>  SellerLoginView()); // Navigate to SellerLoginView
        },
        child: const Text("Login"),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20.0),
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
                    'Hi, $sellerName',
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
                      Obx(() {
                        if (dashboardController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return _buildDashboardContainer(
                            context: context,
                            iconData: Icons.pie_chart,
                            title: "Sales",
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return TodaySalesDialog(
                                      soldProducts: dashboardController
                                          .soldProductsCount
                                          .value, // Pass sold products
                                      unsoldProducts: dashboardController
                                          .unsoldProductsCount.value,
                                    );
                                  },
                                );
                              },
                              child: TodaySalesPieChart(
                                soldProducts: dashboardController
                                    .soldProductsCount.value,
                                unsoldProducts: dashboardController
                                    .unsoldProductsCount.value,
                              ),
                            ),
                            height: 230,
                          );
                        }
                      }),
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
                      Obx(() {
                        return _buildDashboardContainer(
                          context: context,
                          iconData: Icons.attach_money,
                          title: "Total Sales",
                          child: Text(
                            '${dashboardController.totalSales.value.toStringAsFixed(2)} Tk', // Ensure you format double values to 2 decimal places
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          height: 150,
                        );
                      }),
                      const SizedBox(height: 10),
                      Obx(() {
                        return _buildDashboardContainer(
                          context: context,
                          iconData: Icons.money_off,
                          title: "Total Profit",
                          child: Text(
                            '${dashboardController.totalProfit.value.toStringAsFixed(2)} Tk', // Display profit with two decimal places
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          height: 150,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ],
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
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 8), // Matching padding
            leading: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color:
                const Color(0xFFFAFAFA), // Light grey for icon background
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(iconData, color: Theme.of(context).primaryColor),
            ),
            title: Text(title.tr),
            horizontalTitleGap: 10,
          ),
          Expanded(child: Center(child: child)),
        ],
      ),
    );
  }
}
