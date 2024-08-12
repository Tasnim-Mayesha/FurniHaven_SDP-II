import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp2/features/seller/models/Product.dart';
import 'package:sdp2/utils/global_colors.dart';

class SellerProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final bool isSelected;

  const SellerProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.isSelected = false,
  });

  Future<double> getAverageRating() async {
    double averageRating = 0.0;
    int totalRatings = 0;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('Review and Ratings')
        .where('productId', isEqualTo: product.id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        averageRating += doc['rating'] as double;
        totalRatings++;
      }
      averageRating = averageRating / totalRatings;
    }

    return averageRating;
  }

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
            color: isSelected ? Colors.orange : Colors.grey.shade400,
            width: 2,
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
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.orange,
                        size: 24,
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
                        '${product.discount}%',
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
              FutureBuilder<double>(
                future: getAverageRating(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    double averageRating = snapshot.data!;
                    int fullStars = averageRating.floor();
                    double fractionalPart = averageRating - fullStars;

                    return Wrap(
                      children: List.generate(5, (index) {
                        if (index < fullStars) {
                          return const Icon(Icons.star, color: Colors.amber, size: 16);
                        } else if (index == fullStars && fractionalPart >= 0.5) {
                          return const Icon(Icons.star_half, color: Colors.amber, size: 16);
                        } else {
                          return const Icon(Icons.star_border, color: Colors.amber, size: 16);
                        }
                      }),
                    );
                  } else {
                    return const Text('No rating available');
                  }
                },
              ),
              const SizedBox(height: 4),
              Text(
                '${(product.price * (1 - (product.discount / 100))).toInt()} Tk',
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
