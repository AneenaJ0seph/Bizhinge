import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../view/homescreen/firstscreen.dart';

class SignInController extends GetxController {
  final companyName = ''.obs;
  final phone = ''.obs;

  // Validation method
  bool validateInputs() {
    if (companyName.value.isEmpty || phone.value.isEmpty) {
      Get.snackbar("Error", "Both fields are required.");
      return false;
    }

    // Validate phone number format (basic validation for 10 digits)
    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone.value)) {
      Get.snackbar("Error", "Please enter a valid 10-digit phone number.");
      return false;
    }

    return true;
  }

  Future<void> signIn() async {
    if (!validateInputs()) return;

    try {
      final url = Uri.parse('http://btobapi-production.up.railway.app/api/business_users/');

      // Prepare the request body
      final Map<String, dynamic> body = {
        "company_name": companyName.value.trim(),
        "phone": phone.value.trim(),
      };

      // Log the request body for debugging purposes
      print("Request Payload: $body");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Log the response for debugging
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Check if the request was successful
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Log the response data to understand its structure
        print("Response Data: $responseData");

        // Check if the expected data (e.g., user information) is returned
        if (responseData['company_name'] == companyName.value && responseData['phone'] == phone.value) {
          Get.snackbar("Success", "Signed in successfully!");
          Get.offAll(() => FirstScreen(companyName: companyName.value)); // Navigate to home screen
        } else {
          Get.snackbar("Error", "Invalid credentials. Please sign up first.");
        }
      } else if (response.statusCode == 400) {
        // If the response has a 400 status, the server may provide additional error information
        final error = jsonDecode(response.body);
        String errorMessage = error['message'] ?? 'Invalid request';
        Get.snackbar("Error", errorMessage);
      } else if (response.statusCode == 500) {
        // Handle server errors
        Get.snackbar("Error", "Server error, please try again later.");
      } else {
        // Handle unexpected status codes
        Get.snackbar("Error", "Unexpected error: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      // Handle exceptions
      print("Error occurred: $e");
      print("Stack Trace: $stackTrace");
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
