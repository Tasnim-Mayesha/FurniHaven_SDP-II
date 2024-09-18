import 'package:get/get.dart';
import 'package:sdp2/data/repositories/seller/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  final ProductRepository productRepository = ProductRepository();

  var unsoldProductsCount = 0.obs;
  var totalSales = 0.0.obs; // To track total sales (double)
  var totalProfit = 0.0.obs; // To track total profit (double)
  var soldProductsCount = 0.obs;
  var isLoading = false.obs; // Loading indicator

  @override
  Future<void> onInit() async {
    super.onInit();
    // Initialize by fetching the seller email from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sellerEmail = prefs.getString("seller_email");

    if (sellerEmail != null && sellerEmail.isNotEmpty) {
      // Fetch data only if sellerEmail is available
      await fetchAllData(sellerEmail);
    } else {
      print("Error: Seller email not found in SharedPreferences");
    }
  }

  Future<void> fetchAllData(String sellerEmail) async {
    isLoading(true); // Set loading to true
    await fetchTotalProductsBySeller(sellerEmail);
    await fetchSoldProductsBySeller(sellerEmail);
    await fetchTotalSales(
        sellerEmail); // Calculate profit only after sales is fetched
    isLoading(false); // Set loading to false when done
  }

  Future<void> fetchTotalProductsBySeller(String sellerEmail) async {
    try {
      int count =
          await productRepository.countTotalProductsBySeller(sellerEmail);
      unsoldProductsCount.value = count; // Set unsold products count
    } catch (e) {
      print("Error fetching total products count: $e");
    }
  }

  Future<void> fetchSoldProductsBySeller(String sellerEmail) async {
    try {
      int soldCount =
          await productRepository.countTotalSoldProductsBySeller(sellerEmail);
      soldProductsCount.value = soldCount; // Set sold products count
    } catch (e) {
      print("Error fetching sold products count: $e");
    }
  }

  Future<void> fetchTotalSales(String sellerEmail) async {
    try {
      double totalSalesAmount =
          await productRepository.calculateTotalSalesBySeller(sellerEmail);
      totalSales.value = totalSalesAmount; // Set total sales value

      // Now calculate profit after total sales is updated
      fetchTotalProfit();
    } catch (e) {
      print("Error fetching total sales: $e");
    }
  }

  void fetchTotalProfit() {
    // Calculate 8% of totalSales as totalProfit
    totalProfit.value = totalSales.value * 0.08;
  }
}
