import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/models/Product.dart';
import 'package:sdp2/features/seller/views/pages/controllers/products_controller.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ProductsController productsController = Get.find<ProductsController>();

  Future<void> addProduct(
      Product product, File? imageFile, File? modelFile) async {
    try {
      // Upload the image file if provided
      if (imageFile != null) {
        product.imageUrl = await _uploadFile(
            imageFile, 'product_images/${imageFile.path.split('/').last}');
      }

      // Upload the model file if provided
      if (modelFile != null) {
        product.modelUrl = await _uploadFile(
            modelFile, '3d_models/${modelFile.path.split('/').last}');
      }

      // Generate a new document ID
      String newDocId = _firestore.collection('Products').doc().id;

      // Set this ID to the product object
      product.id = newDocId;

      // Create the document with the new ID
      await _firestore
          .collection('Products')
          .doc(newDocId)
          .set(product.toMap());
      productsController.addProductToList(product);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(
      Product product, File? imageFile, File? modelFile) async {
    try {
      if (imageFile != null) {
        product.imageUrl = await _uploadFile(
            imageFile, 'product_images/${imageFile.path.split('/').last}');
      }

      if (modelFile != null) {
        product.modelUrl = await _uploadFile(
            modelFile, '3d_models/${modelFile.path.split('/').last}');
      }
      await _firestore
          .collection('Products')
          .doc(product.id)
          .update(product.toMap());
      productsController.updateProductInList(product);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _uploadFile(File file, String path) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> countTotalProductsBySeller(String sellerEmail) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Products')
          .where('sellerEmail', isEqualTo: sellerEmail)
          .get();

      var totalQuantity = 0;

      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var quantity = (data['quantity'] ?? 0) as int; // Cast quantity to int
        totalQuantity += quantity;
      }
      return totalQuantity;
    } catch (e) {
      throw Exception("Failed to count total products: $e");
    }
  }

  Future<int> countTotalSoldProductsBySeller(String sellerEmail) async {
    try {
      // Query the Orders collection to find orders related to the seller
      QuerySnapshot snapshot = await _firestore
          .collection('Orders')
          .where('sellerEmail', isEqualTo: sellerEmail)
          .get();

      var totalSoldQuantity = 0;

      // Loop through each document and sum the quantity
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var quantity = (data['quantity'] ?? 0) as int;
        totalSoldQuantity += quantity;
      }

      return totalSoldQuantity;
    } catch (e) {
      throw Exception("Failed to count total sold products: $e");
    }
  }

  Future<int> calculateTotalSoldQuantityBySeller(String sellerEmail) async {
    try {
      // Query the Orders collection for orders by the given seller
      QuerySnapshot snapshot = await _firestore
          .collection('Orders')
          .where('sellerEmail', isEqualTo: sellerEmail)
          .get();

      var totalSoldQuantity = 0;

      // Loop through each document and sum the quantity field
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var quantity = (data['quantity'] ?? 0)
            as int; // Assuming quantity is stored as int
        totalSoldQuantity += quantity;
      }

      return totalSoldQuantity;
    } catch (e) {
      throw Exception("Failed to calculate total sold quantity: $e");
    }
  }
  Future<double> calculateTotalSalesBySeller(String sellerEmail) async {
  try {
    // Query the Orders collection for orders related to the seller
    QuerySnapshot snapshot = await _firestore
        .collection('Orders')
        .where('sellerEmail', isEqualTo: sellerEmail)
        .get();

    var totalSalesAmount = 0.0; // Initialize as double

    // Loop through each document and sum the totalPrice
    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      var totalPrice = (data['totalPrice'] ?? 0.0) as double; // Assuming totalPrice is stored as double
      totalSalesAmount += totalPrice;
    }

    return totalSalesAmount;
  } catch (e) {
    throw Exception("Failed to calculate total sales: $e");
  }
}

}
