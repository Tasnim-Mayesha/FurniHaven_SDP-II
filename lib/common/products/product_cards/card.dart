import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../shadow_styles.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        //color: Colors.red,
        boxShadow: [ShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          //thumbnail,wishlist button and discount tag
          Container(
            height: 180,
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                //thumbnail image
                Center(
                  child: Image.asset("assets/products/ar_chair.png")
                ),
                //sale tag
                Positioned(
                  top: 10,
                  left: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE24B).withOpacity(0.8), // Set the background color
                      borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                    ),
                    padding: EdgeInsets.all(6.0), // Add padding
                    child: Text(
                      '25%',
                      style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black),
                    ),
                  ),
                ),
                //fav icon button
                Positioned(
                 top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart5),color:Colors.red,),
                  )
                ),
              ],
            ),
          ),
        Column(
            children: [
              Text(
                'Eve Fabric Double Chair',
                style:Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                //textAlign: TextAlign.left,
              ),
              Row(
                children: [
                  Text(
                    'Brand',
                    style:TextStyle(color: Colors.deepOrange)
                  ),
                ],
              )
            ],
          )

        ],
      ),
    );
  }
}
