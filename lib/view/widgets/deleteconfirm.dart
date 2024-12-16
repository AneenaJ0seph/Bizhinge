import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../common/app_colors.dart';
import '../../common/textconstants.dart';
import 'package:biztrail/authentication/signup.dart';

class DeleteAccountPage extends StatelessWidget {
  Future<void> _deleteAccount(BuildContext context) async {
    final String apiUrl = "https://apib2b-production.up.railway.app/api/business_users/{id}"; // Replace {id} with actual user ID.
    final String token = "your_auth_token"; // Replace with actual token if required.

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Use ScaffoldMessenger safely
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Account deleted successfully.",
                style: NeededTextstyles.style05,
              ),
            ),
          );

          // Navigate to SignUpPage
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
                (route) => false,
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Failed to delete account. Server responded with: ${response.body}",
                style: NeededTextstyles.style05,
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "An error occurred. Please check your internet connection or try again later.",
              style: NeededTextstyles.style05,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
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
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _deleteAccount(context);
                              },
                              child: Text(
                                "Delete",
                                style: NeededTextstyles.style7,
                              ),
                            ),
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
          ],
        ),
      ),
    );
  }
}
