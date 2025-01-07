// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../common/app_colors.dart';
// import '../../common/textconstants.dart';
// import 'package:biztrail/authentication/signup.dart';
//
// class DeleteAccountPage extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//         backgroundColor: white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "Delete Account",
//           style: NeededTextstyles.style4,
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Are you sure you want to delete your account?",
//               style: NeededTextstyles.style3,
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Deleting your account will permanently remove all your data, including your order history, preferences, and uploaded documents. This action cannot be undone.",
//               style: NeededTextstyles.style2,
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Icon(Icons.warning_amber_rounded, color: red, size: 20),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     "Any ongoing orders or payments will be canceled, and related parties may be notified.",
//                     style: NeededTextstyles.style5,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 40),
//             Center(
//               child: Column(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: Text(
//                             "Confirm Delete",
//                             style: NeededTextstyles.style6,
//                           ),
//                           content: Text(
//                             "Are you sure you want to delete your account? This action cannot be undone.",
//                             style: NeededTextstyles.style2,
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: Text(
//                                 "Cancel",
//                                 style: NeededTextstyles.style2,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//
//                               },
//                               child: Text(
//                                 "Delete",
//                                 style: NeededTextstyles.style7,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: red,
//                       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       "Delete Account",
//                       style: NeededTextstyles.style8,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       "Cancel",
//                       style: NeededTextstyles.style9,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/app_colors.dart';
import '../../common/textconstants.dart';
import '../../controller/deleteaccontroller.dart';

class DeleteAccountPage extends StatelessWidget {
  final DeleteAccountController deleteController = Get.put(DeleteAccountController());
  final String phone;

  DeleteAccountPage({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Phone passed to DeleteAccountPage: $phone'); // Debugging

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Delete Account",
          style: NeededTextstyles.style4,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you sure you want to delete your account?",
                style: NeededTextstyles.style3,
              ),
              SizedBox(height: 8),
              Text(
                "Deleting your account will permanently remove all your data, including your order history, preferences, and uploaded documents. This action cannot be undone.",
                style: NeededTextstyles.style2,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: red, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Any ongoing orders or payments will be canceled, and related parties may be notified.",
                      style: NeededTextstyles.style5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "Confirm Delete",
                              style: NeededTextstyles.style6,
                            ),
                            content: Text(
                              "Are you sure you want to delete your account? This action cannot be undone.",
                              style: NeededTextstyles.style2,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Cancel",
                                  style: NeededTextstyles.style2,
                                ),
                              ),
                              Obx(() => deleteController.isDeleting.value
                                  ? CircularProgressIndicator()
                                  : TextButton(
                                onPressed: () => deleteController.deleteAccount(phone),
                                // style: ElevatedButton.styleFrom(
                                //   backgroundColor: Colors.redAccent,
                                // ),
                                child: Text(
                                  "Delete",
                                  style: NeededTextstyles.style7,
                                ),
                              )),
                              // TextButton(
                              //   onPressed: () {
                              //     Navigator.pop(context);
                              //
                              //   },
                              //   child: Text(
                              //     "Delete",
                              //     style: NeededTextstyles.style7,
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Delete Account",
                        style: NeededTextstyles.style8,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: NeededTextstyles.style9,
                      ),
                    ),
                  ],
                ),
              ),

              // Obx(() => deleteController.isDeleting.value
              //     ? CircularProgressIndicator()
              //     : ElevatedButton(
              //   onPressed: () => deleteController.deleteAccount(phone),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.redAccent,
              //   ),
              //   child: Text(
              //     'DELETE ACCOUNT',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // )),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () => Get.back(),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.grey,
              //   ),
              //   child: Text('CANCEL'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}