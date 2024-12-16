import 'dart:io';
import 'package:biztrail/authentication/signup.dart';
import 'package:biztrail/view/homescreen/firstscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../common/app_colors.dart';
import '../common/textconstants.dart';

class SecondPageController extends GetxController {
  File? uploadedFile;
  var isVerifyLoading = false.obs; // Separate loading state for Verify button
  var isSkipLoading = false.obs;   // Separate loading state for Skip button
  var isFileUploaded = false.obs; // Reactive variable to track if a file is uploaded
  var isAgreed = false.obs;       // Reactive variable to track user consent

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      uploadedFile = File(result.files.single.path!); // Safely access file path
      isFileUploaded.value = true;
      update();
    } else {
      Get.snackbar("No File", "No file selected or invalid file path.");
    }
  }

  Future<void> submitForm() async {
    isVerifyLoading.value = true;
    try {
      final url = Uri.parse('https://btobapi-production.up.railway.app/api/business_users/');
      final request = http.MultipartRequest('POST', url)
        ..fields['id'] = Get.find<SignUpController>().id.value
        ..fields['company_name'] = Get.find<SignUpController>().companyName.value
        ..fields['contact_person'] = Get.find<SignUpController>().contactPerson.value
        ..fields['referral_code'] = Get.find<SignUpController>().referralCode.value
        ..fields['phone'] = Get.find<SignUpController>().phone.value;

      if (uploadedFile != null) {
        request.files.add(await http.MultipartFile.fromPath('uploaded_file', uploadedFile!.path));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        Get.snackbar("Success", "Sign up successful!");
        Get.offAll(() => FirstScreen(companyName: Get.find<SignUpController>().companyName.value));
      } else {
        print("Error: $responseBody");
        Get.snackbar("Error", "Failed to sign up: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isVerifyLoading.value = false;
    }
  }

  Future<void> skipForm() async {
    isSkipLoading.value = true;
    try {
      final url = Uri.parse('https://btobapi-production.up.railway.app/api/business_users/');
      final response = await http.post(url, body: {
        'company_name': Get.find<SignUpController>().companyName.value,
        'contact_person': Get.find<SignUpController>().contactPerson.value,
        'referral_code': Get.find<SignUpController>().referralCode.value,
        'phone': Get.find<SignUpController>().phone.value,
      });

      if (response.statusCode == 201) {
        Get.snackbar("Success", "Skipped successfully!");
        Get.offAll(() => FirstScreen(companyName: Get.find<SignUpController>().companyName.value));
      } else {
        print("Error: ${response.body}");
        Get.snackbar("Error", "Failed to skip: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isSkipLoading.value = false;
    }
  }
}

class SecondPage extends StatelessWidget {
  final controller = Get.put(SecondPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: black),
            onPressed: () {}
        ),
        title: Text(
          "KYC Verification",
          style: NeededTextstyles.style55,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "For completion of registration,\nplease upload ANY ONE of the following\ndocument",
                style: NeededTextstyles.style50,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.info_outline, size: 20, color: kyc),
                  SizedBox(width: 8),
                  Text(
                    "Why this is needed?",
                    style: NeededTextstyles.style56,
                  ),
                ],
              ),
              SizedBox(height: 50),
              _buildOwnershipButton(),
              SizedBox(height: 16),
              _buildGstButton(),
              SizedBox(height: 50),
              Row(
                children: [
                  Obx(() => Checkbox(
                    value: controller.isAgreed.value,
                    onChanged: (value) {
                      controller.isAgreed.value = value!;
                    },
                    activeColor: maintheme1,
                  )),
                  Expanded(
                    child: Text(
                      "I agree with giving above documents",
                      style: NeededTextstyles.style56,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Obx(
                    () => Center(
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: controller.isSkipLoading.value ? null : controller.skipForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: maintheme1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: controller.isSkipLoading.value
                              ? CircularProgressIndicator(color: white)
                              : Text(
                            "Skip",
                            style: NeededTextstyles.style57,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: controller.isFileUploaded.value &&
                              controller.isAgreed.value &&
                              !controller.isVerifyLoading.value
                              ? controller.submitForm
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.isFileUploaded.value &&
                                controller.isAgreed.value
                                ? maintheme1
                                : kycCo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: controller.isVerifyLoading.value
                              ? CircularProgressIndicator(color: white)
                              : Text(
                            "Verify",
                            style: NeededTextstyles.style57,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOwnershipButton() {
    return GestureDetector(
      onTap: controller.pickFile,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Obx(
                () => Text(
              controller.isFileUploaded.value ? "Ownership Certificate Uploaded" : "Upload Ownership Certificate",
              style: NeededTextstyles.style54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGstButton() {
    return GestureDetector(
      onTap: controller.pickFile,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Obx(
                () => Text(
              controller.isFileUploaded.value ? "GST Certificate Uploaded" : "Upload GST Certificate",
              style: NeededTextstyles.style54,
            ),
          ),
        ),
      ),
    );
  }
}
