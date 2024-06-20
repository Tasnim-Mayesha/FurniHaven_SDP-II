import 'package:flutter/material.dart';

class ShoeRackPage extends StatelessWidget {
  const ShoeRackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoe Rack'),
      ),
      body: const Center(
        child: Text('Shoe Rack Page'),
      ),
    );
  }
}

