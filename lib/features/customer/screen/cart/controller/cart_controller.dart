import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = List<CartItemModel>.generate(
    4,
        (index) => CartItemModel(
      name: 'Aesthetic Fabric Blue Chair',
      brand: 'Hatil',
      price: 10000,
      quantity: 2,
      image: 'assets/products/ar_chair.png',
    ),
  ).obs;

  void increaseQuantity(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decreaseQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    }
    cartItems.refresh();
  }

  int get totalAmount {
    return cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }
}

class CartItemModel {
  final String name;
  final String brand;
  final int price;
  int quantity;
  final String image;

  CartItemModel({
    required this.name,
    required this.brand,
    required this.price,
    required this.quantity,
    required this.image,
  });
}
