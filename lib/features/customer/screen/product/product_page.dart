import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdp2/features/customer/screen/product/widgets/chat_with_seller_initiation.dart';
import 'package:sdp2/features/customer/screen/product/widgets/model_view.dart';
import 'package:sdp2/features/customer/screen/product/widgets/product_detail_card.dart';
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
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Product3DViewer(),
            const SizedBox(height: 10),
            const ActionButtonsRow(),
            const SizedBox(height: 10),
            const ProductDetailsCard(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
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
                      style: TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                        });
                      },
                    ),
                    Container(
                      color: GlobalColors.mainColor,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
             Padding(
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
            // Add your logic here for adding the item to the cart
          },
          label: const Text('Add to Cart',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
          icon: const Icon(Icons.shopping_cart,color: Colors.white,),
          backgroundColor: GlobalColors.mainColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}
