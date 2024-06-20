import 'package:flutter/material.dart';

class SofasPage extends StatelessWidget {
  const SofasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sofas'),
      ),
      body: const Center(
        child: Text('Sofas Page'),
      ),
    );
  }
}

