// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'confirm_sucess.dart';
// import 'confirmsuccess.dart';
//
// class FadeInAndSlide extends StatefulWidget {
//   const FadeInAndSlide({super.key});
//
//   @override
//   State<FadeInAndSlide> createState() => _FadeInAndSlideState();
// }
//
// class _FadeInAndSlideState extends State<FadeInAndSlide> {
//   @override
//   void initState() {
//     super.initState();
//
//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>  OrderConfirmationScreen(),
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       body: Center(
//         child: LottieBuilder.asset(
//           'assets/animations/animsuccess.json',
//           height: 400,
//           width: 400,
//           fit: BoxFit.fill,
//           repeat: false,
//           onLoaded: (composition) {
//             print('Animation loaded: ${composition.duration}');
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'confirm_sucess.dart';// Ensure this file contains OrderConfirmationScreen

class FadeInAndSlide extends StatelessWidget {
  const FadeInAndSlide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Navigate to OrderConfirmationScreen after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => OrderConfirmationScreen());
    });

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: LottieBuilder.asset(
          'assets/animations/animsuccess.json',
          height: 400,
          width: 400,
          fit: BoxFit.fill,
          repeat: false,
          onLoaded: (composition) {
            print('Animation loaded: ${composition.duration}');
          },
        ),
      ),
    );
  }
}
