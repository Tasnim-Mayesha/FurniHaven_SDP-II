import 'package:get/get.dart';

class CustNavController extends GetxController {
  static final CustNavController _singleton = CustNavController._internal();

  factory CustNavController() {
    return _singleton;
  }

  CustNavController._internal();

  var currentIndex = 0.obs;



  List<String> get pageTitles {
    return [
      "Home".tr,
      "Messages".tr,
      "Cart".tr,
      "Wishlist".tr,
      "Account".tr,
    ];
  }

  void changePage(int index) {
    currentIndex.value = index;
  }
}
