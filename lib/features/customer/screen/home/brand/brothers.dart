import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrothersPage extends StatelessWidget {
  const BrothersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brothers'.tr),
      ),
      body:  Center(
        child: Text('Brothers'.tr),
      ),
    );
  }
}

