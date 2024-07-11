import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  var products = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('Products').get();
    final productsList = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (var product in productsList) {
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

    products.assignAll(productsList);
  }

  List<Map<String, dynamic>> searchProducts(String query) {
    return products.where((product) {
      final title = product['title']?.toString().toLowerCase() ?? '';
      final brandName = product['brandName']?.toString().toLowerCase() ?? '';
      final category = product['category']?.toString().toLowerCase() ?? '';
      final searchLower = query.toLowerCase();

      return title.contains(searchLower) ||
          brandName.contains(searchLower) ||
          category.contains(searchLower);
    }).toList();
  }
}