import 'package:flutter/material.dart';

class ProductDetailsCard extends StatelessWidget {
  final String brandLogoPath;
  final String productName;
  final String productDescription;
  final int originalPrice;
  final int discountedPrice;
  final int discount;

  const ProductDetailsCard({
    Key? key,
    required this.brandLogoPath,
    required this.productName,
    required this.productDescription,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  brandLogoPath, // Path to the brand logo image
                  width: 50,
                  height: 50,
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (originalPrice != discountedPrice)
                      Text(
                        '$originalPrice Tk',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Text(
                      '$discountedPrice Tk',
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (originalPrice != discountedPrice)
                      Text(
                        '$discount% off!',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              productName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              productDescription,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
