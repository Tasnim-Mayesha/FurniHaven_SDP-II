import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/message/chat_with_seller.dart';
import 'package:sdp2/features/seller/views/chat/controller/chat_list_controller.dart';

class SellerMessageList extends StatelessWidget {
  const SellerMessageList({super.key});

  @override
  Widget build(BuildContext context) {
    final SellerMessageListController controller = Get.put(SellerMessageListController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Obx(() => ListView.builder(
              itemCount: controller.brands.length,
              itemBuilder: (context, index) {
                final brand = controller.brands[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        brand['image'] ?? 'assets/default_image.png'),
                  ),
                  title: Text(brand['name'] ?? 'Unknown Brand'),
                  trailing: Text(brand['time'] ?? 'N/A'),
                  onTap: () {
                    Get.to(() => ChatWithSeller(
                          brandImage:
                              brand['image'] ?? 'assets/default_image.png',
                          brandName: brand['name'] ?? 'Unknown Brand',
                        ));
                  },
                );
              },
            )),
      ),
    );
  }
}
