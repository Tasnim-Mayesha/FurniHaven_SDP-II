import 'package:flutter/material.dart';
import 'chat_with_seller.dart';

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/brands/otobi.png'), // Replace with your image asset
            ),
            title: Text('Otobi'),
            trailing: Text('12:20'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatWithSeller(
                    brandImage: 'assets/brands/otobi.png', // Pass the image asset
                    brandName: 'Otobi', // Pass the brand name
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/brands/regal.png'), // Replace with your image asset
            ),
            title: Text('regal'),
            trailing: Text('12:20'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatWithSeller(
                    brandImage: 'assets/brands/regal.png', // Pass the image asset
                    brandName: 'Regal', // Pass the brand name
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/brands/hatil.png'), // Replace with your image asset
            ),
            title: Text('Hatil'),
            trailing: Text('12:20'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatWithSeller(
                    brandImage: 'assets/brands/hatil.png', // Pass the image asset
                    brandName: 'Hatil', // Pass the brand name
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

