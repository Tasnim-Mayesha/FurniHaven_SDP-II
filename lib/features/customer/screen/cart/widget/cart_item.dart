import 'package:flutter/material.dart';

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
      children: [
        isValidUrl(imageUrl)
            ? Image.network(imageUrl, width: 50, height: 50)
            : const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                brandName,
                style: Theme.of(context).textTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          children: [
            Text(
              '${quantity.toString()} x ${price.toStringAsFixed(2)} Tk',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
