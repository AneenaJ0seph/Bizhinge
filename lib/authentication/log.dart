import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/loginctrlr.dart';


class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: loginController.phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Obx(() {
              return loginController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: loginController.login,
                child: Text('Login'),
              );
            }),
          ],
        ),
      ),
    );
  }
}