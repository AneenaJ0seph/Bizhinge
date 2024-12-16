// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import '../controller/orderctrlr.dart';
//
// class OrderConfirmationScreen extends StatelessWidget {
//   final OrderController controller = Get.put(OrderController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Get.back(),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.green.shade50,
//       ),
//       body: Obx(
//             () {
//           if (controller.isLoading.value) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (controller.order.value == null) {
//             return Center(
//               child: Text(
//                 'Failed to load order details',
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.red,
//                 ),
//               ),
//             );
//           }
//
//           final order = controller.order.value!;
//           return SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 LottieBuilder.asset(
//                   'assets/animations/animsuccess.json',
//                   height: 200,
//                   width: 200,
//                   fit: BoxFit.fill,
//                   repeat: true,
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   "Your order has been placed successfully!",
//                   style: GoogleFonts.poppins(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Card(
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         OrderInfoRow(
//                           title1: "Order ID",
//                           details1: "${order.id}",
//                           title2: "Business Name",
//                           details2: order.businessUserName,
//                         ),
//                         SizedBox(height: 20),
//                         OrderInfoRow(
//                           title1: "Order Date",
//                           details1: order.orderDate,
//                           title2: "Status",
//                           details2: order.status,
//                         ),
//                         SizedBox(height: 20),
//                         OrderInfoRow(
//                           title1: "Billing Address",
//                           details1: order.billingAddress,
//                           title2: "Order Type",
//                           details2: order.orderType,
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             OrderInfoColumn(
//                               title: "Total Price",
//                               details: "${order.totalPrice} Rs",
//                             ),
//                             OrderInfoColumn(
//                               title: "Products",
//                               details: "${order.orderProducts.length} items",
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     // TODO: Navigate to the invoice page
//                   },
//                   child: Text(
//                     "Show purchase invoice",
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 ElevatedButton(
//                   onPressed: () => Get.back(),
//                   child: Text(
//                     "Back to home",
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class OrderInfoRow extends StatelessWidget {
//   final String title1;
//   final String details1;
//   final String title2;
//   final String details2;
//
//   const OrderInfoRow({
//     required this.title1,
//     required this.details1,
//     required this.title2,
//     required this.details2,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         OrderInfoColumn(
//           title: title1,
//           details: details1,
//         ),
//         OrderInfoColumn(
//           title: title2,
//           details: details2,
//         ),
//       ],
//     );
//   }
// }
//
// class OrderInfoColumn extends StatelessWidget {
//   final String title;
//   final String details;
//
//   const OrderInfoColumn({required this.title, required this.details});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: GoogleFonts.poppins(
//             fontSize: 12,
//             fontWeight: FontWeight.w400,
//             color: Colors.grey,
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(
//           details,
//           style: GoogleFonts.poppins(
//             fontSize: 12,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ],
//     );
//   }
// }
