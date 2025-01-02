import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'loginctrlr.dart';



class OrdersController extends GetxController {
  var isLoading = true.obs;
  var orders = [].obs;

  // Get the LoginController instance
  final LoginController loginController = Get.find<LoginController>();

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading(true);

      String userCompany = loginController.userModel?.companyName ?? 'DefaultCompany'; // Fallback to 'DefaultCompany' if companyName is null

      String apiUrl = 'https://sadapi-production.up.railway.app/api/orders/by-customer/$userCompany/';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        orders.value = json.decode(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load orders');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
