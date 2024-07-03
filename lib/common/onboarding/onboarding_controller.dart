import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sdp2/common/widgets/bottomnavbar/customer_starting.dart';





class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  void updatePageIndicator(index)=> currentPageIndex.value=index;
  void dotNavigationClick(index){
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage(){
    if(currentPageIndex.value==2){
      final storage = GetStorage();

      if (kDebugMode) {
        print('========= GET STORAGE Next Button =========');
        print(storage.read('IsFirstTime'));
      }

      storage.write('IsFirstTime', false);
      Get.offAll(CustMainPage());
    }
    else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }
  void skipPage(){
    Get.offAll(CustMainPage());
    //currentPageIndex.value=2;
    //pageController.jumpToPage(2);
  }
}