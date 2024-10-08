import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../common/products/product_cards/card.dart';
import '../../../../utils/global_colors.dart';
import '../home/home_controller/home_controller.dart';
import '../product/product_page.dart';
import 'Filter/filterBy.dart';
import 'Sort/sortBy.dart';
import '../../../../utils/global_variables/tap_count.dart'; // Import the global tap count

class ProductSearchResult extends StatefulWidget {
  final String searchQuery;

  const ProductSearchResult({super.key, required this.searchQuery});

  @override
  _ProductSearchResultState createState() => _ProductSearchResultState();
}

class _ProductSearchResultState extends State<ProductSearchResult> {
  late TextEditingController _searchController;
  RangeValues? _currentPriceRange;
  String? _sortOption;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilter(RangeValues? priceRange) {
    setState(() {
      _currentPriceRange = priceRange;
    });
  }

  void _applySort(String? sortOption) {
    setState(() {
      _sortOption = sortOption;
    });
  }

  Future<double> _getAverageRating(String productId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Review and Ratings')
        .where('productId', isEqualTo: productId)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return 0.0;
    }

    double totalRating = 0;
    for (var doc in querySnapshot.docs) {
      totalRating += doc['rating'] as double;
    }

    return totalRating / querySnapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

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
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search here".tr,
                prefixIcon: Icon(Icons.search, color: GlobalColors.mainColor),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: GlobalColors.mainColor),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                ),
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
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  setState(() {
                    controller.searchProducts(query);
                  });
                }
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: GlobalColors.mainColor),
            onPressed: () async {
              final selectedRange = await Get.to(() => const FilterBy());
              if (selectedRange != null) {
                _applyFilter(selectedRange);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.sort, color: GlobalColors.mainColor),
            onPressed: () async {
              final selectedSort = await Get.to(() => const SortBy());
              if (selectedSort != null) {
                _applySort(selectedSort);
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        var products = controller.searchProducts(_searchController.text);

        // Apply filtering
        if (_currentPriceRange != null) {
          products = products.where((product) {
            final price = (product["price"] * (1 - (product["discount"] / 100))).round();
            return price >= _currentPriceRange!.start && price <= _currentPriceRange!.end;
          }).toList();
        }

        // Apply sorting
        if (_sortOption != null) {
          if (_sortOption == "New arrivals") {
            products.sort((a, b) {
              return b["timestamp"].compareTo(a["timestamp"]);
            });
          } else if (_sortOption == "Discount") {
            products = products.where((product) => product["discount"] != null && product["discount"] > 0).toList();
          } else if (_sortOption == "PriceLtH") {
            products.sort((a, b) {
              final priceA = (a["price"] * (1 - (a["discount"] / 100))).round();
              final priceB = (b["price"] * (1 - (b["discount"] / 100))).round();
              return priceA.compareTo(priceB);
            });
          } else if (_sortOption == "PriceHtL") {
            products.sort((a, b) {
              final priceA = (a["price"] * (1 - (a["discount"] / 100))).round();
              final priceB = (b["price"] * (1 - (b["discount"] / 100))).round();
              return priceB.compareTo(priceA);
            });
          } else if (_sortOption == "Most Popular") {
            products.sort((a, b) {
              var countA = globalController.tapCount[a['id']] ?? 0;
              var countB = globalController.tapCount[b['id']] ?? 0;
              return countB.compareTo(countA);
            });
          }
        }

        if (products.isEmpty) {
          return Center(child: Text('No products found'.tr));
        } else {
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

              return FutureBuilder<double>(
                future: _getAverageRating(product["id"]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final averageRating = snapshot.data ?? 0.0;

                  return ProductCard(
                    id: product["id"] ?? '',
                    imageUrl: product["imageUrl"] ?? '',
                    productName: product["title"] ?? '',
                    brandName: product["brandName"] ?? 'Unknown',
                    sellerEmail: product["sellerEmail"] ?? 'Unknown',
                    discount: discount,
                    originalPrice: originalPrice,
                    discountedPrice: (originalPrice * (1 - (discount / 100))).round(),
                    rating: averageRating,
                    onTap: () {
                      // Increment global tap count
                      var productId = product["id"];
                      if (globalController.tapCount.containsKey(productId)) {
                        globalController.tapCount[productId] += 1;
                      } else {
                        globalController.tapCount[productId] = 1;
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
                        rating: averageRating,
                        description: product["description"] ?? '',
                        modelUrl: modelUrl,
                      ));
                    },
                  );
                },
              );
            },
          );
        }
      }),
    );
  }
}
