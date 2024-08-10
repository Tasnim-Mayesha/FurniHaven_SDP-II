import 'package:flutter/material.dart';

import '../../../../../utils/global_colors.dart';

class CartItem extends StatelessWidget {
  final VoidCallback onDelete;
  final String imageUrl;
  final String productName;
  final String brandName;
  final int quantity;
  final double price;

  const CartItem({
    required this.onDelete,
    required this.imageUrl,
    required this.productName,
    required this.brandName,
    required this.quantity,
    required this.price,
    Key? key,
  }) : super(key: key);

  bool isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: isValidUrl(imageUrl)
              ? Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.image_not_supported,
              size: 60,
              color: Colors.grey,
            ),
          )
              : const Icon(
            Icons.image_not_supported,
            size: 60,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                brandName,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 14,
                  color: GlobalColors.mainColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$quantity x ${price.toStringAsFixed(2)} Tk',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete_outline,
                color: Colors.red[400],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
