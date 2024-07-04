import 'package:get/get.dart';
import 'package:sdp2/data/repositories/user/home_repository.dart';

class HomeController extends GetxController {
  var products = <Map<String, dynamic>>[].obs;
  final HomeRepository _homeRepository = HomeRepository();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    final fetchedProducts = await _homeRepository.fetchProducts();
    // print(fetchedProducts);
    products.assignAll(fetchedProducts);
  }
}
