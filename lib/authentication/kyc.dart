// import 'dart:io';
// import 'package:biztrail/view/homescreen/homescreen.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import '../common/app_colors.dart';
// import '../common/textconstants.dart';
// import '../view/homescreen/firstscreen.dart';
//
// class SecondPage extends StatefulWidget {
//   final String companyName;
//   final String contactPerson;
//   final String email;
//   final String phone;
//   final String address;
//
//   const SecondPage({
//     required this.companyName,
//     required this.contactPerson,
//     required this.email,
//     required this.phone,
//     required this.address,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _SecondPageState createState() => _SecondPageState();
// }
//
// class _SecondPageState extends State<SecondPage> {
//   bool isAgreed = false;
//   String? uploadedFile; // This will hold the path of the uploaded file
//   bool _isLoading = false;
//
//   // Method to pick files
//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
//     );
//
//     if (result != null) {
//       setState(() {
//         uploadedFile = result.files.single.path;
//       });
//
//       // Log the selected file path for debugging
//       print('Selected File Path: $uploadedFile');
//     }
//   }
//
//   // Method to submit form and upload files
//   Future<void> _submitForm() async {
//     if (!isAgreed || uploadedFile == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please agree to the terms and upload a certificate.")),
//       );
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     final url = Uri.parse('http://apib2b-production.up.railway.app/api/business_users/');
//     final request = http.MultipartRequest('POST', url)
//       ..fields['company_name'] = widget.companyName
//       ..fields['contact_person'] = widget.contactPerson
//       ..fields['email'] = widget.email
//       ..fields['phone'] = widget.phone
//       ..fields['address'] = widget.address;
//
//     // Attach the uploaded file
//     if (uploadedFile != null) {
//       print("Uploading file path: $uploadedFile");
//       request.files.add(await http.MultipartFile.fromPath('uploaded_file', uploadedFile!));
//     }
//
//     try {
//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();
//
//       // Debugging: Log the response
//       print("Response: ${response.statusCode} - $responseBody");
//
//       if (response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign Up Successful!')));
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => FirstScreen(companyName: widget.companyName),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to sign up. Status code: ${response.statusCode}')),
//         );
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $e')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   // Skip form method (Option 1)
//   Future<void> _skipForm() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     final url = Uri.parse('http://apib2b-production.up.railway.app/api/business_users/');
//
//     try {
//       final response = await http.post(url, body: {
//         'company_name': widget.companyName,
//         'contact_person': widget.contactPerson,
//         'email': widget.email,
//         'phone': widget.phone,
//         'address': widget.address,
//       });
//
//       if (response.statusCode == 301) {
//         // Handle redirection
//         String? redirectUrl = response.headers['location'];
//         if (redirectUrl != null) {
//           // Send the request to the new URL
//           final redirectResponse = await http.post(Uri.parse(redirectUrl), body: {
//             'company_name': widget.companyName,
//             'contact_person': widget.contactPerson,
//             'email': widget.email,
//             'phone': widget.phone,
//             'address': widget.address,
//           });
//
//           if (redirectResponse.statusCode == 201) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Skipped successfully!')));
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => FirstScreen(companyName: widget.companyName),
//               ),
//             );
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Failed to skip. Status code: ${redirectResponse.statusCode}')),
//             );
//           }
//         }
//       } else if (response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup successfully!',style: NeededTextstyles.style25),backgroundColor: lighttheme42,));
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => FirstScreen(companyName: widget.companyName),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to skip. Status code: ${response.statusCode}')),
//         );
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $e')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "KYC Verification",
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "For completion of registration,\nplease upload ANY ONE of the following\ndocument",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Icon(Icons.info_outline, size: 20, color: Color(0xff677294)),
//                   SizedBox(width: 8),
//                   Text(
//                     "Why this is needed?",
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 14,
//                       color: Color(0xff677294),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 50),
//               _buildUploadButton(),
//               SizedBox(height: 10),
//               _GstUploadButton(),
//               SizedBox(height: 50),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: isAgreed,
//                     onChanged: (value) {
//                       setState(() {
//                         isAgreed = value!;
//                       });
//                     },
//                     activeColor: Colors.green,
//                   ),
//                   Expanded(
//                     child: Text(
//                       "I agree with giving above documents",
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 14,
//                         color: Color(0xff677294),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5),
//               Center(
//                 child: Column(
//                   children: [
//                     _buildButton("Skip", _skipForm, Color(0xff6EBC31).withOpaci                                                              ty(0.50), Color(0xff005511)),
//                     SizedBox(height: 15),
//                     _buildButton(
//                       "Verify",
//                       isAgreed && uploadedFile != null ? _submitForm : null,
//                       Color(0xff6EBC31),
//                       Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildUploadButton() {
//     return GestureDetector(
//       onTap: pickFile,
//       child: Container(
//         height: 100,
//         padding: EdgeInsets.symmetric(vertical: 16),
//         decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: Text(
//             uploadedFile != null ? "File Uploaded" : "Ownership Certificate",
//             style: TextStyle(
//               fontFamily: 'Poppins',
//               fontSize: 14,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _GstUploadButton() {
//     return GestureDetector(
//       onTap: pickFile,
//       child: Container(
//         height: 100,
//         padding: EdgeInsets.symmetric(vertical: 16),
//         decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: Text(
//             uploadedFile != null ? "File Uploaded" : "GST Certificate",
//             style: TextStyle(
//               fontFamily: 'Poppins',
//               fontSize: 14,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildButton(String label, VoidCallback? onPressed, Color backgroundColor, Color textColor) {
//     return Container(
//       height: 40,
//       width: 200,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child: _isLoading && label == "Verify"
//             ? CircularProgressIndicator(color: textColor)
//             : Text(
//           label,
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: textColor,
//           ),
//         ),
//       ),
//     );
//   }
// }

