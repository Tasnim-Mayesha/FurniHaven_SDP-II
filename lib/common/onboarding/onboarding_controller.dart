import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sdp2/common/widgets/bottomnavbar/customer_starting.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  final storage = GetStorage();

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      storage.write('isFirstTime', false); // Write isFirstTime as false

      if (kDebugMode) {
        print('========= GET STORAGE Next Button =========');
        print(storage.read('isFirstTime'));
      }

      Get.offAll(() => CustMainPage());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    storage.write('isFirstTime', false); // Write isFirstTime as false
    Get.offAll(() => CustMainPage());
  }
}
