import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegalPage extends StatelessWidget {
  const RegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regal'.tr),
      ),
      body: Center(
        child: Text('Regal'.tr),
      ),
    );
  }
}

