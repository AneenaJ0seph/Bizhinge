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

      String userCompany = loginController.userModel?.companyName ??
          'DefaultCompany';
      String apiUrl = 'https://sadapi-production.up.railway.app/api/orders/by_customer/$userCompany/';
      print('Fetching from URL: $apiUrl');

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If orders are found, update the orders list
        orders.value = json.decode(response.body);
        print('Orders: ${orders.value}');
      } else if (response.statusCode == 404) {
        // If no orders are found, set orders to an empty list and handle gracefully
        orders.value = [];
        print('No orders found for company: $userCompany');
      } else {
        // Handle other error responses
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        Get.snackbar('Error', 'Failed to load orders');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}