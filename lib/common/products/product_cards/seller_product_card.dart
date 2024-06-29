import 'package:flutter/material.dart';
import 'package:sdp2/utils/global_colors.dart';

class SellerProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String brandName;
  final int discount;
  final int originalPrice;
  final int discountedPrice;
  final int rating;
  final VoidCallback onTap; // Add a callback for tap events

  const SellerProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.brandName,
    required this.discount,
    required this.originalPrice,
    required this.discountedPrice,
    required this.rating,
    required this.onTap, // Make onTap required
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Use the onTap callback here
      child: Container(
        width: 180,
        height: 360,
        padding: const EdgeInsets.all(8),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjusts to content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1, // Keeps the image square
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 2,
                    left: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: GlobalColors.mainColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '$discount%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height:
                      8), // Add spacing between the image and the text content
              Text(
                productName,
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 4), // Add spacing between elements
              Wrap(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    size: 20.0,
                    color: index < rating ? Colors.amber : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${discountedPrice.toInt()} Tk',
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${originalPrice.toInt()} Tk',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
