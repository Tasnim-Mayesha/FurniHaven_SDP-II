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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(imageUrl, width: 50, height: 50),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(productName),
            Text(brandName),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: onDelete,
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}
