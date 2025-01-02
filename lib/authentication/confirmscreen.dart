import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/loginctrlr.dart';


class ConfirmScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 350),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50, left: 10),
                child: Text(
                  'Confirm your phone number',
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: loginController.phoneController,
                decoration: InputDecoration(
                  hintText: "phone number",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              Obx(() {
                return loginController.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: loginController.login,
                  child: Text('Sign In'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}