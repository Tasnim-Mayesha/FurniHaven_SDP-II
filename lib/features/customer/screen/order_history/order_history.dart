import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/product/product_page.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'.tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            OrderItem(),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/products/ar_chair.png',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Luxury Chair'.tr,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text('Brand: Regal'.tr),
                      Text('Quantity: 1'.tr),
                      Row(
                        children: [
                          Text(
                            '10,000 tk'.tr,
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '12,400 tk'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '24% Off'.tr,
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text('11:40 A.M. 23/05/2024'.tr),
            Text(
              'Order Status: Processing'.tr,
              style: TextStyle(color: Colors.red),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(()=> const ProductPage(imageUrl: '', productName: 'Chair', brandName: 'Regal', discount: 10, originalPrice: 10000, discountedPrice: 8000, rating: 4, modelUrl: 'assets/product3d/office_chair.glb',));
                  // Navigate to ProductPage or any other page as needed
                },
                child: Text('Review'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
