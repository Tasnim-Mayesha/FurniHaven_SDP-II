import 'package:cloud_firestore/cloud_firestore.dart';

///Model class repository user data
class UserModel {
  final String id;
  final String userName;
  final String email;
  String profilePicture;
  List<String> addresses;
  List<String> phones;

  ///constructor for user model
  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.profilePicture,
    required this.addresses,
    required this.phones,
  });

  ///static function to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      userName: '',
      email: '',
      profilePicture: '',
      addresses: [],
      phones: []
  );

  ///convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'profilePicture': profilePicture,
      'addresses': addresses,
      'phones': phones
    };
  }

  ///Factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          userName: data['userName'] ?? '',
          email: data['email'] ?? '',
          profilePicture: data['profilePicture'] ?? '',
          addresses: List<String>.from(data['addresses'] ?? []),
          phones: List<String>.from(data['phones'] ?? [])
      );
    }
    return UserModel.empty();
  }
}