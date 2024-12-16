//
// import 'package:biztrail/view/homescreen/firstscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:uuid/uuid.dart';
//
// import '../authentication/signup.dart';
// import '../common/app_colors.dart';
// import '../controller/cartcontroller.dart';
//
//
// class User {
//   final String shippingName;
//   final String recipientName;
//   final String fromAddress;
//   final String toAddress;
//   // final int quantity;
//   final double amount;
//
//   User({
//     required this.shippingName,
//     required this.recipientName,
//     required this.fromAddress,
//     required this.toAddress,
//     // required this.quantity,
//     required this.amount,
//   });
// }
//
// class OrderConfirmationScreen extends StatefulWidget {
//   final CartController cartController = Get.find<CartController>();
//   @override
//   _OrderConfirmationScreenState createState() =>
//       _OrderConfirmationScreenState();
// }
//
// class _OrderConfirmationScreenState extends State<OrderConfirmationScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   double _imageSize = 300;
//   double _opacity = 0.0;
//   late String orderId;
//
//   final User user = User(
//     shippingName: "Leafbazar\nEnterprises Pvt. Ltd",
//     recipientName: "Akshay Company",
//     fromAddress: "Leafbazar\nEnterprises Pvt. Ltd\nPuthanangadi ROAD,\nMEKKAD P.O",
//     toAddress: "Nil",
//     // quantity: 12,
//     amount: cartController.totalPrice.value.toStringAsFixed(2),
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     var uuid = Uuid();
//     orderId = uuid.v4().substring(0, 8);
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     );
//     _controller.addListener(() {
//       setState(() {
//         _imageSize = 150;
//         _opacity = 1.0;
//       });
//     });
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:Colors.green.shade50,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(builder: (context) => MyHomePage()),
//             // );
//           },
//         ),
//         elevation: 0,
//         backgroundColor:Colors.green.shade50,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height:1),
//             AnimatedOpacity(
//               opacity: _opacity,
//               duration: Duration(seconds: 1),
//               curve: Curves.easeInOut,
//               child: LottieBuilder.asset(
//                 'assets/animations/animsuccess.json',
//                 height: 200,
//                 width: 200,
//                 fit: BoxFit.fill,
//                 repeat: true,
//                 onLoaded: (composition) {
//                   final adjustedDuration = composition.duration ~/ 500;
//                   print('Adjusted Duration: $adjustedDuration');
//                 },
//               ),
//             ),
//
//             SizedBox(height: 20),
//             Text(
//               "Your order has been made!",
//               style: GoogleFonts.poppins(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 color:black,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Congratulations, your order has been\nsuccessfully placed! We will pick up your order as\nsoon as possible.",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//                 color:grey,
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 Container(
//                   height: 41,
//                   width: 44,
//                   decoration: BoxDecoration(
//                     color: maintheme1,
//                     border: Border.all(
//                       color: Colors.transparent, // Border color
//                       width: 1, // Border width
//                     ),
//                     borderRadius: BorderRadius.circular(8), // Optional: rounded corners
//                   ),
//                   child: Icon(Icons.directions_bus_outlined,
//                     color: Color(0xff1D1B20).withOpacity(0.46),),
//                 ),
//
//                 SizedBox(width: 15,),
//                 Text(
//                   "Order ID: #$orderId",
//                   style: GoogleFonts.poppins(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w600,
//                     color:black,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20,),
//             Card(
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         OrderInfoColumn(
//                           title: "Shipping name",
//                           details: user.shippingName,
//                         ),
//                         OrderInfoColumn(
//                           title: "Recipient name",
//                           details: user.recipientName,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         OrderInfoColumn(
//                           title: "From",
//                           details: user.fromAddress,
//                         ),
//                         OrderInfoColumn(
//                           title: "To",
//                           details: user.toAddress,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 5),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Quantity",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 color:grey,
//                               ),
//                             ),
//                             // Text(
//                             //   "${user.quantity}+(1 Free)",
//                             //   style: GoogleFonts.poppins(fontSize: 12,
//                             //     fontWeight: FontWeight.w400,),
//                             // ),
//                           ],
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Amount",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 color:grey,
//                               ),
//                             ),
//                             Text(
//                               "${user.amount}rs",
//                               style: GoogleFonts.poppins(fontSize: 12,
//                                 fontWeight: FontWeight.w400,),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//
//             SizedBox(
//               height: 27,
//               width: 244,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) => Invoicepage()),
//                   // );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: lighttheme50,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         15),
//                   ),
//                 ),
//                 child: Text(
//                   "Show purchase invoice",
//                   style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: Darktheme1,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 15),
//             SizedBox(
//               height: 27,
//               width: 244,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => FirstScreen(companyName: Get.find<SignUpController>().companyName.value)),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: maintheme1,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         15), // Responsive border radius
//                   ),
//                 ),
//                 child: Text(
//                   "Back to home",
//                   style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color:white,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class OrderInfoColumn extends StatelessWidget {
//   final String title;
//   final String details;
//
//   OrderInfoColumn({required this.title, required this.details});
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
//             color:grey,
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



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:uuid/uuid.dart';
//
// import '../authentication/signup.dart';
// import '../common/app_colors.dart';
// import '../controller/cartcontroller.dart';
// import '../view/homescreen/firstscreen.dart';
//
// class User {
//   final String shippingName;
//   final String recipientName;
//   final String fromAddress;
//   final String toAddress;
//   final double amount;
//
//   User({
//     required this.shippingName,
//     required this.recipientName,
//     required this.fromAddress,
//     required this.toAddress,
//     required this.amount,
//   });
// }
//
// class OrderConfirmationScreen extends StatefulWidget {
//   @override
//   _OrderConfirmationScreenState createState() =>
//       _OrderConfirmationScreenState();
// }
//
// class _OrderConfirmationScreenState extends State<OrderConfirmationScreen>
//     with SingleTickerProviderStateMixin {
//   final SignUpController signupController = Get.put(SignUpController());
//   late AnimationController _controller;
//   double _imageSize = 300;
//   double _opacity = 0.0;
//   late String orderId;
//   late User user;
//   final CartController cartController = Get.find<CartController>();
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Generate unique order ID
//     var uuid = Uuid();
//     orderId = uuid.v4().substring(0, 8);
//
//     // Initialize user object with cart data
//     user = User(
//       shippingName: "Leafbazar Enterprises Pvt. Ltd",
//       recipientName: "Akshay Company",
//       fromAddress: "Leafbazar Enterprises Pvt. Ltd\nPuthanangadi ROAD,\nMEKKAD P.O",
//       toAddress: "Nil",
//       amount: double.parse(cartController.totalPrice.value.toStringAsFixed(2)),
//     );
//
//     // Animation setup
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..addListener(() {
//       setState(() {
//         _imageSize = 150;
//         _opacity = 1.0;
//       });
//     });
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         elevation: 0,
//         backgroundColor: Colors.green.shade50,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 1),
//             AnimatedOpacity(
//               opacity: _opacity,
//               duration: const Duration(seconds: 1),
//               curve: Curves.easeInOut,
//               child: Lottie.asset(
//                 'assets/animations/animsuccess.json',
//                 height: 200,
//                 width: 200,
//                 fit: BoxFit.fill,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Your order has been made!",
//               style: GoogleFonts.poppins(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 color: black,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Congratulations, your order has been\nsuccessfully placed! We will pick up your order as\nsoon as possible.",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//                 color: grey,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Container(
//                   height: 41,
//                   width: 44,
//                   decoration: BoxDecoration(
//                     color: maintheme1,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(
//                     Icons.directions_bus_outlined,
//                     color: const Color(0xff1D1B20).withOpacity(0.46),
//                   ),
//                 ),
//                 const SizedBox(width: 15),
//                 Text(
//                   "Order ID: #$orderId",
//                   style: GoogleFonts.poppins(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w600,
//                     color: black,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Card(
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         OrderInfoColumn(
//                           title: "Shipping name",
//                           details: user.shippingName,
//                         ),
//                         OrderInfoColumn(
//                           title: "Recipient name",
//                           details: user.recipientName,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         OrderInfoColumn(
//                           title: "From",
//                           details: user.fromAddress,
//                         ),
//                         OrderInfoColumn(
//                           title: "To",
//                           details: user.toAddress,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Amount: ",
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: grey,
//                           ),
//                         ),
//                         Text(
//                           "${user.amount} rs",
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               height: 27,
//               width: 244,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Navigate to invoice page
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: lighttheme50,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: Text(
//                   "Show purchase invoice",
//                   style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: Darktheme1,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             SizedBox(
//               height: 27,
//               width: 244,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => FirstScreen(companyName: Get.find<SignUpController>().companyName.value
//                       ),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: maintheme1,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: Text(
//                   "Back to home",
//                   style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: white,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
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
//             color: grey,
//           ),
//         ),
//         const SizedBox(height: 5),
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


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

import '../common/app_colors.dart';
import '../controller/cartcontroller.dart';
import '../authentication/signup.dart';
import '../view/homescreen/firstscreen.dart';

class User {
  final String shippingName;
  final String recipientName;
  final String fromAddress;
  final String toAddress;
  final double amount;

  User({
    required this.shippingName,
    required this.recipientName,
    required this.fromAddress,
    required this.toAddress,
    required this.amount,
  });
}

class OrderConfirmationScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  final SignUpController signupController = Get.find<SignUpController>();
  final String orderId = Uuid().v4().substring(0, 8); // Generate unique order ID

  @override
  Widget build(BuildContext context) {
    // Initialize user object with cart data
    final user = User(
      shippingName: "Leafbazar Enterprises Pvt. Ltd",
      recipientName: "Akshay Company",
      fromAddress: "Leafbazar Enterprises Pvt. Ltd\nPuthanangadi ROAD,\nMEKKAD P.O",
      toAddress: "Nil",
      amount: double.parse(cartController.totalPrice.value.toStringAsFixed(2)),
    );

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.green.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 1),
            Lottie.asset(
              'assets/animations/animsuccess.json',
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            Text(
              "Your order has been made!",
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Congratulations, your order has been\nsuccessfully placed! We will pick up your order as\nsoon as possible.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: grey,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 41,
                  width: 44,
                  decoration: BoxDecoration(
                    color: maintheme1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.directions_bus_outlined,
                    color: const Color(0xff1D1B20).withOpacity(0.46),
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  "Order ID: #$orderId",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OrderInfoColumn(
                          title: "Shipping name",
                          details: user.shippingName,
                        ),
                        OrderInfoColumn(
                          title: "Recipient name",
                          details: user.recipientName,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OrderInfoColumn(
                          title: "From",
                          details: user.fromAddress,
                        ),
                        OrderInfoColumn(
                          title: "To",
                          details: user.toAddress,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount: ",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: grey,
                          ),
                        ),
                        Obx(() => Text(
                          "${cartController.totalPrice.value} rs",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // SizedBox(
            //   height: 27,
            //   width: 244,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Navigate to invoice page
            //       print("Show purchase invoice");
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: lighttheme50,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //     ),
            //     child: Text(
            //       "Show purchase invoice",
            //       style: GoogleFonts.poppins(
            //         fontSize: 12,
            //         fontWeight: FontWeight.w500,
            //         color: Darktheme1,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 15),
            SizedBox(
              height: 27,
              width: 244,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => FirstScreen(
                    companyName: signupController.companyName.value,
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: maintheme1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Back to home",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class OrderInfoColumn extends StatelessWidget {
  final String title;
  final String details;

  const OrderInfoColumn({required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: grey,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          details,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
