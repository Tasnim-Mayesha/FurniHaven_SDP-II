import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import '../product/product_page.dart';

class ChairPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chairs'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(ProductPage());
          },
          child: Text('Go to Product Page'),
        ),
      ),
    );
  }
}
