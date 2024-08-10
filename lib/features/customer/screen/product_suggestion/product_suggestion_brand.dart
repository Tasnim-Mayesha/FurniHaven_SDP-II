import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../common/products/product_cards/card.dart';
import '../../../../utils/global_colors.dart';
import '../../../../utils/global_variables/tap_count.dart';
import '../product/product_page.dart';
import 'Filter/brand_filter.dart';
import 'Sort/brand_sort.dart';

class ProductSuggestionBrand extends StatefulWidget {
  final String brandName;
  final RangeValues? priceRange;

  const ProductSuggestionBrand({super.key, required this.brandName, this.priceRange});

  @override
  _ProductSuggestionBrandState createState() => _ProductSuggestionBrandState();
}

class _ProductSuggestionBrandState extends State<ProductSuggestionBrand> {
  late Future<List<Map<String, dynamic>>> _productsFuture;
  RangeValues? _currentPriceRange;
  String? _sortOption; // Track the current sort option

  @override
  void initState() {
    super.initState();
    _currentPriceRange = widget.priceRange;
    _productsFuture = _fetchProducts();
  }

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

    // Filter by brand name
    var filteredProducts = products.where((product) => product['brandName'] == widget.brandName).toList();

    // Filter by price range if it's provided
    if (_currentPriceRange != null) {
      filteredProducts = filteredProducts.where((product) {
        final price = (product["price"] * (1 - (product["discount"] / 100))).round() ;
        return price >= _currentPriceRange!.start && price <= _currentPriceRange!.end;
      }).toList();
    }

    // Apply sorting
    if (_sortOption != null) {
      if (_sortOption == "New arrivals") {
        filteredProducts.sort((a, b) {
          return b["timestamp"].compareTo(a["timestamp"]);
        });
      } else if (_sortOption == "Discount") {
        filteredProducts = filteredProducts
            .where((product) => product["discount"] != null && product["discount"] > 0)
            .toList();
      } else if (_sortOption == "PriceLtH") {
        filteredProducts.sort((a, b) {
          return a["price"].compareTo(b["price"]);
        });
      } else if (_sortOption == "PriceHtL") {
        filteredProducts.sort((a, b) {
          return b["price"].compareTo(a["price"]);
        });
      } else if (_sortOption == "Most Popular") {
        filteredProducts.sort((a, b) {
          var countA = globalController.tapCount[a['id']] ?? 0;
          var countB = globalController.tapCount[b['id']] ?? 0;
          return countB.compareTo(countA);
        });
      }
    }

    return filteredProducts;
  }

  void _applyFilter(RangeValues? priceRange) {
    setState(() {
      _currentPriceRange = priceRange; // Update the current price range
      _productsFuture = _fetchProducts(); // Re-fetch products with the new filter
    });
  }

  void _applySort(String? sortOption) {
    setState(() {
      _sortOption = sortOption; // Update the current sort option
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
            icon: Icon(Icons.filter_list, color: GlobalColors.mainColor),
            onPressed: () async {
              final selectedRange = await Get.to(() => const BrandFilterBy());
              if (selectedRange != null) {
                _applyFilter(selectedRange); // Apply the new filter
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.sort, color: GlobalColors.mainColor),
            onPressed: () async {
              final selectedSort = await Get.to(() => const BrandSortBy());
              if (selectedSort != null) {
                _applySort(selectedSort); // Apply the new sort option
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
