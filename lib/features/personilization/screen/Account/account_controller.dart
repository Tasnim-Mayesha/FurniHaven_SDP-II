import 'package:get/get.dart';
import 'package:sdp2/features/authentication/controller/login/login_controller.dart'; // Adjust the path as needed

class AccountController extends GetxController {
  var selectedIndex = (-1).obs;
  final LoginController _loginController = Get.put(LoginController());

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> logout() async {
    await _loginController.logout();
    Get.offAllNamed('/login'); // Replace '/login' with your login route
  }
}
