import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/appbar/custom_appbar_in.dart';
import '../../../../common/widgets/bottomnavbar/bottom_nav_bar.dart';
import 'chat_with_seller.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: customAppBarIn(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ListView(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/brands/otobi.png'), // Replace with your image asset
              ),
              title: Text('Otobi'.tr),
              trailing: Text('12:20'.tr),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatWithSeller(
                      brandImage: 'assets/brands/otobi.png', // Pass the image asset
                      brandName: 'Otobi'.tr, // Pass the brand name
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/brands/regal.png'), // Replace with your image asset
              ),
              title: Text('regal'.tr),
              trailing: Text('12:20'.tr),
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
              title: Text('Hatil'.tr),
              trailing: Text('12:20'.tr),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatWithSeller(
                      brandImage: 'assets/brands/hatil.png', // Pass the image asset
                      brandName: 'Hatil'.tr, // Pass the brand name
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      //bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

