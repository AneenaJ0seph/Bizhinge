import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../authentication/signup.dart';
import '../model/logmodel.dart';
import '../view/homescreen/mainscreen/firstscreen.dart';
// Import the UserModel class here

// class LoginController extends GetxController {
//   var isLoading = false.obs;
//
//   final TextEditingController phoneController = TextEditingController();
//
//   Future<void> login() async {
//     final phone = phoneController.text.trim();
//
//     if (phone.isEmpty) {
//       Get.snackbar('Error', 'Phone number cannot be empty');
//       return;
//     }
//
//     isLoading.value = true;
//
//     try {
//       final response = await http.get(
//         Uri.parse(
//           'https://btobapi-production.up.railway.app/api/business_user/$phone',
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         final userModel = UserModel.fromJson(jsonDecode(response.body));
//
//         // Assuming the API returns valid user details
//         Get.snackbar('Success', 'Welcome ${userModel.contactPerson}');
//         Get.to(FirstScreen(companyName: '${userModel.companyName}')); // Pass the UserModel to the home page
//       } else if (response.statusCode == 404) {
//         Get.snackbar('Error', 'User not found');
//       } else {
//         Get.snackbar('Error', 'Unexpected error: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }



class LoginController extends GetxController {
  var isLoading = false.obs;
  final TextEditingController phoneController = TextEditingController();

  UserModel? userModel; // Store the UserModel after login

  Future<void> login() async {
    final phone = phoneController.text.trim();

    if (phone.isEmpty) {
      Get.snackbar('Error', 'Phone number cannot be empty');
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse(
          'http://sadapi-production.up.railway.app/api/business_users/$phone',
        ),
      );

      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(jsonDecode(response.body));
        print('UserModel ID: ${userModel!.id}'); // Debug ID

        Get.snackbar('Success', 'Welcome ${userModel!.contactPerson}');
        Get.put(userModel!); // Store globally for access in other controllers

        // Navigate to the first screen
        Get.offAll(() => FirstScreen(companyName: userModel!.companyName.toString()));
      } else if (response.statusCode == 404) {
        Get.snackbar('Error', 'User not found');
      } else {
        Get.snackbar('Error', 'Unexpected error: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
//19.11 updation
//
// class LoginController extends GetxController {
//   var isLoading = false.obs;
//   final TextEditingController phoneController = TextEditingController();
//
//   UserModel? userModel; // Store the UserModel after login
//
//   Future<void> login() async {
//     final phone = phoneController.text.trim();
//
//     if (phone.isEmpty) {
//       Get.snackbar('Error', 'Phone number cannot be empty');
//       return;
//     }
//
//     isLoading.value = true;
//
//     try {
//       final response = await http.get(
//         Uri.parse(
//           'https://btobapi-production.up.railway.app/api/business_user/$phone',
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         userModel = UserModel.fromJson(jsonDecode(response.body));
//         print('UserModel ID: ${userModel!.id}'); // Debug ID
//
//         Get.snackbar('Success', 'Welcome ${userModel!.contactPerson}');
//         Get.put(userModel!); // Store globally for access in other controllers
//
//         // Navigate to the first screen
//         Get.offAll(() => FirstScreen(companyName: userModel!.companyName.toString()));
//       } else if (response.statusCode == 404) {
//         Get.snackbar('Error', 'User not found');
//       } else {
//         Get.snackbar('Error', 'Unexpected error: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
