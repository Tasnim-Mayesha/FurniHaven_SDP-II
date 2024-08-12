import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sdp2/data/repositories/seller/product_repository.dart';
import 'package:sdp2/data/repositories/seller/seller_repository.dart';
import 'package:sdp2/features/seller/models/Product.dart';

class AddEditProductController extends GetxController {
  final ProductRepository repository = ProductRepository();
  final SellerRepository sellerRepository = SellerRepository();

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController discountController = TextEditingController();  // Add this line
  String? imageUrl;
  String? modelUrl;
  var imageFile = Rx<File?>(null);
  var modelFile = Rx<File?>(null);
  var is3DEnabled = false.obs;
  var category = ''.obs;
  var isLoading = false.obs;
  final ImagePicker picker = ImagePicker();

  void setInitialValues(Product? product) {
    if (product != null) {
      titleController.text = product.title;
      priceController.text = product.price.toString();
      quantityController.text = product.quantity.toString();
      descriptionController.text = product.description;
      discountController.text = product.discount.toString();  // Make sure this is defined
      is3DEnabled.value = product.is3DEnabled;
      category.value = product.category;
      imageUrl = product.imageUrl;
      modelUrl = product.modelUrl;
    }
  }

  void pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  void pickModelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      modelFile.value = file;
    } else {
      print("No file selected");
    }
  }

  void toggle3DEnabled(bool? value) {
    if (value != null) {
      is3DEnabled.value = value;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    priceController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    discountController.dispose();  // Make sure to dispose the controller
    super.onClose();
  }

  Future<void> saveOrUpdateProduct(Product? product) async {
    isLoading.value = true;
    String? sellerEmail = await sellerRepository.getCachedSellerEmail();

    if (sellerEmail == null) {
      isLoading.value = false;
      Get.snackbar('Error', 'No seller email found');
      return;
    }

    Product newProduct = Product(
      id: product?.id ?? '',
      title: titleController.text,
      imageUrl: imageUrl ?? '',
      price: double.tryParse(priceController.text) ?? 0.0,
      quantity: int.tryParse(quantityController.text) ?? 0,
      description: descriptionController.text,
      discount: int.tryParse(discountController.text) ?? 0,
      timestamp: DateTime.now(),  // Set current timestamp as DateTime
      is3DEnabled: is3DEnabled.value,
      category: category.value,
      modelUrl: modelUrl ?? '',
      sellerEmail: sellerEmail,
    );

    try {
      if (product != null) {
        await repository.updateProduct(
            newProduct, imageFile.value, modelFile.value);
      } else {
        await repository.addProduct(
            newProduct, imageFile.value, modelFile.value);
      }
      Get.back();
      Get.snackbar('Success', 'Product saved successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save or update product');
    } finally {
      isLoading.value = false;
    }
  }


}
