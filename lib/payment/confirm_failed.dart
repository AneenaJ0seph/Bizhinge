import 'package:biztrail/view/homescreen/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


import '../common/app_colors.dart';
import '../main.dart';


class OrderFailedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                'assets/animations/anim.json',
                height: 250,
                width: 400,
                fit: BoxFit.fill,
                repeat: true,
                onLoaded: (composition) {
                  final adjustedDuration = composition.duration ~/ 500;
                  print('Adjusted Duration: $adjustedDuration');
                },
              ),
              SizedBox(height: 20),
              Text(
                "Order Failed",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Something went wrong while processing your order.\nPlease try again.",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),

              SizedBox(
                height: 30,
                width: 244,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15),
                    ),
                  ),
                  child: Text(
                    "Retry",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 30,
                width: 244,
                child: ElevatedButton(
                  onPressed: () {

                    // Navigator.pushNamed(context, '/MyHomePage');

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // Responsive border radius
                    ),
                  ),
                  child: Text(
                    "Back to Cart",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color:red,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
