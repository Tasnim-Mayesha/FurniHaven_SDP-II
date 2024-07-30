import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../common/products/product_cards/card.dart';
import '../../../../utils/global_colors.dart';
import '../../../../utils/global_variables/tap_count.dart';
import '../product/product_page.dart';
import 'Filter/brand_filter.dart';
import 'Filter/filterBy.dart';
import 'Sort/brand_sort.dart';
import 'Sort/sortBy.dart';


class ProductSuggestionBrand extends StatefulWidget {
  final String brandName;

  const ProductSuggestionBrand({super.key, required this.brandName});

  @override
  _ProductSuggestionBrandState createState() => _ProductSuggestionBrandState();
}

class _ProductSuggestionBrandState extends State<ProductSuggestionBrand> {
  late Future<List<Map<String, dynamic>>> _productsFuture;
  final GlobalController globalController = Get.find();

  Future<List<Map<String, dynamic>>> _fetchProducts() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('Products').get();
    final products = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (var product in products) {
      final sellerEmail = product['sellerEmail'];
      if (sellerEmail != null) {
        final sellerSnapshot = await FirebaseFirestore.instance
            .collection('Sellers')
            .where('email', isEqualTo: sellerEmail)
            .get();

        if (sellerSnapshot.docs.isNotEmpty) {
          product['brandName'] = sellerSnapshot.docs.first.data()['brandName'];
        } else {
          product['brandName'] = 'Unknown';
        }
      }
    }

    final filteredProducts = products.where((product) => product['brandName'] == widget.brandName).toList();

    return filteredProducts;
  }

  @override
  void initState() {
    super.initState();
    _productsFuture = _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 4.0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40.0,
            width: MediaQuery.of(context).size.width * 0.65,
            child: TextField(
              decoration: InputDecoration(
                hintText: widget.brandName.tr,
                prefixIcon: Icon(Icons.search, color: GlobalColors.mainColor),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: GlobalColors.mainColor),
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.grey),
            onPressed: () => Get.to(() => BrandFilterBy()),
          ),
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.grey),
            onPressed: () => Get.to(() => BrandSortBy()),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'.tr));
          } else {
            final products = snapshot.data!;

            products.sort((a, b) {
              var countA = globalController.tapCount[a['id']] ?? 0;
              var countB = globalController.tapCount[b['id']] ?? 0;
              return countB.compareTo(countA);
            });

            return GridView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 335,
              ),
              itemBuilder: (_, index) {
                final product = products[index];
                final originalPrice = product["price"] is int
                    ? product["price"]
                    : (product["price"] as double).toInt();
                final discount = product["discount"] ?? 0;
                final modelUrl = product["modelUrl"] ?? '';

                return ProductCard(
                  imageUrl: product["imageUrl"] ?? '',
                  productName: product["title"] ?? '',
                  brandName: product["brandName"] ?? 'Unknown',
                  sellerEmail: product["sellerEmail"] ?? 'Unknown',
                  discount: discount,
                  originalPrice: originalPrice,
                  discountedPrice: (originalPrice * (1 - (discount / 100))).round(),
                  rating: product["rating"] ?? 0,
                  onTap: () {
                    // Increment tap count
                    var id = product["id"];
                    if (globalController.tapCount.containsKey(id)) {
                      globalController.tapCount[id] += 1;
                    } else {
                      globalController.tapCount[id] = 1;
                    }
                    Get.to(() => ProductPage(
                      imageUrl: product["imageUrl"] ?? '',
                      productName: product["title"] ?? '',
                      brandName: product["brandName"] ?? 'Unknown',
                      sellerEmail: product["sellerEmail"] ?? 'Unknown',
                      discount: discount,
                      originalPrice: originalPrice,
                      discountedPrice: (originalPrice * (1 - (discount / 100))).round(),
                      rating: product["rating"] ?? 0,
                      modelUrl: modelUrl,
                      description: product["description"] ?? '',
                    ));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
