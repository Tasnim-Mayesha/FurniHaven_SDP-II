import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/product/product_page.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            OrderItem(
              imageUrl: 'assets/luxury_chair.png',
              title: 'Luxury Chair',
              brand: 'Regal',
              price: '10,000 tk',
              oldPrice: '12,400 tk',
              discount: '24% Off',
              quantity: 1,
              orderTime: '11:40 A.M. 23/05/2024',
              status: 'Processing',
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String brand;
  final String price;
  final String oldPrice;
  final String discount;
  final int quantity;
  final String orderTime;
  final String status;

  const OrderItem({super.key, 
    required this.imageUrl,
    required this.title,
    required this.brand,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.quantity,
    required this.orderTime,
    required this.status,
  });

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
                  imageUrl,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text('Brand: $brand'),
                      Text('Quantity: $quantity'),
                      Row(
                        children: [
                          Text(
                            price,
                            style: const TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            oldPrice,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            discount,
                            style: const TextStyle(fontSize: 14, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(const ProductPage());
                  },
                  child: const Text('Review'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(orderTime),
            Text(
              'Order Status: $status',
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
