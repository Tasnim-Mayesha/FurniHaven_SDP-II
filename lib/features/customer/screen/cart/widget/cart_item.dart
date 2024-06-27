import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final VoidCallback onDelete;
  final String imageUrl;
  final String productName;
  final String brandName;
  final int quantity;
  final double price;

  const CartItem({
    super.key,
    required this.onDelete,
    required this.imageUrl,
    required this.productName,
    required this.brandName,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(4),
          child: Image.asset(imageUrl),
        ),
        const SizedBox(width: 16,),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(productName, style: const TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Brand:', style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 4),
                        ),
                        TextSpan(
                          text: brandName, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.deepOrange),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_sharp),
                color: Colors.grey,
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
