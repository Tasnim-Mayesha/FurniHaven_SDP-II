import 'package:get/get.dart';

class ProductsController extends GetxController {
  var products = <Map<String, dynamic>>[].obs;
  var allProducts = <Map<String, dynamic>>[].obs; // To keep the original list

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() {
    var fetchedProducts = [
      {
        "id": "1",
        "imageUrl": "assets/products/almirah.png",
        "productName": "Round 4 Seater Dining Table",
        "brandName": "Regal",
        "discount": 20,
        "originalPrice": 150000,
        "discountedPrice": 120000,
        "rating": 5,
      },
      {
        "id": "2",
        "imageUrl": "assets/products/study table.png",
        "productName": "Furnish White Modern Chair",
        "brandName": "Brothers",
        "discount": 15,
        "originalPrice": 18000,
        "discountedPrice": 12750,
        "rating": 4,
      },
    ];
    products.assignAll(fetchedProducts);
    allProducts.assignAll(fetchedProducts); // Keep the original list
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      products
          .assignAll(allProducts); // Reset to original list if query is empty
    } else {
      products.assignAll(
        allProducts.where((product) =>
            product["productName"].toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  Map<String, dynamic>? getProductById(String id) {
    try {
      return allProducts.firstWhere((product) => product['id'] == id);
    } catch (e) {
      return null;
    }
  }
}
