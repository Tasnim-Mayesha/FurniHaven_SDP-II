import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp2/features/seller/models/seller.dart';
import 'package:sdp2/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:sdp2/utils/exceptions/firebase_exceptions.dart';
import 'package:sdp2/utils/exceptions/format_exceptions.dart';
import 'package:sdp2/utils/exceptions/platform_exceptions.dart';

class SellerRepository extends GetxController {
  static SellerRepository get instance => Get.find<SellerRepository>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const String _sellerUidKey = 'seller_uid';

  // Function to save user data to Firestore
  Future<void> saveUserRecord(SellerModel seller) async {
    try {
      print("Seller start: ${seller.toJson()}");
      await _db.collection('Sellers').doc(seller.id).set(seller.toJson());
      print("Seller end: ${seller.toJson()}");
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong".tr;
    }
  }

  // Function to login user
  Future<User?> loginUser(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      await _cacheSellerUid(userCredential.user?.uid);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong".tr;
    }
  }

  Future<void> _cacheSellerUid(String? uid) async {
    final prefs = await SharedPreferences.getInstance();
    if (uid != null) {
      await prefs.setString(_sellerUidKey, uid);
    } else {
      await prefs.remove(_sellerUidKey);
    }
  }

  Future<String?> getCachedSellerUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sellerUidKey);
  }

  // Function to fetch seller data from Firestore
  Future<SellerModel> getSellerData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _db.collection('Sellers').doc(uid).get();
      return SellerModel.fromSnapshot(documentSnapshot);
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong".tr;
    }
  }

  Future<void> clearCachedSellerUid() async {
    await _cacheSellerUid(null);
  }
}
