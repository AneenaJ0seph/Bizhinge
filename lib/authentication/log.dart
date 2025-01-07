import 'package:biztrail/common/textconstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/app_colors.dart';
import '../controller/loginctrlr.dart';


class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  TextEditingController namectrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
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
                  'Welcome Back!',
                  style:NeededTextstyles.style18,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Login to explore authentic ayurvedic medicines,',
                  style:NeededTextstyles.style03,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'herbal remedies,and personalized wellness',
                  style:NeededTextstyles.style03,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Solutions for a healthier, balanced life.',
                  style:NeededTextstyles.style03,
                ),
              ),
              SizedBox(height: 50),
              // TextField(
              //   controller: loginController.phoneController,
              //   decoration: InputDecoration(
              //   hintText: "phone number",
              //   prefixIcon: Icon(Icons.phone),
              //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              // ),
              //   keyboardType: TextInputType.phone,
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: namectrlr,
                    decoration: InputDecoration(
                      hintText: 'Shopname',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.maps_home_work_sharp),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: loginController.phoneController,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(height: 20),
              Obx(() {
                return loginController.isLoading.value
                    ? CircularProgressIndicator()
                    : SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: loginController.login,
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 6,
                        backgroundColor: Color(0xff6EBC31),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        )),
                  ),
                );
                //     : ElevatedButton(
                //   onPressed: loginController.login,
                //   child: Text('Login'),
                // );
              }),
            ],
          ),
        ),
      ),
    );
  }
}