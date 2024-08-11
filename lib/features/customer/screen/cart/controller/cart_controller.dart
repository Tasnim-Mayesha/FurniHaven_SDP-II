import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<void> applyCoupon(String couponCode) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('coupons')
          .where('code', isEqualTo: couponCode)
          .get();

      if (snapshot.docs.isEmpty) {
        Get.snackbar('Invalid Coupon', 'Coupon code does not exist.');
        return;
      }

      for (var doc in snapshot.docs) {
        var coupon = doc.data() as Map<String, dynamic>;
        final double discount = coupon['discount'] as double? ?? 0.0;
        final String sellerEmail = coupon['email'] as String? ?? '';
        final String expiryDateStr = coupon['expiryDate'] as String;

        // Parse the expiry date string to DateTime
        DateTime expiryDate = DateTime.parse(expiryDateStr);

        // Check if the coupon is expired
        if (expiryDate.isBefore(DateTime.now())) {
          Get.snackbar('Expired Coupon', 'The coupon code has expired.');
          return;
        }

        for (var item in cartItems) {
          if (item['sellerEmail'] == sellerEmail) {
            item['price'] = item['price'] * (1 - (discount / 100));
          }
        }
      }

      cartItems.refresh();
      Get.snackbar('Success', 'Coupon applied successfully.',);
    } catch (e) {
      Get.snackbar('Error', 'Failed to apply coupon.');
    }
  }

}
