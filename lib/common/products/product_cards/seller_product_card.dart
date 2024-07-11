import 'package:flutter/material.dart';
import 'package:sdp2/features/seller/models/Product.dart';
import 'package:sdp2/utils/global_colors.dart';

class SellerProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const SellerProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.error,
                        color: Colors.red,
                      ), // Handle loading errors gracefully
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
                        '${20}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                product.title,
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Wrap(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    size: 20.0,
                    color: index < 4 ? Colors.amber : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${product.price} Tk',
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${product.price} Tk',
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
