import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sdp2/utils/global_colors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  Future<List<Coupon>> fetchCoupons() async {
    List<Coupon> coupons = [];

    try {
      // Fetch all coupons
      QuerySnapshot couponsSnapshot = await FirebaseFirestore.instance.collection('coupons').get();

      // Fetch all sellers
      QuerySnapshot sellersSnapshot = await FirebaseFirestore.instance.collection('Sellers').get();
      Map<String, String> emailToBrandMap = {
        for (var doc in sellersSnapshot.docs) doc['email']: doc['brandName'],
      };

      // Match coupon email with seller email to get the brand name
      for (var doc in couponsSnapshot.docs) {
        Map<String, dynamic> couponData = doc.data() as Map<String, dynamic>;
        String brandName = emailToBrandMap[couponData['email']] ?? 'Unknown Brand';

        // Handle discount field which might be double or int
        num discount = couponData['discount'];
        coupons.add(Coupon.fromFirestore(couponData, brandName, discount));
      }
    } catch (e) {
      print("Error fetching coupons: $e");
      throw e;
    }

    return coupons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications",style: TextStyle(color: Colors.white),),
        backgroundColor: GlobalColors.mainColor,
      ),
      body: FutureBuilder<List<Coupon>>(
        future: fetchCoupons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching coupons: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No coupons available"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Coupon coupon = snapshot.data![index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      leading: Icon(Icons.local_offer, color: GlobalColors.mainColor, size: 40),
                      title: Text(
                        coupon.code,
                        style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            "${coupon.discount.toInt()}% off",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Brand: ${coupon.brandName}",
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Expiry Date: ${coupon.expiryDate.toLocal()}",
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Coupon {
  final String code;
  final num discount;
  final String email;
  final DateTime expiryDate;
  final String brandName;

  Coupon({
    required this.code,
    required this.discount,
    required this.email,
    required this.expiryDate,
    required this.brandName,
  });

  factory Coupon.fromFirestore(Map<String, dynamic> couponData, String brandName, num discount) {
    return Coupon(
      code: couponData['code'],
      discount: discount,
      email: couponData['email'],
      expiryDate: DateTime.parse(couponData['expiryDate']),
      brandName: brandName,
    );
  }
}
