import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
        Uri.parse('https://btobapi-production.up.railway.app/api/orders/'),
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

// Order Model
class Order {
  final int id;
  final int businessUserId;
  final String businessUserName;
  final String orderDate;
  final double totalPrice;
  final String billingAddress;
  final String status;
  final String orderType;
  final List<OrderProduct> orderProducts;

  Order({
    required this.id,
    required this.businessUserId,
    required this.businessUserName,
    required this.orderDate,
    required this.totalPrice,
    required this.billingAddress,
    required this.status,
    required this.orderType,
    required this.orderProducts,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: int.tryParse(json['id'].toString()) ?? 0,
      businessUserId: int.tryParse(json['business_user'].toString()) ?? 0,
      businessUserName: json['business_user_name'] ?? '',
      orderDate: json['order_date'] ?? '',
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      billingAddress: json['billing_address'] ?? '',
      status: json['status'] ?? '',
      orderType: json['order_type'] ?? '',
      orderProducts: (json['order_products'] as List<dynamic>?)
          ?.map((item) => OrderProduct.fromJson(item))
          .toList() ??
          [],
    );
  }
}

// Order Product Model
class OrderProduct {
  final String productName; // Example field, adjust based on your API
  final int productId;

  OrderProduct({
    required this.productName,
    required this.productId,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      productName: json['product_name'] ?? '',
      productId: int.tryParse(json['product_id'].toString()) ?? 0,
    );
  }
}
