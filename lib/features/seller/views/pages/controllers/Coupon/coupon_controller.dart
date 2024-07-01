import 'package:get/get.dart';
import 'package:sdp2/features/seller/models/coupon.dart';

class CouponController extends GetxController {
  var coupons = <Coupon>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Adding dummy coupons on initialization
    coupons.addAll([
      Coupon(
          id: '001',
          code: 'SAVE10',
          discount: 10.0,
          expiryDate: DateTime.now().add(Duration(days: 30))),
      Coupon(
          id: '002',
          code: 'SUMMER20',
          discount: 20.0,
          expiryDate: DateTime.now().add(Duration(days: 60))),
      Coupon(
          id: '003',
          code: 'WELCOME15',
          discount: 15.0,
          expiryDate: DateTime.now().add(Duration(days: 45))),
    ]);
  }

  void addCoupon(Coupon coupon) {
    coupons.add(coupon);
  }

  void removeCoupon(String id) {
    coupons.removeWhere((coupon) => coupon.id == id);
  }

  void updateCoupon(Coupon updatedCoupon) {
    int index = coupons.indexWhere((coupon) => coupon.id == updatedCoupon.id);
    if (index != -1) {
      // Update the coupon at the found index
      coupons[index] = updatedCoupon;
      coupons.refresh(); // Refresh the observable list to trigger UI updates
    }
  }
}
