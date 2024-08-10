import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../common/products/product_cards/card.dart';
import '../../../../utils/global_colors.dart';
import '../../../../utils/global_variables/tap_count.dart';
import '../product/product_page.dart';
import 'Filter/category_filter.dart';
import 'Sort/category_sort.dart';

class ProductSuggestionCategory extends StatefulWidget {
  final String category;

  const ProductSuggestionCategory({super.key, required this.category});

  @override
  _ProductSuggestionCategoryState createState() => _ProductSuggestionCategoryState();
}

class _ProductSuggestionCategoryState extends State<ProductSuggestionCategory> {
  late Future<List<Map<String, dynamic>>> _productsFuture;
  RangeValues? _currentPriceRange; // Track the current price range
  String? _currentSortOption; // Track the current sort option
  final GlobalController globalController = Get.find();

  @override
  void initState() {
    super.initState();
    _productsFuture = _fetchProducts();
  }

  Future<List<Map<String, dynamic>>> _fetchProducts() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('category', isEqualTo: widget.category)
        .get();

    final products = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (var product in products) {
      final email = product['sellerEmail'];
      if (email != null) {
        final sellerSnapshot = await FirebaseFirestore.instance
            .collection('Sellers')
            .where('email', isEqualTo: email)
            .get();

        if (sellerSnapshot.docs.isNotEmpty) {
          product['brandName'] = sellerSnapshot.docs.first.data()['brandName'];
        } else {
          product['brandName'] = 'Unknown';
        }
      } else {
        product['brandName'] = 'Unknown';
      }
    }

    // Filter by price range if provided
    if (_currentPriceRange != null) {
      products.retainWhere((product) {
        final price = (product["price"] * (1 - (product["discount"] / 100))).round() ;
        return price >= _currentPriceRange!.start && price <= _currentPriceRange!.end;
      });
    }

    // Sort products based on the current sort option
    if (_currentSortOption != null) {
      products.sort((a, b) {
        switch (_currentSortOption) {
          case 'price_asc':
            return (a['price'] as int).compareTo(b['price'] as int);
          case 'price_desc':
            return (b['price'] as int).compareTo(a['price'] as int);
          case 'rating':
            return (b['rating'] as double).compareTo(a['rating'] as double);
          default:
            return 0;
        }
      });
    }

    return products;
  }

  void _applyFilter(RangeValues? priceRange) {
    setState(() {
      _currentPriceRange = priceRange; // Update the current price range
      _productsFuture = _fetchProducts(); // Re-fetch products with the new filter
    });
  }

  void _applySort(String sortOption) {
    setState(() {
      _currentSortOption = sortOption; // Update the current sort option
      _productsFuture = _fetchProducts(); // Re-fetch products with the new sort option
    });
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
                hintText: widget.category.tr,
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
            icon: Icon(Icons.filter_list, color: GlobalColors.mainColor),
            onPressed: () async {
              final selectedRange = await Get.to(() => const CategoryFilterBy());
              if (selectedRange != null) {
                _applyFilter(selectedRange); // Apply the new filter
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.sort, color: GlobalColors.mainColor),
            onPressed: () async {
              final sortOption = await Get.to(() => const CategorySortBy());
              if (sortOption != null) {
                _applySort(sortOption); // Apply the new sort option
              }
            },
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
                  id: product["id"] ?? '',
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
                      id: product["id"] ?? '',
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
