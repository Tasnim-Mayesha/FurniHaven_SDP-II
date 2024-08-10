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
        padding: const EdgeInsets.all(16.0),
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
                  separatorBuilder: (_, __) => const SizedBox(height: 4),
                  itemCount: controller.cartItems.length,
                  itemBuilder: (_, index) {
                    final item = controller.cartItems[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CartItem(
                              onDelete: () => controller.deleteItem(index),
                              imageUrl: (item['imageUrl'] as String?) ?? '',
                              productName: (item['productName'] as String?) ?? '',
                              brandName: (item['brandName'] as String?) ?? '',
                              quantity: (item['quantity'] as int?) ?? 0,
                              price: ((item['price'] as num?) ?? 0.0).toDouble(),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AddRemoveButton(
                                  onAdd: () => controller.addItem(index),
                                  onRemove: () => controller.removeItem(index),
                                  count: (item['quantity'] as int?) ?? 0,
                                ),
                                Text(
                                  '${(((item['price'] as num?) ?? 0) * ((item['quantity'] as int?) ?? 0)).toStringAsFixed(2)} Tk',
                                  style: const TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
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
                      Get.to(() => ShippingPage(), arguments: {
                        'totalCost': totalCost,
                        'cartItems': controller.cartItems,
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
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
