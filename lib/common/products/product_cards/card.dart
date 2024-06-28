import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/global_colors.dart';

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
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Column(
              children: [
                Container(
                  height: 180,
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(imageUrl),
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
                            '${discount.toInt()}%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: Colors.black),
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        productName,
                        style: Theme.of(context).textTheme.bodyLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        children: [
                          const Text(
                            'Brand: ',
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            brandName,
                            style: const TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        '${discountedPrice.toInt()} Tk',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        '${originalPrice.toInt()} Tk',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: const SizedBox(
                width: 32 * 1.2,
                height: 32 * 1.2,
                child: Center(
                  child: Icon(
                    Iconsax.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
