import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import '../product/product_page.dart';

class ChairPage extends StatelessWidget {
  const ChairPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chairs'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(const ProductPage());
          },
          child: const Text('Go to Product Page'),
        ),
      ),
    );
  }
}
