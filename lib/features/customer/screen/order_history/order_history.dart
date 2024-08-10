import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sdp2/utils/global_colors.dart';

import '../product/product_page.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  Future<Map<String, List<Map<String, dynamic>>>> _fetchOrderHistory() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return {};

    final QuerySnapshot ordersSnapshot = await FirebaseFirestore.instance
        .collection('Orders')
        .where('userID', isEqualTo: currentUser.uid)
        .get();

    Map<String, List<Map<String, dynamic>>> groupedOrders = {};

    for (QueryDocumentSnapshot orderDoc in ordersSnapshot.docs) {
      final Map<String, dynamic> orderData = orderDoc.data() as Map<String, dynamic>;
      final String productId = orderData['productID'];
      final DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .get();
      final productData = productSnapshot.data() as Map<String, dynamic>;

      // Fetch brandName from Sellers collection
      final sellerEmail = productData['sellerEmail'];
      final QuerySnapshot sellerSnapshot = await FirebaseFirestore.instance
          .collection('Sellers')
          .where('email', isEqualTo: sellerEmail)
          .get();

      String brandName = '';
      if (sellerSnapshot.docs.isNotEmpty) {
        brandName = sellerSnapshot.docs.first['brandName'];
      }

      // Convert timestamp to formatted date
      final DateTime dateTime = (orderData['timestamp'] as Timestamp).toDate();
      final String formattedDate = DateFormat('yMMMMd').add_jm().format(dateTime);

      // Group orders by formatted date
      if (!groupedOrders.containsKey(formattedDate)) {
        groupedOrders[formattedDate] = [];
      }
      groupedOrders[formattedDate]!.add({
        'orderData': orderData,
        'productData': productData,
        'brandName': brandName,
        'timestamp': dateTime,  // Keep the timestamp for sorting
      });
    }

    // Sort orders by timestamp in descending order
    final sortedEntries = groupedOrders.entries.toList()
      ..sort((a, b) => b.value.first['timestamp'].compareTo(a.value.first['timestamp']));

    // Rebuild the map with sorted entries
    final sortedGroupedOrders = Map<String, List<Map<String, dynamic>>>.fromEntries(sortedEntries);

    return sortedGroupedOrders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
        future: _fetchOrderHistory(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, List<Map<String, dynamic>>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching order history'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final String dateKey = snapshot.data!.keys.elementAt(index);
                final List<Map<String, dynamic>> orders = snapshot.data![dateKey]!;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey[200],
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dateKey,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          ...orders.map((orderMap) {
                            final order = orderMap['orderData'];
                            final product = orderMap['productData'];
                            final brandName = orderMap['brandName'];

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        product['imageUrl'],
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product['title'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                            const SizedBox(height: 4),
                                            Text('Brand: $brandName',
                                                style: TextStyle(color: Colors.orange)),
                                            const SizedBox(height: 4),
                                            Text('Quantity: ${order['quantity']}'),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Text(
                                                  '${(order['price'] * order['quantity']) + 240} tk',
                                                  style: TextStyle(
                                                      color: Colors.blueAccent,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '${product['price'] * order['quantity'] + 240} tk',
                                                  style: const TextStyle(
                                                    decoration: TextDecoration.lineThrough,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: GlobalColors.mainColor, // Background color
                                    ),
                                    onPressed: () {
                                      Get.to(() => ProductPage(
                                        imageUrl: product['imageUrl'] as String? ?? '',
                                        productName: product['title'] as String? ?? 'Unknown',
                                        brandName: brandName as String? ?? 'Unknown', // Use fetched brandName
                                        discount: (product['discount'] as num?)?.toInt() ?? 0,
                                        originalPrice: (product['price'] as num?)?.toInt() ?? 0,
                                        discountedPrice: (product['price'] * (1 - (product["discount"] / 100)))
                                            .round(),
                                        rating: (product['rating'] as num?)?.toDouble() ?? 0.0,
                                        modelUrl: product['modelUrl'] as String? ?? '',
                                        description: product['description'] as String? ?? '',
                                        sellerEmail: product['sellerEmail'] as String? ?? 'Unknown',
                                        id: product['id'] as String? ?? '',
                                        scrollToReview: true,
                                      ));
                                    },
                                    child: const Text('Review'),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order Status: Pending',
                                        style: const TextStyle(color: Colors.blue),
                                      ),
                                      Text(
                                        'Payment: ${order['paymentMethod']}',
                                        style: const TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
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
