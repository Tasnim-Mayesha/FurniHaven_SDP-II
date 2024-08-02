import 'package:cloud_firestore/cloud_firestore.dart';

///Model class repository user data
class SellerModel {
  final String id;
  final String sellerName;
  final String email;
  String brandName;
  String profilePicture;
  String phone;

  ///constructor for user model
  SellerModel({
    required this.id,
    required this.sellerName,
    required this.email,
    required this.brandName,
    required this.profilePicture,
    required this.phone,
  });

  ///static function to create an empty user model
  static SellerModel empty() =>
      SellerModel(id: '', sellerName: '', email: '', brandName: '',profilePicture: '',phone: '');

  ///convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sellerName': sellerName,
      'email': email,
      'brandName': brandName,
      'profilePicture': profilePicture,
      'phone': phone
    };
  }

  ///Factory method to create a UserModel from a Firebase document snapshot
  factory SellerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return SellerModel(
          id: document.id,
          sellerName: data['sellerName'] ?? '',
          email: data['email'] ?? '',
          brandName: data['brandName'] ?? '',
          profilePicture: data['profilePicture'] ?? '',
          phone: data['phone'] ?? ''
      );
    }
    return SellerModel.empty();
  }
}
