import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdp2/utils/global_colors.dart';
import '../../../features/customer/screen/cart/controller/cart_controller.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String brandName;
  final int discount;
  final int originalPrice;
  final int discountedPrice;
  final int rating;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.brandName,
    required this.discount,
    required this.originalPrice,
    required this.discountedPrice,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());

    return Container(
      width: 180,
      height: 335,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  height: 180,
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image, size: 50, color: Colors.grey);
                          },
                        ),
                      ),
                      Positioned(
                        top: 14,
                        left: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: GlobalColors.mainColor.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            '${discount.toInt()}%'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: Colors.white),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.heart5),
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      productName.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Text(
                        'Brand: '.tr,
                        style: const TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          brandName.tr,
                          style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        size: 20.0,
                        color: index < rating ? Colors.amber : Colors.grey,
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${discountedPrice.toInt()} Tk'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${originalPrice.toInt()} Tk'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Obx(() {
                        int quantity = cartController.getProductQuantity(productName);
                        return Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: GlobalColors.mainColor,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15.0),
                              topLeft: Radius.circular(15.0),
                            ),
                          ),
                          child: quantity == 0
                              ? IconButton(
                            onPressed: () {
                              cartController.addProductToCart({
                                'imageUrl': imageUrl,
                                'productName': productName,
                                'brandName': brandName,
                                'quantity': 1,
                                'price': discountedPrice,
                              });
                            },
                            icon: const Icon(Iconsax.add),
                            color: Colors.white,
                          )
                              : GestureDetector(
                            onTap: () {
                              cartController.incrementProduct(productName);
                            },
                            child: Center(
                              child: Text(
                                '$quantity',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
