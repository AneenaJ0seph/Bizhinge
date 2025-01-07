import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_colors.dart';
import '../../../common/textconstants.dart';
import '../../../controller/deletecntrler.dart';
import '../../widgets/deleteclass.dart';


class Deleteee extends StatelessWidget {
  final DelController delController = Get.put(DelController()); // Use DelController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Delete Account", style: NeededTextstyles.style10),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(DeleteAccount.terms, style: NeededTextstyles.style11),
              Obx(() => CheckboxListTile(
                value: delController.agreeToTerms.value,
                onChanged: (value) {
                  delController.agreeToTerms.value = value!;
                },
                title: Text(
                  "I have read and agreed to the Terms and Conditions.",
                  style: NeededTextstyles.style11,
                ),
              )),
              Obx(() => CheckboxListTile(
                value: delController.noGiftCardBalance.value,
                onChanged: (value) {
                  delController.noGiftCardBalance.value = value!;
                },
                title: Text(
                  "I acknowledge that I do not have any Gift Card or SuperCoin balance in my account, or I am willing to forfeit them.",
                  style: NeededTextstyles.style11,
                ),
              )),
              Obx(() => CheckboxListTile(
                value: delController.noPastServices.value,
                onChanged: (value) {
                  delController.noPastServices.value = value!;
                },
                title: Text(
                  "I acknowledge that I will not be able to return/replace or seek any service regarding past orders.",
                  style: NeededTextstyles.style11,
                ),
              )),
              const SizedBox(height: 20),
              Text(
                "Please tell us why you're leaving us:",
                style: NeededTextstyles.style11,
              ),
              const SizedBox(height: 10),

              TextField(
                controller: delController.feedbackController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    hintText: "Your feedback will help us to improve.",
                    hintStyle: NeededTextstyles.style24
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              Text("Please enter the phone number you used to create the account",style: NeededTextstyles.style11,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: delController.phoneController,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      hintStyle:NeededTextstyles.style25,
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    if (delController.agreeToTerms.value &&
                        delController.noGiftCardBalance.value &&
                        delController.noPastServices.value) {
                      delController.login(); // Call the login method of DelController
                    }
                  },
                  child: Text(
                    "Continue",
                    style: NeededTextstyles.style12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}