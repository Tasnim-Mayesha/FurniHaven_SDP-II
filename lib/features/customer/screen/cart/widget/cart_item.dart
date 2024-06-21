import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(4),
          //backgroundColor: Colors.white,
          child: const Image(
            image: AssetImage('assets/products/ar_chair.png'),
          ),
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
                    const Row(
                      children: [
                        Text('Aesthetic Fabric Blue Chair',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(
                                text: 'Brand:',style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const WidgetSpan(
                                child: SizedBox(width: 4), // Adjust the width to add space between the words
                              ),
                              TextSpan(
                                text: 'Hatil',style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.deepOrange),
                              )
                            ]
                        )
                    )

                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_sharp),
                  color: Colors.grey, // Optional: Set the color of the delete icon
                  onPressed: () {
                    // Add your delete functionality here
                  },
                ),
              ],
            )
        )
      ],
    );
  }
}
