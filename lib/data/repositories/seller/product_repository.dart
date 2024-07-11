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
}
