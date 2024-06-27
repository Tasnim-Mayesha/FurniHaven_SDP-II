import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdp2/common/circular_icon.dart';
import 'package:sdp2/features/customer/screen/cart/add_to_cart.dart';
import 'package:sdp2/features/customer/screen/product/widgets/chat_with_seller_initiation.dart';
import 'package:sdp2/features/customer/screen/product/widgets/model_view.dart';
import 'package:sdp2/features/customer/screen/product/widgets/product_detail_card.dart';
import 'package:sdp2/features/customer/screen/wishlist/wishlist.dart';
import 'package:sdp2/features/personilization/screen/Login/login_option.dart';
import '../review_ratings/widgets/review_section.dart';

import '../../../../utils/global_colors.dart'; // Make sure this path is correct

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isFavorite = false;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.softGrey, // Light ash color
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Center(child: Text('Product')),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.heart5,
              color: isFavorite ? GlobalColors.mainColor : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
              Get.to(()=> LoginOption());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Product3DViewer(),
            const SizedBox(height: 8),
            const ActionButtonsRow(),
            const SizedBox(height: 8),
            const ProductDetailsCard(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 16,right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Quantity',
                      style: TextStyle(fontSize: 16,color: Colors.deepOrange,fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularIcon(
                      icon: Iconsax.minus,
                      size: 16,
                      backgroundColor: Colors.grey.shade300,
                      width: 32,
                      height: 32,
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                        });
                      },

                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      quantity.toString(),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
                    ),

                    const SizedBox(
                      width: 16,
                    ),
                    CircularIcon(
                      icon: Iconsax.add,
                      size: 16,
                      backgroundColor: Colors.deepOrange,
                      width: 32,
                      height: 32,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
             const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ReviewSection(), // Include the ReviewSection here
            ),
            const SizedBox(height: 80,),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 320,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.to(const CartView());
            // Add your logic here for adding the item to the cart
          },
          label: const Text('Add to Cart',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
          icon: const Icon(Icons.shopping_cart,color: Colors.white),
          backgroundColor: GlobalColors.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}
