import 'package:biztrail/controller/cartcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/textconstants.dart';
import '../../../controller/chandeaddress_ctlr.dart';
import '../payment/success.dart';


class ChangeAddress extends StatelessWidget {
  const ChangeAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final changeAddressController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Form(
              child: Column(
                children: [
                  Text("Add a new address", style: NeededTextstyles.style3),
                  SizedBox(height: 30),
                  // Single TextFormField
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter Address here..',
                        hintStyle: NeededTextstyles.style03),
                    onChanged: (value) =>
                    changeAddressController.address.value = value,
                  ),
                  SizedBox(height: 20),
                  // Save address button
                  SizedBox(
                    height: 40,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: ()
                      async {
                        final cartController = Get.find<CartController>();

                        if (cartController.address.value.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Please provide a billing address before placing the order.',
                            snackPosition: SnackPosition.BOTTOM,

                          );
                          Get.to(() => FadeInAndSlide());
                          return;
                        }

                        if (cartController.cartItems.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Your cart is empty. Add items before placing an order.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          Get.to(() => FadeInAndSlide());
                          return;
                        }

                        // // Assuming `product` is the current product being ordered
                        // await cartController.placeOrder(product);
                        Get.back();
                      },
                      child:
                      Text("Save Address", style: NeededTextstyles.style05),
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Darktheme1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}