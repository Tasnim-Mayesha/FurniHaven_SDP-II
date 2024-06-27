import 'dart:io';

class Product {
  String title;
  File? imageFile;
  double price;
  int quantity;
  bool is3DEnabled;
  String category;
  File? modelFile;

  Product({
    required this.title,
    this.imageFile,
    required this.price,
    required this.quantity,
    required this.is3DEnabled,
    required this.category,
    this.modelFile,
  });
}
