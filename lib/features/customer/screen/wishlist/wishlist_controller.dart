import 'package:get/get.dart';

class WishlistController extends GetxController {
  var wishlistItems = <Map<String, dynamic>>[].obs;

  void addToWishlist(Map<String, dynamic> product) {
    wishlistItems.add(product);
  }

  void removeFromWishlist(String productId) {
    wishlistItems.removeWhere((item) => item["id"] == productId);
  }

  bool isInWishlist(String productId) {
    return wishlistItems.any((item) => item["id"] == productId);
  }
}
