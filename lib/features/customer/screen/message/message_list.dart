import 'package:flutter/material.dart';
import 'chat_with_seller.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ListView(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/brands/otobi.png'), // Replace with your image asset
              ),
              title: const Text('Otobi'),
              trailing: const Text('12:20'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatWithSeller(
                      brandImage: 'assets/brands/otobi.png', // Pass the image asset
                      brandName: 'Otobi', // Pass the brand name
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/brands/regal.png'), // Replace with your image asset
              ),
              title: const Text('regal'),
              trailing: const Text('12:20'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatWithSeller(
                      brandImage: 'assets/brands/regal.png', // Pass the image asset
                      brandName: 'Regal', // Pass the brand name
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/brands/hatil.png'), // Replace with your image asset
              ),
              title: const Text('Hatil'),
              trailing: const Text('12:20'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatWithSeller(
                      brandImage: 'assets/brands/hatil.png', // Pass the image asset
                      brandName: 'Hatil', // Pass the brand name
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

