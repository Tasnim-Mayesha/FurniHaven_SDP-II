import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdp2/common/circular_icon.dart';
import 'package:sdp2/features/customer/screen/product/widgets/chat_with_seller_initiation.dart';
import 'package:sdp2/features/customer/screen/product/widgets/model_view.dart';
import 'package:sdp2/features/customer/screen/product/widgets/product_detail_card.dart';
import 'package:sdp2/features/personilization/screen/Login/login_option.dart';
import '../../../../common/widgets/bottomnavbar/customer_starting.dart';
import '../../../../common/widgets/bottomnavbar/starting_controller.dart';

import '../cart/controller/cart_controller.dart';
import '../review_ratings/widgets/review_section.dart';
import '../../../../utils/global_colors.dart';

class ProductPage extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final String brandName;
  final int discount;
  final int originalPrice;
  final int discountedPrice;
  final double rating;
  final String modelUrl;
  final String description;
  final String sellerEmail;

  const ProductPage({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.brandName,
    required this.discount,
    required this.originalPrice,
    required this.discountedPrice,
    required this.rating,
    required this.modelUrl,
    required this.description,
    required this.sellerEmail,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isFavorite = false;
  int quantity = 1;

  Future<void> _toggleWishlist() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in, add the product to the wishlist
      setState(() {
        isFavorite = !isFavorite;
      });
      // Add logic to add the product to the wishlist in Firestore or local storage
    } else {
      // User is not logged in, navigate to LoginOption
      Get.to(() => const LoginOption());
    }
  }

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: GlobalColors.softGrey, // Light ash color
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(child: Text('Product'.tr)),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.heart5,
              color: isFavorite ? GlobalColors.mainColor : Colors.grey,
            ),
            onPressed: _toggleWishlist,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Product3DViewer(modelUrl: widget.modelUrl), // Pass the modelUrl here
            const SizedBox(height: 8),
            const ActionButtonsRow(),
            const SizedBox(height: 8),
            ProductDetailsCard(
              brandLogoPath: 'assets/brands/regal.png', // Assuming this path for demo purposes
              productName: widget.productName,
              productDescription: widget.description,
              originalPrice: widget.originalPrice,
              discountedPrice: widget.discountedPrice,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 16, right: 16),
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
                    Text(
                      'Quantity'.tr,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold),
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
                          quantity.toString().tr,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontSize: 18),
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
              child: ReviewSection(),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 320,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {
            final controller = Get.find<CartController>();
            controller.addProductToCart({
              'imageUrl': widget.imageUrl,
              'productName': widget.productName,
              'brandName': widget.brandName,
              'sellerEmail': widget.sellerEmail,
              'quantity': quantity,
              'price': widget.discountedPrice,
            });

            final controller1 = Get.find<CustNavController>();
            controller1.changePage(2);
            Get.to(() => CustMainPage());
          },
          label: Text('Add to Cart'.tr,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
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
