import 'package:cloud_firestore/cloud_firestore.dart';

///Model class repository user data
class SellerModel {
  final String id;
  final String username;
  final String email;
  String companyName;

  ///constructor for user model
  SellerModel({
    required this.id,
    required this.username,
    required this.email,
    required this.companyName,
  });

  ///static function to create an empty user model
  static SellerModel empty() =>
      SellerModel(id: '', username: '', email: '', companyName: '');

  ///convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'userName': username,
      'email': email,
      'companyName': companyName,
    };
  }

  ///Factory method to create a UserModel from a Firebase document snapshot
  factory SellerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return SellerModel(
          id: document.id,
          username: data['userName'] ?? '',
          email: data['email'] ?? '',
          companyName: data['companyName'] ?? '');
    }
    return SellerModel.empty();
  }
}
