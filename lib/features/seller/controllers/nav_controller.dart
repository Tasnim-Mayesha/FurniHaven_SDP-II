import 'package:get/get.dart';

class NavController extends GetxController {
  static final NavController _singleton = NavController._internal();

  factory NavController() {
    return _singleton;
  }

  NavController._internal();

  var currentIndex = 0.obs;
  final List<String> pageTitles = [
    "Dashboard",
    "Chat",
    "Products",
    "Coupons",
    "Account",
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
