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
import '../wishlist/wishlist_controller.dart';

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
  final String id;
  final bool scrollToReview; // New flag to indicate if we should scroll to review section

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
    required this.id,
    this.scrollToReview = false, // Default value is false
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isFavorite = false;
  int quantity = 1;
  late ScrollController _scrollController; // Declare ScrollController

  @override
  void initState() {
    super.initState();
    // Ensure WishlistController is initialized
    Get.lazyPut<WishlistController>(() => WishlistController());

    final WishlistController wishlistController = Get.find<WishlistController>();
    isFavorite = wishlistController.isInWishlist(widget.id);

    _scrollController = ScrollController(); // Initialize ScrollController

    if (widget.scrollToReview) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToReviewSection();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the ScrollController
    super.dispose();
  }

  void _scrollToReviewSection() {
    final offset = 420.0; // Adjust this value to scroll a bit further down
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + offset,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }


  Future<void> _toggleWishlist() async {
    User? user = FirebaseAuth.instance.currentUser;
    final WishlistController wishlistController = Get.find<WishlistController>();

    if (user != null) {
      setState(() {
        isFavorite = !isFavorite;
      });

      if (isFavorite) {
        wishlistController.addToWishlist({
          'id': widget.id as String? ?? '', // Ensure id is a String
          'imageUrl': widget.imageUrl as String? ?? '', // Ensure imageUrl is a String
          'productName': widget.productName as String? ?? 'Unknown Product', // Ensure productName is a String
          'brandName': widget.brandName as String? ?? 'Unknown Brand', // Ensure brandName is a String
          'sellerEmail': widget.sellerEmail as String? ?? '', // Ensure sellerEmail is a String
          'discount': (widget.discount as num?)?.toInt() ?? 0, // Ensure discount is cast to int
          'originalPrice': (widget.originalPrice as num?)?.toInt() ?? 0, // Ensure originalPrice is cast to int
          'discountedPrice': (widget.discountedPrice as num?)?.toInt() ?? 0, // Ensure discountedPrice is cast to int
          'rating': (widget.rating as num?)?.toDouble() ?? 0.0, // Ensure rating is cast to double
          'modelUrl': widget.modelUrl as String? ?? '', // Ensure modelUrl is a String
          'description': widget.description as String? ?? '', // Ensure description is a String
        });

      } else {
        wishlistController.removeFromWishlist(widget.id);
      }
    } else {
      Get.to(() => const LoginOption());
    }
  }

  String getBrandLogoPath(String brandName) {
    switch (brandName.toLowerCase()) {
      case 'regal':
        return 'assets/brands/regal.png';
      case 'brothers':
        return 'assets/brands/brothers.png';
      case 'otobi':
        return 'assets/brands/otobi.png';
      case 'hatil':
        return 'assets/brands/hatil.png';
      default:
        return 'assets/brands/regal.png'; // Use a default logo path if the brand name doesn't match
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.softGrey,
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
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: _toggleWishlist,
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // Attach the ScrollController
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Product3DViewer(modelUrl: widget.modelUrl),
            const SizedBox(height: 8),
            ActionButtonsRow(sellerEmail: widget.sellerEmail, brandName: widget.brandName),
            const SizedBox(height: 8),
            ProductDetailsCard(
              brandLogoPath: getBrandLogoPath(widget.brandName),
              productName: widget.productName,
              productDescription: widget.description,
              originalPrice: widget.originalPrice,
              discountedPrice: widget.discountedPrice,
              discount: widget.discount,
              rating: widget.rating
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ReviewSection(productId: widget.id),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 320,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {
            User? user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              final controller = Get.find<CartController>();

              controller.addProductToCart({
                'id': widget.id,
                'productName': widget.productName,
                'imageUrl': widget.imageUrl,
                'sellerEmail': widget.sellerEmail,
                'quantity': quantity,
                'price': widget.discountedPrice,
              });

              final controller1 = Get.find<CustNavController>();
              controller1.changePage(2);
              Get.to(() => CustMainPage());
            } else {
              Get.to(() => const LoginOption());
            }
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
