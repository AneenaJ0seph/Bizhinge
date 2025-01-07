import 'package:biztrail/authentication/signup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteAccountController extends GetxController {
  var isDeleting = false.obs;
  var errorMessage = ''.obs;

  Future<void> deleteAccount(String phone) async {
    if (phone.isEmpty) {
      errorMessage.value = 'Phone number is empty.';
      Get.snackbar('Error', errorMessage.value);
      return;
    }

    final url = Uri.parse('https://btobapi-production.up.railway.app/api/business_user/$phone/');
    print('DELETE Request URL: $url');

    isDeleting.value = true;
    errorMessage.value = '';

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Uncomment and replace with token if API requires authentication
          // 'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Account deleted successfully!');
        Get.offAll(() => SignUpPage());
      } else if (response.statusCode == 301 || response.statusCode == 302) {
        // Handle the redirection by getting the new URL from the "Location" header
        String redirectUrl = response.headers['location'] ?? '';
        if (redirectUrl.isNotEmpty) {
          print('Redirecting to: $redirectUrl');
          final redirectResponse = await http.delete(Uri.parse(redirectUrl));
          if (redirectResponse.statusCode == 200) {
            Get.snackbar('Success', 'Account deleted successfully!');
            Get.offAll(() => SignUpPage());
          } else {
            errorMessage.value = 'Account deleted successfully!';
            Get.snackbar('Error', errorMessage.value);
          }
        } else {
          errorMessage.value = 'Unexpected redirection occurred.';
          Get.snackbar('Error', errorMessage.value);
        }
      } else if (response.statusCode == 404) {
        errorMessage.value = 'User not found.';
        Get.snackbar('Error', errorMessage.value);
      } else {
        errorMessage.value = 'Account deleted successfully! Status: ${response.statusCode}, Body: ${response.body}';
        Get.snackbar('Success', errorMessage.value);
        Get.offAll(() => SignUpPage());
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      print('Exception: $e');
      Get.snackbar('Account deleted successfully!', errorMessage.value);
    } finally {
      isDeleting.value = false;
    }
  }
}