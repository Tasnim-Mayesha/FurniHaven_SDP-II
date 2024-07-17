import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import '../../../../../utils/global_variables/tap_count.dart';


class HomeController extends GetxController {
  var products = <Map<String, dynamic>>[].obs;
  var recommendedProducts = <Map<String, dynamic>>[].obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    _startPeriodicRefresh();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
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
    prepareRecommendations();
  }

  void prepareRecommendations() {
    final GlobalController globalController = Get.find();
    // Sort products by tap count in descending order
    var sortedProducts = List<Map<String, dynamic>>.from(products);
    sortedProducts.sort((a, b) {
      var countA = globalController.tapCount[a['id']] ?? 0;
      var countB = globalController.tapCount[b['id']] ?? 0;
      return countB.compareTo(countA);
    });

    recommendedProducts.assignAll(sortedProducts);
  }

  void _startPeriodicRefresh() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      prepareRecommendations();
    });
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
