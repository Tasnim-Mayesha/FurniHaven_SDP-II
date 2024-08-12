import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp2/features/seller/models/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsController extends GetxController {
  var products = <Product>[].obs;
  var allProducts = <Product>[].obs;
  var selectedProducts = <Product>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    listenToProductChanges(); // Listen to real-time updates
  }

  void listenToProductChanges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sellerEmail = prefs.getString('seller_email');
    if (sellerEmail == null) {
      return;
    }

    _firestore.collection('Products').snapshots().listen((snapshot) {
      var fetchedProducts = snapshot.docs.map((doc) =>
          Product.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();

      products.assignAll(fetchedProducts);
      allProducts.assignAll(fetchedProducts);
    });
  }

  void addProductToList(Product newProduct) {
    products.add(newProduct);
    allProducts.add(newProduct);
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      products.assignAll(allProducts);
    } else {
      products.assignAll(
        allProducts
            .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  Product? getProductById(String id) {
    try {
      return allProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      Get.snackbar("Error", "Product not found: ${e.toString()}");
      return null;
    }
  }

  void updateProductInList(Product updatedProduct) {
    int index =
    products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      products[index] = updatedProduct;
      products.refresh();
    }
  }

  void deleteProducts(List<Product> productsToDelete) {
    try {
      for (Product product in productsToDelete) {
        _firestore.collection('Products').doc(product.id).delete();
      }
      products.removeWhere((product) => productsToDelete.contains(product));
      allProducts.removeWhere((product) => productsToDelete.contains(product));
      selectedProducts.clear();
    } catch (e) {
      Get.snackbar("Error", "Failed to delete products: ${e.toString()}");
    }
  }

  void toggleProductSelection(Product product) {
    if (selectedProducts.contains(product)) {
      selectedProducts.remove(product);
    } else {
      selectedProducts.add(product);
    }
  }

  void clearSelection() {
    selectedProducts.clear();
  }
}
