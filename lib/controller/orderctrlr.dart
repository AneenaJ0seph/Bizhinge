import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/ordermodel.dart';

class OrderController extends GetxController {
  var isLoading = true.obs;
  var order = Rxn<Order>();

  @override
  void onInit() {
    super.onInit();
    fetchOrderDetails();
  }

  Future<void> fetchOrderDetails() async {
    try {
      final response = await http.get(
        Uri.parse('https://sadapi-production.up.railway.app/api/orders'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['id'] != null) {
          order.value = Order.fromJson(data);
        } else {
          throw Exception('Invalid data structure');
        }
      } else {
        throw Exception('API returned status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching order details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

