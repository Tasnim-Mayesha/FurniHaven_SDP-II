import 'package:flutter/material.dart';

class BedsPage extends StatelessWidget {
  const BedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beds'),
      ),
      body: const Center(
        child: Text('Beds Page'),
      ),
    );
  }
}

