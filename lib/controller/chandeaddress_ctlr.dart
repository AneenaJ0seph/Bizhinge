import 'package:get/get.dart';

class ChangeAddressController extends GetxController {
  var address = ''.obs;

  /// Save Address
  void saveAddress() {
    if (address.isEmpty) {
      print('Address cannot be empty!');
      return;
    }
    print('Address saved: $address');
  }
}