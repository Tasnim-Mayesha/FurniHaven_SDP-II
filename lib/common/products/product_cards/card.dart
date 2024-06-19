import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String brandName;
  final int discount;
  final int originalPrice;
  final int discountedPrice;
  final int rating;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.brandName,
    required this.discount,
    required this.originalPrice,
    required this.discountedPrice,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        height: 335,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade400, // choose your border color
            width: 1, // choose the width of the border
          ),
        ),
        child: Column(
          children: [
            // Thumbnail, wishlist button, and discount tag
            Container(
              height: 180,
              padding: const EdgeInsets.all(2),
              child: Stack(
                children: [
                  // Thumbnail image
                  Center(
                    child: Image.asset(imageUrl),
                  ),
                  // Sale tag
                  Positioned(
                    top: 12,
                    left: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE24B).withOpacity(0.8), // Set the background color
                        borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                      ),
                      padding: const EdgeInsets.all(6.0), // Add padding
                      child: Text(
                        '${discount.toInt()}%',
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black),
                      ),
                    ),
                  ),
                  // Favorite icon button
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
                        style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        brandName,
                        style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
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
              mainAxisAlignment: MainAxisAlignment.start, // Aligns the text to the start (left)
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8), // Add your desired padding here
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
                  padding: const EdgeInsets.only(left: 8, right: 8), // Add your desired padding here
                  child: Text(
                    '${originalPrice.toInt()} Tk',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough, // Adds the strikethrough
                    ),
                  ),
                ),
                Container(
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
