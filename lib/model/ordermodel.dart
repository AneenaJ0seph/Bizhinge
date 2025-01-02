import 'package:biztrail/model/productmodel.dart';

class Order {
  final int id;
  final int businessUserId;
  final String orderDate;
  final double totalPrice;
  final String billingAddress;
  final String status;
  final String orderType;
  final double cashbackApplied;
  final List<OrderProduct> orderProducts;

  Order({
    required this.id,
    required this.businessUserId,
    required this.orderDate,
    required this.totalPrice,
    required this.billingAddress,
    required this.status,
    required this.orderType,
    required this.cashbackApplied,
    required this.orderProducts,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: int.tryParse(json['id'].toString()) ?? 0,
      businessUserId: int.tryParse(json['business_user'].toString()) ?? 0,
      orderDate: json['order_date'] ?? '',
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      billingAddress: json['billing_address'] ?? '',
      status: json['status'] ?? '',
      orderType: json['order_type'] ?? '',
      cashbackApplied: double.tryParse(json['cashback_applied'].toString()) ?? 0.0,
      orderProducts: (json['order_products'] as List<dynamic>?)
          ?.map((item) => OrderProduct.fromJson(item))
          .toList() ??
          [],
    );
  }
}

// Order Product Model
class OrderProduct {
  final int quantity;
  final double price;
  final Product product;

  OrderProduct({
    required this.quantity,
    required this.price,
    required this.product,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      quantity: int.tryParse(json['quantity'].toString()) ?? 0,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      product: Product.fromJson(json['product']),
    );
  }
}
