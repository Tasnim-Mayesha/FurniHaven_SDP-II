import 'package:flutter/material.dart';

class CupboardPage extends StatelessWidget {
  const CupboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupboards'),
      ),
      body: const Center(
        child: Text('Cupboard Page'),
      ),
    );
  }
}

