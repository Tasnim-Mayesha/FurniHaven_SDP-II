import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtobiPage extends StatelessWidget {
  const OtobiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otobi'.tr),
      ),
      body: Center(
        child: Text('Otobi'.tr),
      ),
    );
  }
}

