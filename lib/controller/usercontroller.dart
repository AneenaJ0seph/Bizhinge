import 'package:get/get.dart';

class UserController extends GetxController {
  var userAddress = "".obs;

  void updateAddress(String newAddress) {
    userAddress.value = newAddress;
  }
}
