import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/models/coupon.dart';
import 'package:sdp2/features/seller/views/pages/repository/coupon_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouponController extends GetxController {
  var coupons = <Coupon>[].obs;
  final CouponRepository couponRepository = CouponRepository();
  late String sellerEmail;

  @override
  void onInit() {
    super.onInit();
    _loadSellerEmail();
  }

  Future<void> _loadSellerEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sellerEmail = prefs.getString('seller_email') ?? '';
    if (sellerEmail.isNotEmpty) {
      _loadCoupons();
    }
  }

  void _loadCoupons() {
    couponRepository.getCoupons(sellerEmail).listen((couponList) {
      coupons.assignAll(couponList);
    });
  }

  Future<void> addCoupon(Coupon coupon) async {
    try {
      await couponRepository.addCoupon(coupon);
      _loadCoupons(); // Reload coupons after adding a new one
    } catch (e) {
      // Show a popup or dialog when the coupon code already exists
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  Future<void> removeCoupon(String code) async {
    await couponRepository.deleteCoupon(code);
    _loadCoupons(); // Reload coupons after deletion
  }

  Future<void> updateCoupon(String code, Coupon updatedCoupon) async {
    await couponRepository.updateCoupon(code, updatedCoupon);
    _loadCoupons(); // Reload coupons after update
  }
}
