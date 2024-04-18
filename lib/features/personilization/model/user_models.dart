import 'package:cloud_firestore/cloud_firestore.dart';

///Model class repository user data
class UserModel {
  final String id;
  final String username;
  final String email;
  String profilePicture;

  ///constructor for user model
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.profilePicture,
  });

  ///static function to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      username: '',
      email: '',
      profilePicture: '');
  ///convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'UserName': username,
      'Email': email,
      'ProfilePicture': profilePicture,
    };
  }

  ///Factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          username: data['UserName'] ?? '',
          email: data['Email'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '');
    }
    return UserModel.empty();
  }

}