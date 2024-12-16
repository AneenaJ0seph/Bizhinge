// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'kyc.dart';
//
// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});
//
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }
//
// class _SignUpPageState extends State<SignUpPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _companyNameController = TextEditingController();
//   final TextEditingController _contactPersonController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   bool isChecked = false;
//
//   void _goToNextPage() {
//     if (_formKey.currentState?.validate() ?? false) {
//       if (!isChecked) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('You must accept the terms and conditions')),
//         );
//         return;
//       }
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SecondPage(
//             companyName: _companyNameController.text,
//             contactPerson: _contactPersonController.text,
//             email: _emailController.text,
//             phone: _phoneController.text,
//             address: _addressController.text,
//           ),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 350),
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.arrow_back_ios),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 50, left: 10),
//                   child: Text(
//                     'Join us to start searching',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: Text(
//                     'Sign up to explore and buy authentic',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20),
//                   child: Text(
//                     'Ayurvedic medicines!',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 50),
//                 _buildTextField(
//                   controller: _companyNameController,
//                   hint: 'Shop Name',
//                   icon: Icons.maps_home_work_sharp,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Shop Name cannot be empty';
//                     }
//                     if (value.contains("@")) {
//                       return 'Invalid Shop Name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 5),
//                 _buildTextField(
//                   controller: _contactPersonController,
//                   hint: 'Owner Name',
//                   icon: Icons.person,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Owner Name cannot be empty';
//                     }
//                     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
//                       return 'Name must contain only letters';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 5),
//                 _buildTextField(
//                   controller: _phoneController,
//                   hint: 'Phone',
//                   icon: Icons.phone,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Phone number cannot be empty';
//                     }
//                     if (!RegExp(r'^\d{10}$').hasMatch(value)) {
//                       return 'Enter a valid 10-digit phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 5),
//                 _buildTextField(
//                   controller: _addressController,
//                   hint: 'Shop Address',
//                   icon: Icons.maps_home_work_sharp,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Address cannot be empty';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 5),
//                 _buildTextField(
//                   controller: _emailController,
//                   hint: 'Referral (Optional)',
//                   icon: Icons.wallet_giftcard_rounded,
//                 ),
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 40),
//                   child: FormField<bool>(
//                     initialValue: isChecked,
//                     validator: (value) {
//                       if (!isChecked) {
//                         return "You must accept the terms and conditions.";
//                       }
//                       return null;
//                     },
//                     builder: (formFieldState) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isChecked = !isChecked;
//                                     formFieldState.didChange(isChecked);
//                                   });
//                                 },
//                                 child: Container(
//                                   height: 20,
//                                   width: 20,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: isChecked ? Color(0xff6EBC31) : Colors.grey,
//                                       width: 2,
//                                     ),
//                                     color: isChecked ? Color(0xff6EBC31) : Colors.transparent,
//                                   ),
//                                   child: isChecked
//                                       ? Icon(
//                                     Icons.check,
//                                     color: Colors.white,
//                                     size: 14,
//                                   )
//                                       : null,
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               Expanded(
//                                 child: Text(
//                                   'I agree with the terms of Service & Privacy Policy',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           if (formFieldState.hasError)
//                             Padding(
//                               padding: const EdgeInsets.only(left: 30, top: 5),
//                               child: Text(
//                                 formFieldState.errorText!,
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 ElevatedButton(
//                   onPressed: _goToNextPage,
//                   child: Text(
//                     "Sign up",
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     elevation: 6,
//                     backgroundColor: Color(0xff6EBC31),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 50),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(left: 85),
//                 //   child: Row(
//                 //     children: [
//                 //       Text(
//                 //         'Already have an account ?',
//                 //         style: GoogleFonts.poppins(
//                 //           fontSize: 12,
//                 //           fontWeight: FontWeight.w400,
//                 //           color: Color(0xff6EBC31),
//                 //         ),
//                 //       ),
//                 //       Expanded(
//                 //         child: GestureDetector(
//                 //           child: Text(
//                 //             ' Connect us',
//                 //             style: GoogleFonts.poppins(
//                 //               fontSize: 12,
//                 //               fontWeight: FontWeight.w400,
//                 //               color: Color(0xff6EBC31),
//                 //             ),
//                 //           ),
//                 //           onTap: (){
//                 //             Navigator.push(
//                 //               context,
//                 //               MaterialPageRoute(builder: (context) =>  Login()),
//                 //             );
//                 //           },
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // SizedBox(height: 10,)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hint,
//     required IconData icon,
//     String? Function(String?)? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(
//             fontFamily: 'Poppins',
//             fontSize: 15,
//             color: Colors.grey,
//           ),
//           prefixIcon: Icon(icon),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//         validator: validator,
//       ),
//     );
//   }
// }

import 'package:biztrail/authentication/secondpage.dart';
import 'package:biztrail/authentication/signin.dart';

import 'package:biztrail/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/textconstants.dart';


class SignUpController extends GetxController {
  final companyName = ''.obs;

  final id=''.obs;
  final contactPerson = ''.obs;
  final referralCode = ''.obs;
  final phone = ''.obs;
  // final address = ''.obs;
  var isChecked = false.obs;

  bool validateInputs() {
    if (companyName.isEmpty || contactPerson.isEmpty || phone.isEmpty ) {
      Get.snackbar("Error", "All fields except referral are mandatory.");
      return false;
    }
    if (!RegExp(r'^\d{10}$').hasMatch(phone.value)) {
      Get.snackbar("Error", "Phone number must be 10 digits.");
      return false;
    }
    return true;
  }
}

class SignUpPage extends StatelessWidget {
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 350),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60, left: 10),
                child: Text(
                  'Join us to start searching',
                  style: NeededTextstyles.style18,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Sign up to explore and buy authentic',
                  style: NeededTextstyles.style03,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Ayurvedic medicines !',
                  style:NeededTextstyles.style03,
                ),
              ),
              SizedBox(height: 50),

              _buildTextField(
                hint: "Shopname",
                icon: Icons.store,
                onChanged: (value) => controller.companyName.value = value,
              ),
              SizedBox(height: 10),
              _buildTextField(
                hint: "Ownername",
                icon: Icons.person,
                onChanged: (value) => controller.contactPerson.value = value,
              ),
              SizedBox(height: 10),
              _buildTextField(
                hint: "Phone",
                icon: Icons.phone,
                onChanged: (value) => controller.phone.value = value,
              ),
              // SizedBox(height: 5),
              // _buildTextField(
              //   hint: "Shop Address",
              //   icon: Icons.location_on,
              //   onChanged: (value) => controller.address.value = value,
              // ),
              SizedBox(height: 10),
              _buildTextField(
                hint: "Referral (Optional)",
                icon: Icons.wallet_giftcard_rounded,
                onChanged: (value) => controller.referralCode.value = value,
              ),
              SizedBox(height: 30),
              Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,

                            child: Checkbox(
                                              value: controller.isChecked.value,
                                              onChanged: (value) => controller.isChecked.value = value!,
                                              shape: CircleBorder(), // Circular checkbox shape
                                              activeColor:maintheme1, // Active color
                                              checkColor: white, // Checkmark color
                                            ),
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            child: Text(
                              'I agree with the terms of Service & Privacy Policy',
                              style:NeededTextstyles.style03,
                            ),
                          ),
                        ],
                      ),
                    ),
              ),

              SizedBox(height: 20,),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {


                      if (controller.validateInputs() && controller.isChecked.value) {
                        Get.to(() => SecondPage()); // Navigate to the next page after signing up
                      } else if (!controller.isChecked.value) {
                        Get.snackbar("Error", "You must accept the terms and conditions.");
                      }

                  },
                  child: Text(
                    "Sign up",
                    style:NeededTextstyles.style66,
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 6,
                      backgroundColor: maintheme1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(left: 85),
                child: Row(
                  children: [
                    Text(
                      'Already have an account ?',
                      style:  NeededTextstyles.style17,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Text(
                          ' Connect us',
                          style: NeededTextstyles.style17,
                        ),
                        onTap: (){
                          Get.to(() => SignInPage());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),


            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: NeededTextstyles.style19,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}

