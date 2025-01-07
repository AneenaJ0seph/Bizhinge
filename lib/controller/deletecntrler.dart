import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/logmodel.dart';
import '../view/widgets/deleteconfirm.dart';// Import the UserModel

class DelController extends GetxController {
  var isLoading = false.obs;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  var agreeToTerms = false.obs;
  var noGiftCardBalance = false.obs;
  var noPastServices = false.obs;

  UserModel? userModel;

  @override
  void onClose() {
    phoneController.dispose();
    feedbackController.dispose();
    super.onClose();
  }

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
        userModel = UserModel.fromJson(jsonDecode(response.body));
        print('UserModel Phone: ${userModel!.phone}'); // Debug phone number
        Get.to(() =>
            DeleteAccountPage(phone: userModel?.phone ?? '')
        );
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