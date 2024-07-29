import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/customer/screen/cart/widget/add_remove_button.dart';
import 'package:sdp2/features/customer/screen/cart/widget/cart_item.dart';
import '../../../../utils/global_colors.dart';
import '../shipping/shipping.dart';
import 'controller/cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          double totalCost = controller.cartItems.fold(0.0, (sum, item) {
            return sum + ((item['price'] as num?) ?? 0) * ((item['quantity'] as int?) ?? 0);
          });

          return Column(
            children: [
              Expanded(
                child: controller.cartItems.isEmpty
                    ? Center(
                  child: Text(
                    'Your cart is empty'.tr,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
                    : ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => const SizedBox(height: 32),
                  itemCount: controller.cartItems.length,
                  itemBuilder: (_, index) {
                    final item = controller.cartItems[index];
                    return Column(
                      children: [
                        CartItem(
                          onDelete: () => controller.deleteItem(index),
                          imageUrl: (item['imageUrl'] as String?) ?? '',
                          productName: (item['productName'] as String?) ?? '',
                          brandName: (item['brandName'] as String?) ?? '',
                          quantity: (item['quantity'] as int?) ?? 0,
                          price: ((item['price'] as num?) ?? 0.0).toDouble(),
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
                                  count: (item['quantity'] as int?) ?? 0,
                                ),
                              ],
                            ),
                            Text(
                              '${(((item['price'] as num?) ?? 0) * ((item['quantity'] as int?) ?? 0)).toStringAsFixed(2)} Tk',
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
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.cartItems.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please add item to proceed',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      );
                    } else {
                      Get.to(() => const ShippingPage(), arguments: {
                        'totalCost': totalCost,
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: GlobalColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  child: Text(
                    'Checkout (${totalCost.toStringAsFixed(2)} Tk)'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}