// // ignore_for_file: use_key_in_widget_constructors
//
// import 'package:biztrail/view/homescreen/splash.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
//
// import 'authentication/login.dart';
// import 'authentication/signup.dart';
// import 'controller/usercontroller.dart';
// import 'model/leaf/leafpro.dart';
// import 'view/homescreen/firstscreen.dart';
// import 'controller/cartcontroller.dart';
// import 'controller/srchcontrlr.dart';
//
// void main() {
//   // Lazy initialization of controllers
//   Get.lazyPut<SrchController>(() => SrchController());
//   Get.lazyPut<CartController>(() => CartController());
//   Get.put(SignUpController());
//   Get.put(UserController());
//
//   runApp(
//     GetMaterialApp(
//       title: 'Leaf Coin App',
//       initialBinding: BindingsBuilder(() {
//
//         Get.put(LeafCoinController());
//       }),
//       home: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp();
//
//   @override
//   Widget build(BuildContext context) {
//     return const GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home:  SplashScreen() // Use const for widgets without dynamic state
//     );
//   }
// }
// ignore_for_file: use_key_in_widget_constructors

import 'package:biztrail/view/homescreen/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart'; // Unused, you can remove this if not used

import 'authentication/login.dart';
import 'authentication/signup.dart';
import 'controller/usercontroller.dart';
import 'model/leaf/leafpro.dart';
import 'view/homescreen/firstscreen.dart';
import 'controller/cartcontroller.dart';
import 'controller/srchcontrlr.dart';

void main() {
  // Lazy initialization of controllers
  Get.lazyPut<SrchController>(() => SrchController());
  Get.lazyPut<CartController>(() => CartController());
  Get.put(SignUpController());
  Get.put(UserController());

  runApp(
    GetMaterialApp(
      title: 'Leaf Coin App',
      initialBinding: BindingsBuilder(() {
        Get.put(LeafCoinController());
      }),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),  // Directly using SplashScreen as the starting screen
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();  // Empty widget as MyApp is no longer needed
  }
}
