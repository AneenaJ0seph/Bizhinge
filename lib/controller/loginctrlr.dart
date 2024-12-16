import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/logmodel.dart'; // Import the UserModel class here

class LoginController extends GetxController {
  var isLoading = false.obs;

  final TextEditingController phoneController = TextEditingController();

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
          'https://btobapi-production.up.railway.app/api/business_user/$phone',
        ),
      );

      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(jsonDecode(response.body));

        // Assuming the API returns valid user details
        Get.snackbar('Success', 'Welcome ${userModel.contactPerson}');
        Get.offNamed('/home',
            arguments: userModel); // Pass the UserModel to the home page
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