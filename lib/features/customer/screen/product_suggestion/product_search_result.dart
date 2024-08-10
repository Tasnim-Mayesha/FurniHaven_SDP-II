import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/products/product_cards/card.dart';
import '../../../../utils/global_colors.dart';
import '../home/home_controller/home_controller.dart';
import '../product/product_page.dart';
import 'Filter/filterBy.dart';
import 'Sort/sortBy.dart';

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
            final price = product["price"] is int
                ? product["price"]
                : (product["price"] as double).toInt();
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
              return a["price"].compareTo(b["price"]);
            });
          } else if (_sortOption == "PriceHtL") {
            products.sort((a, b) {
              return b["price"].compareTo(a["price"]);
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
                    description: product["description"] ?? '',
                    modelUrl: modelUrl,
                  ));
                },
              );
            },
          );
        }
      }),
    );
  }
}