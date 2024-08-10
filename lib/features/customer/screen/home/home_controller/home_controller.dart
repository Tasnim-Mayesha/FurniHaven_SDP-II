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
    final productsList = await Future.wait(querySnapshot.docs.map((doc) async {
      var product = doc.data();
      final sellerEmail = product['sellerEmail'];

      // Fetch seller's brand name
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

      // Calculate the average rating
      product['rating'] = await _fetchAverageRating(doc.id);

      return product;
    }).toList());

    products.assignAll(productsList);
    prepareRecommendations();
  }

  Future<double> _fetchAverageRating(String productId) async {
    final reviewsSnapshot = await FirebaseFirestore.instance
        .collection('Review and Ratings')
        .where('productId', isEqualTo: productId)
        .get();

    double totalRating = 0;
    int count = reviewsSnapshot.docs.length;

    for (var doc in reviewsSnapshot.docs) {
      totalRating += doc['rating'];
    }

    return count == 0 ? 0 : totalRating / count;
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
