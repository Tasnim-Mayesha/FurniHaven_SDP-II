import 'package:flutter/material.dart';

class DiningPage extends StatelessWidget {
  const DiningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dinning'),
      ),
      body: const Center(
        child: Text('Dinning Page'),
      ),
    );
  }
}

