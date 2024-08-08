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
    int existingIndex = cartItems.indexWhere((item) => item['id'] == product['id']);
    if (existingIndex != -1) {
      // Increment the existing quantity by the new quantity
      cartItems[existingIndex]['quantity'] += product['quantity'];
    } else {
      // Add the product with the passed quantity
      cartItems.add({...product, 'quantity': product['quantity']});
    }
  }

  int getProductQuantity(String id) {
    int existingIndex = cartItems.indexWhere((item) => item['id'] == id);
    if (existingIndex != -1) {
      return cartItems[existingIndex]['quantity'];
    }
    return 0;
  }

  void incrementProduct(String id) {
    int existingIndex = cartItems.indexWhere((item) => item['id'] == id);
    if (existingIndex != -1) {
      cartItems[existingIndex]['quantity']++;
    } else {
      cartItems.add({'id': id, 'quantity': 1});
    }
  }
}
