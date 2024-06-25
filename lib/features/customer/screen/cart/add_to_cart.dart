import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/cart/widget/add_remove_button.dart';
import 'package:sdp2/features/customer/screen/cart/widget/cart_item.dart';
import '../../../../utils/global_colors.dart';
import '../shipping/shipping.dart';

class CartController extends GetxController {
  var cartItems = [
    {
      'imageUrl': 'assets/products/ar_chair.png',
      'productName': 'Aesthetic Fabric Blue Chair',
      'brandName': 'Hatil',
      'quantity': 2,
      'price': 7000.0,
    },
    {
      'imageUrl': 'assets/products/Eve Fabric Dhouble Chair.png',
      'productName': 'Eve Fabric Dhouble Chair',
      'brandName': 'Regal',
      'quantity': 1,
      'price': 15000.0,
    },
    {
      'imageUrl': 'assets/products/study table.png',
      'productName': 'Modern Study Table',
      'brandName': 'Brothers',
      'quantity': 3,
      'price': 55000.0,
    },
    {
      'imageUrl': 'assets/products/Round Dining Table.png',
      'productName': 'Round Dining Table ',
      'brandName': 'Otobi',
      'quantity': 1,
      'price': 120000.0,
    },
  ].obs;

  double get totalAmount => cartItems.fold(0, (sum, item) {
    return sum + (item['price'] as double?)! * (item['quantity'] as int?)!;
  });

  void addItem(int index) {
    cartItems[index]['quantity'] = (cartItems[index]['quantity'] as int?)! + 1;
    cartItems.refresh();
  }

  void removeItem(int index) {
    if ((cartItems[index]['quantity'] as int?)! > 0) {
      cartItems[index]['quantity'] = (cartItems[index]['quantity'] as int?)! - 1;
    }
    cartItems.refresh();
  }

  void deleteItem(int index) {
    cartItems.removeAt(index);
    cartItems.refresh();
  }
}

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(height: 32),
            itemCount: controller.cartItems.length,
            itemBuilder: (_, index) {
              final item = controller.cartItems[index];
              return Column(
                children: [
                  CartItem(
                    onDelete: () => controller.deleteItem(index),
                    imageUrl: item['imageUrl'] as String,
                    productName: item['productName'] as String,
                    brandName: item['brandName'] as String,
                    quantity: (item['quantity'] as int?)!,
                    price: (item['price'] as double?)!,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 70),
                          AddRemoveButton(
                            onAdd: () => controller.addItem(index),
                            onRemove: () => controller.removeItem(index),
                            count: (item['quantity'] as int?)!,
                          ),
                        ],
                      ),
                      Text(
                        '${(item['price'] as double?)! * (item['quantity'] as int?)!} Tk',
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }),
      ),
      floatingActionButton: Obx(() {
        return SizedBox(
          width: 320,
          height: 50,
          child: FloatingActionButton.extended(
            onPressed: () {
              Get.to(const ShippingPage());
            },
            label: Text(
              'Checkout (${controller.totalAmount} Tk)',
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            backgroundColor: GlobalColors.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
        );
      }),
    );
  }
}
