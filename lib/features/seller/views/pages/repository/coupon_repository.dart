import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp2/features/seller/models/coupon.dart';

class CouponRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCoupon(Coupon coupon) async {
    // Step 1: Retrieve the seller's email from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sellerEmail = prefs.getString('seller_email');

    if (sellerEmail == null) {
      throw Exception("Seller email not found in SharedPreferences");
    }

    // Step 2: Check if a coupon with the same code already exists
    QuerySnapshot query = await _firestore
        .collection('coupons')
        .where('code', isEqualTo: coupon.code)
        .get();

    if (query.docs.isNotEmpty) {
      // If a document with the same code exists, throw an exception
      throw Exception("Coupon with code ${coupon.code} already exists");
    } else {
      // Step 3: Add the seller's email to the coupon data
      coupon = Coupon(
        code: coupon.code,
        discount: coupon.discount,
        expiryDate: coupon.expiryDate,
        email: sellerEmail,
      );

      // Step 4: Add the new coupon to Firestore
      await _firestore.collection('coupons').add(coupon.toMap());
    }
  }

  Future<void> deleteCoupon(String code) async {
    // Step 1: Query the document by the 'code' field
    QuerySnapshot query = await _firestore
        .collection('coupons')
        .where('code', isEqualTo: code)
        .get();

    // Step 2: Check if the document exists
    if (query.docs.isNotEmpty) {
      // Assuming there's only one document with the given code
      DocumentReference docRef = query.docs.first.reference;

      // Step 3: Delete the document
      await docRef.delete();
    } else {
      // Handle the case where the document is not found
      throw Exception("Coupon with code $code not found");
    }
  }

  Future<void> updateCoupon(String code, Coupon updatedCoupon) async {
    // Step 1: Query the document by the 'code' field
    QuerySnapshot query = await _firestore
        .collection('coupons')
        .where('code', isEqualTo: code)
        .get();

    // Step 2: Check if the document exists
    if (query.docs.isNotEmpty) {
      // Assuming there's only one document with the given code
      DocumentReference docRef = query.docs.first.reference;

      // Step 3: Update the document with new data
      await docRef.update(updatedCoupon.toMap());
    } else {
      // Handle the case where the document is not found
      throw Exception("Coupon with code $code not found");
    }
  }

  Stream<List<Coupon>> getCoupons(String email) {
    return _firestore
        .collection('coupons')
        .where('email', isEqualTo: email)
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        var data = doc.data();
        return Coupon.fromMap(data);
      }).toList();
    });
  }
}
  