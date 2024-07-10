import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GlobalController extends GetxController {
  final box = GetStorage();

  // Global observable variable
  var tapCount = {}.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved tap count from local storage
    tapCount.value = box.read('tapCount') ?? {};
    ever(tapCount, (_) => box.write('tapCount', tapCount.value));
  }
}

// Instantiate the GlobalController
final GlobalController globalController = Get.put(GlobalController());
