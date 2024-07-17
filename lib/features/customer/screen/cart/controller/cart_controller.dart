import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  void addItem(int index) {
    cartItems[index]['quantity']++;
    cartItems.refresh();
  }

  void removeItem(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
    }
    cartItems.refresh();
  }

  void deleteItem(int index) {
    cartItems.removeAt(index);
  }

  void addProductToCart(Map<String, dynamic> product) {
    cartItems.add(product);
  }
}
