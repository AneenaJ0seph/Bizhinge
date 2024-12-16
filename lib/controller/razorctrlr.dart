// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class RazorpayController extends GetxController {
//   late Razorpay _razorpay;
//   RxString contact = ''.obs;  // Make contact reactive
//   RxString email = ''.obs;    // Make email reactive
//
//   @override
//   void onInit() {
//     super.onInit();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void onClose() {
//     _razorpay.clear();
//     super.onClose();
//   }
//
//   // Function to call the API and fetch payment details
//   Future<void> fetchPaymentDetailsAndCheckout() async {
//     final url = 'https://apib2b-production.up.railway.app/api'; // Replace with your API endpoint
//
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         // Parse the response
//         final data = json.decode(response.body);
//
//         final amount = data['amount']; // Assuming API returns amount
//         final shopName = data['shopName']; // Assuming API returns shopName
//         final description = data['description']; // Assuming API returns description
//         final fetchedContact = data['contact']; // Assuming API returns contact
//         final fetchedEmail = data['email']; // Assuming API returns email
//
//         // Update reactive variables
//         contact.value = fetchedContact;
//         email.value = fetchedEmail;
//
//         // Proceed to open Razorpay checkout with the fetched data
//         openCheckout(
//           amount: amount,
//           shopName: shopName,
//           description: description,
//           contact: fetchedContact,
//           email: fetchedEmail,
//         );
//       } else {
//         Get.snackbar(
//           'Error',
//           'Failed to load payment details. Please try again later.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       debugPrint('Error fetching payment details: $e');
//       Get.snackbar(
//         'Error',
//         'Something went wrong. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   // Function to open Razorpay checkout
//   void openCheckout({
//     required int amount,
//     required String shopName,
//     required String description,
//     required String contact,
//     required String email,
//   }) {
//     var options = {
//       'key': 'rzp_live_ILgsfZCZoFIKMb', // Replace with your Razorpay key
//       'amount': amount*100 , // Amount in paise
//       'name': shopName,
//       'description': description,
//       'prefill': {
//         'contact': contact,
//         'email': email,
//       },
//       'retry': {'enabled': true, 'max_count': 1},
//       'external': {
//         'wallets': ['paytm'],
//       },
//     };
//
//     try {
//       debugPrint('Opening Razorpay with options: $options');
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error opening Razorpay: $e');
//       Get.snackbar(
//         'Error',
//         'Could not open Razorpay. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     debugPrint('Payment Successful: ${response.paymentId}');
//     Get.snackbar('Success', 'Payment was successful!',
//         snackPosition: SnackPosition.BOTTOM);
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     debugPrint('Payment Failed: Code - ${response.code}, Message - ${response.message}');
//     Get.snackbar(
//       'Payment Failed',
//       'Code: ${response.code}, Message: ${response.message}',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     debugPrint('External Wallet: ${response.walletName}');
//     Get.snackbar(
//       'External Wallet Selected',
//       'Selected wallet: ${response.walletName}',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../payment/confirm_failed.dart';
import '../payment/success.dart';


class RazorpayController extends GetxController {
  late Razorpay _razorpay;
  RxString contact = ''.obs;  // Make contact reactive
  RxString email = ''.obs;    // Make email reactive

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  // Function to call the API and fetch payment details
  Future<void> fetchPaymentDetailsAndCheckout() async {
    final url = 'http://btobapi-production.up.railway.app/api'; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parse the response
        final data = json.decode(response.body);

        final amount = data['amount']; // Assuming API returns amount
        final shopName = data['shopName']; // Assuming API returns shopName
        final description = data['description']; // Assuming API returns description
        final fetchedContact = data['contact']; // Assuming API returns contact
        final fetchedEmail = data['email']; // Assuming API returns email

        // Update reactive variables
        contact.value = fetchedContact;
        email.value = fetchedEmail;

        // Proceed to open Razorpay checkout with the fetched data
        openCheckout(
          amount: amount*100,
          shopName: shopName,
          description: description,
          contact: fetchedContact,
          email: fetchedEmail,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to load payment details. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint('Error fetching payment details: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Function to open Razorpay checkout
  void openCheckout({
    required int amount,
    required String shopName,
    required String description,
    required String contact,
    required String email,
  }) {
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb', // Replace with your Razorpay key
      'amount': amount , // Amount in paise
      'name': shopName,
      'description': description,
      'prefill': {
        'contact': contact,
        'email': email,
      },
      'retry': {'enabled': true, 'max_count': 1},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      debugPrint('Opening Razorpay with options: $options');
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error opening Razorpay: $e');
      Get.snackbar(
        'Error',
        'Could not open Razorpay. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint('Payment Successful: ${response.paymentId}');
    // Get.snackbar('Success', 'Payment was successful!',
    //     snackPosition: SnackPosition.BOTTOM);
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        Get.context!,
        MaterialPageRoute(builder: (context) => const FadeInAndSlide()),
      );
    });
  }

  // Handle payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('Payment Failed: Code - ${response.code}, Message - ${response.message}');
    // Show error message
    // Get.snackbar(
    //   'Payment Failed',
    //   'Code: ${response.code}, Message: ${response.message}',
    //   snackPosition: SnackPosition.BOTTOM,
    // );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        Get.context!,
        MaterialPageRoute(builder: (context) =>  OrderFailedPage()),
      );
    });
  }

  // Handle external wallet
  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet: ${response.walletName}');
    Get.snackbar(
      'External Wallet Selected',
      'Selected wallet: ${response.walletName}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
