import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final querySnapshot = await _firestore.collection('Products').get();
      final products = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      for (var product in products) {
        if (product.containsKey("sellerEmail")) {
          final sellerQuery = await _firestore
              .collection('Sellers')
              .where('email', isEqualTo: product["sellerEmail"])
              .get();

          if (sellerQuery.docs.isNotEmpty) {
            final sellerDoc = sellerQuery.docs.first;
            product["brandName"] = sellerDoc.data()["brandName"];
          } else {
            product["brandName"] =
                "Unknown"; // Default value if seller not found
          }
        }
      }
      return products;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