//
// import 'dart:io';
// import 'package:biztrail/authentication/signup.dart';
// import 'package:biztrail/view/homescreen/firstscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
//
// class SecondPageController extends GetxController {
//   File? uploadedFile;
//   final isLoading = false.obs;
//
//   void pickFile() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       uploadedFile = File(pickedFile.path);
//       update(); // Ensure dependent widgets are updated.
//     }
//   }
//
//   Future<void> submitForm() async {
//     isLoading.value = true;
//
//     try {
//       final url = Uri.parse('https://apib2b-production.up.railway.app/api/business_users/');
//       final request = http.MultipartRequest('POST', url)
//         ..fields['company_name'] = Get.find<SignUpController>().companyName.value
//         ..fields['contact_person'] = Get.find<SignUpController>().contactPerson.value
//         ..fields['email'] = Get.find<SignUpController>().email.value
//         ..fields['phone'] = Get.find<SignUpController>().phone.value
//         ..fields['address'] = Get.find<SignUpController>().address.value;
//
//       if (uploadedFile != null) {
//         request.files.add(await http.MultipartFile.fromPath('uploaded_file', uploadedFile!.path));
//       }
//
//       final response = await request.send();
//       if (response.statusCode == 201) {
//         Get.snackbar("Success", "Sign up successful!");
//         Get.offAll(() => FirstScreen(companyName: Get.find<SignUpController>().companyName.value )); // Navigate to home or dashboard
//       } else {
//         Get.snackbar("Error", "Failed to sign up: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
//
// class SecondPage extends StatelessWidget {
//   final controller = Get.put(SecondPageController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//             backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "KYC Verification",
//           style: TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                  "For completion of registration,\nplease upload ANY ONE of the following\ndocument",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Icon(Icons.info_outline, size: 20, color: Color(0xff677294)),
//                   SizedBox(width: 8),
//                   Text(
//                     "Why this is needed?",
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 14,
//                       color: Color(0xff677294),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               GetBuilder<SecondPageController>(
//                 builder: (controller) => controller.uploadedFile != null
//                     ? Image.file(controller.uploadedFile!, width: 200, height: 200)
//                     : Text("No file selected"),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: controller.pickFile,
//                 child: Text("Pick File"),
//               ),
//               SizedBox(height: 32),
//               Obx(
//                     () => controller.isLoading.value
//                     ? CircularProgressIndicator()
//                     : ElevatedButton(
//                   onPressed: controller.submitForm,
//                   child: Text("Submit"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






