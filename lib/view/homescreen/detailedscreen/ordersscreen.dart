// import 'package:biztrail/common/textconstants.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../common/app_colors.dart';
// import '../../../controller/loginctrlr.dart';
// import '../../../controller/ordrcontler.dart';
//
// class OrdersPage extends StatelessWidget {
//   //final Map<String, dynamic> orderDetails;
//   final OrdersController ordersController = Get.put(OrdersController());
//
// //  OrdersPage({required this.orderDetails});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//           surfaceTintColor: Colors.transparent,
//           backgroundColor: white,
//           title: Text('Orders',style: NeededTextstyles.commonhead,),centerTitle: true,),
//       body: Obx(() {
//         if (ordersController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (ordersController.orders.isEmpty) {
//           return Center(child: Text('No orders found.'));
//         } else {
//           return ListView.builder(
//             padding: EdgeInsets.all(8.0),
//             itemCount: ordersController.orders.length,
//             itemBuilder: (context, index) {
//               final order = ordersController.orders[index];
//               return OrderCard(order: order);
//             },
//           );
//         }
//       }),
//     );
//   }
// }
//
// class OrderCard extends StatelessWidget {
//   final Map<String, dynamic> order;
//
//
//   OrderCard({required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     final loginController = Get.find<LoginController>();
//     final userModel = loginController.userModel;
//     return Card(color: lighttheme79,
//       elevation: 3.0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       child: ExpansionTile(
//         backgroundColor: white,
//         title: Text('Order ID: ${order['id']}'),
//         subtitle: Text('Status: ${order['status']}'),
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Business User: ${userModel!.companyName}'),
//                 Text('Order Date: ${order['order_date']}'),
//                 Text('Billing Address: ${order['billing_address']}'),
//                 Text('Total Price: \$${order['total_price']}'),
//                 Divider(),
//                 Text(
//                   'Products:',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 ListView.builder(
//
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: order['order_products'].length,
//                   itemBuilder: (context, index) {
//                     final product = order['order_products'][index];
//                     return ListTile(
//
//                       leading: CircleAvatar(
//                         child: Text('${product['quantity']}'),
//                       ),
//                       title: Text(product['product_name']),
//                       subtitle: Text('Price: \$${product['price']}'),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/app_colors.dart';
import '../../../common/textconstants.dart';
import '../../../controller/loginctrlr.dart';
import '../../../controller/ordrcontler.dart';

class OrdersPage extends StatelessWidget {
  final OrdersController ordersController = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: white,
        title: Text(
          'Orders',
          style: NeededTextstyles.commonhead,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (ordersController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (ordersController.orders.isEmpty) {
          return Center(child: Text('No orders found.'));
        } else {
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: ordersController.orders.length,
            itemBuilder: (context, index) {
              final order = ordersController.orders[index];
              return OrderCard(order: order);
            },
          );
        }
      }),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    final userModel = loginController.userModel;

    return Card(
      color: lighttheme79,
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        backgroundColor: Colors.white70,
        title:
        Text('Order ID: ${order['id'] ?? 'N/A'}',style: NeededTextstyles.co,),
        subtitle: Text('Status: ${order['status'] ?? 'Unknown'}',style: NeededTextstyles.style21,),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Business User: ${userModel?.companyName ?? 'Not available'}',style: NeededTextstyles.style21
                ),
                Text('Order Date: ${order['order_date'] ?? 'N/A'}',style: NeededTextstyles.style21),
                Text('Billing Address: ${order['billing_address'] ?? 'N/A'}',style: NeededTextstyles.style21),
                Text('Total Price: \$${order['total_price'] ?? '0.00'}',style: NeededTextstyles.style21),
                Divider(),
                Text(
                  'Products:',
                  style: NeededTextstyles.blc15,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: order['order_products']?.length ?? 0,
                  itemBuilder: (context, index) {
                    final product = order['order_products'][index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${product['image'] ?? product['quantity']}',style: NeededTextstyles.style21),
                      ),
                      title: Text(product['product']['product_name'] ?? 'N/A',style: NeededTextstyles.style21),
                      subtitle: Text('Price: \$${product['price'] ?? '0.00'}',style: NeededTextstyles.style21),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
