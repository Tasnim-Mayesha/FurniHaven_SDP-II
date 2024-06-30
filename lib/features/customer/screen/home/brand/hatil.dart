import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HatilPage extends StatelessWidget {
  const HatilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hatil'.tr),
      ),
      body: Center(
        child: Text('Hatil'.tr),
      ),
    );
  }
}

