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
    int existingIndex = cartItems.indexWhere((item) => item['productName'] == product['productName']);
    if (existingIndex != -1) {
      cartItems[existingIndex]['quantity']++;
    } else {
      cartItems.add({...product, 'quantity': 1});
    }
  }

  int getProductQuantity(String productName) {
    int existingIndex = cartItems.indexWhere((item) => item['productName'] == productName);
    if (existingIndex != -1) {
      return cartItems[existingIndex]['quantity'];
    }
    return 0;
  }

  void incrementProduct(String productName) {
    int existingIndex = cartItems.indexWhere((item) => item['productName'] == productName);
    if (existingIndex != -1) {
      cartItems[existingIndex]['quantity']++;
    } else {
      cartItems.add({'productName': productName, 'quantity': 1});
    }
  }
}
