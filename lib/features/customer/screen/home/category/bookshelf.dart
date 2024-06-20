import 'package:flutter/material.dart';

class BookShelfPage extends StatelessWidget {
  const BookShelfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookshelf'),
      ),
      body: const Center(
        child: Text('Bookshelf Page'),
      ),
    );
  }
}

