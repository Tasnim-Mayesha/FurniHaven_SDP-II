class Product {
  String id;
  String title;
  String imageUrl;
  double price;
  int quantity;
  String description;
  bool is3DEnabled;
  String category;
  String modelUrl;
  String sellerEmail;

  Product({
    required this.id,
    required this.title,
    this.imageUrl = '',
    required this.price,
    required this.quantity,
    required this.description,
    required this.is3DEnabled,
    required this.category,
    this.modelUrl = '',
    required this.sellerEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'description': description,
      'is3DEnabled': is3DEnabled,
      'category': category,
      'modelUrl': modelUrl,
      'sellerEmail': sellerEmail,
    };
  }

  static Product fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      title: map['title'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      quantity: map['quantity'],
      description: map['description'],
      is3DEnabled: map['is3DEnabled'],
      category: map['category'],
      modelUrl: map['modelUrl'],
      sellerEmail: map['sellerEmail'],
    );
  }
}
