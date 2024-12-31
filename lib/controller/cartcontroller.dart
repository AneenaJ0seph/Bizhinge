import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/productmodel.dart';
import '../view/homescreen/leaf/leafpro.dart';
import '../view/homescreen/payment/success.dart';
import 'loginctrlr.dart';

class CartController extends GetxController {
  final String baseUrl =
      'https://btobapi-production.up.railway.app/api/';
  var cartItems = <Product>[].obs;
  var totalPrice = 0.0.obs;
  var address = ''.obs;
  var isLoading = false.obs;

  // Options for additional items
  var addSample = false.obs;
  var addDisplayStand = false.obs;
  var addBrochure = false.obs;
  var addLeafcoin = false.obs;

  // Add item to cart
  void addToCart(Product product) {
    var existingProduct =
    cartItems.firstWhereOrNull((item) => item.id == product.id);

    if (existingProduct == null) {
      // If not present, add new product with initial quantity of 1
      product.minimumOrderQuantity = (product.minimumOrderQuantity ?? 0) + 1;
      cartItems.add(product);
    } else {
      // If already exists, increment quantity
      existingProduct.minimumOrderQuantity =
          (existingProduct.minimumOrderQuantity ?? 0) + 1;
    }
    calculateTotalPrice();
    Get.snackbar(
      'Added to Cart',
      '${product.productName ?? "Item"} has been added to your cart.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Remove a single quantity of an item or remove it entirely
  void removeFromCart(Product product) {
    var existingProduct =
    cartItems.firstWhereOrNull((item) => item.id == product.id);

    if (existingProduct != null) {
      cartItems.remove(existingProduct);
      calculateTotalPrice();
      Get.snackbar(
        'Removed from Cart',
        '${product.productName ?? "Item"} has been removed from your cart.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Increase quantity for a specific product
  void increaseQuantity(Product product) {
    var existingProduct =
    cartItems.firstWhereOrNull((item) => item.id == product.id);

    if (existingProduct != null) {
      existingProduct.minimumOrderQuantity =
          (existingProduct.minimumOrderQuantity ?? 0) + 1;
      calculateTotalPrice();
    }
  }

  // Decrease quantity for a specific product
  void decreaseQuantity(Product product) {
    var existingProduct =
    cartItems.firstWhereOrNull((item) => item.id == product.id);

    if (existingProduct != null) {
      if ((existingProduct.minimumOrderQuantity ?? 0) > 1) {
        existingProduct.minimumOrderQuantity =
            (existingProduct.minimumOrderQuantity ?? 0) - 1;
        calculateTotalPrice();
      } else {
        // Remove item entirely if quantity becomes 0
        removeFromCart(product);
      }
    }
  }

  void clearCart() {
    cartItems.clear();
    calculateTotalPrice();
    Get.snackbar(
      'Cart Cleared',
      'All items have been removed from your cart.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Calculate total price of items in the cart
  void calculateTotalPrice() {
    totalPrice.value = cartItems.fold(
      0.0,
          (sum, item) {
        // Ensure neither item.price nor item.minimumOrderQuantity is null
        final itemPrice = item.price ?? 0.0;
        final itemQuantity = item.minimumOrderQuantity ?? 1;
        return sum + (itemPrice * itemQuantity);
      },
    );
  }

  // Options for additional items
  double get discountPrice => totalPrice.value > 100 ? 10.0 : 0.0;

  LeafCoinController leafCoinController = LeafCoinController();

  double get finalPrice {
    return totalPrice.value +
        (addSample.value ? 0.0 : 0.0) +
        (addDisplayStand.value ? 0.0 : 0.0) +
        (addBrochure.value ? 0.0 : 0.0) +
        (addLeafcoin.value ? 0.0 : leafCoinController.availableCoins.value) -
        discountPrice;
  }

  // Toggle methods for additional items
  void toggleAddSample(bool value) => addSample.value = value;
  void toggleAddDisplayStand(bool value) => addDisplayStand.value = value;
  void toggleAddBrochure(bool value) => addBrochure.value = value;
  void toggleAddLeafcoin(bool value) => addLeafcoin.value = value;

  // Checkout method to submit the order and clear the cart
  Future<void> checkout() async {
    if (cartItems.isEmpty) {
      Get.snackbar("Error", "Your cart is empty!");
      return;
    }

    isLoading.value = true;

    final orderData = {
      "business_user": null,
      "total_price": totalPrice.value,
      "billing_address": address.value,
      "status": "Processing",
      "order_type": "Online",
      "order_products": cartItems
          .map((item) => {
        "product": item.id,
        "product_name": item.productName,
        "quantity": item.minimumOrderQuantity,
        "price": item.price.toString(),
      })
          .toList(),
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(orderData),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Your order has been placed successfully!");
        clearCart();
      } else {
        Get.snackbar(
            "Error", "Failed to place the order. ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Method to update the user's address in the backend
  Future<void> updateAddress(String newAddress) async {
    isLoading.value = true;
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/orders/'), // Replace '1' with user ID
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'address': newAddress}),
      );

      if (response.statusCode == 200) {
        address.value = newAddress;
        Get.snackbar('Success', 'Address updated successfully.');
      } else {
        Get.snackbar(
            'Error', 'Failed to update address. ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> placeOrder(Product product) async {
    if (cartItems.isEmpty) {
      Get.snackbar('Error', 'Cart is empty');
      return;
    }

    final loginController = Get.find<LoginController>();
    final userModel = loginController.userModel;


    if (userModel == null) {
      Get.snackbar('Error', 'User not logged in. Please log in again.');
      return;
    }

    print("UserModel ID: ${userModel.id}");

    final orderData = {
      "business_user": userModel.id, // Use ID from LoginController
      "order_date": DateTime.now().toIso8601String(),
      "total_price": totalPrice.toStringAsFixed(2),
      "billing_address": address.value,
      "status": "Processing",
      "order_type": "Online",
      "order_products": cartItems.map((item) {
        return {
          "product": item.id,
          "product_name": item.productName ?? "Unknown Product",
          "quantity": item.minimumOrderQuantity ?? 1,
          "price": item.price?.toString() ?? "0.0",
        };
      }).toList(),
    };

    print('Order Data: ${json.encode(orderData)}');

    try {
      final response = await http.post(
        Uri.parse('https://btobapi-production.up.railway.app/api/orders/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orderData),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {

        Get.snackbar('Success', 'Order placed successfully');
        Get.to(() => FadeInAndSlide());
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['detail'] ?? 'Unexpected error';
        Get.snackbar('Error', errorMessage);
        Get.to(() => FadeInAndSlide());
      }
    } catch (e) {
      print('Error occurred: $e');
      Get.snackbar('Error', 'An error occurred while placing the order: $e');
      Get.to(() => FadeInAndSlide());
    }
  }



}
//
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../model/productmodel.dart';
// import '../view/homescreen/leaf/leafpro.dart';
// import '../view/homescreen/payment/success.dart';
// import 'loginctrlr.dart';
//
// class CartController extends GetxController {
//   final String baseUrl =
//       'https://btobapi-production.up.railway.app/api/'; // Replace with your API base URL
//   var cartItems = <Product>[].obs;
//   var totalPrice = 0.0.obs;
//   var address = ''.obs;
//   var isLoading = false.obs;
//
//   // Options for additional items
//   var addSample = false.obs;
//   var addDisplayStand = false.obs;
//   var addBrochure = false.obs;
//   var addLeafcoin = false.obs;
//
//   // Add item to cart
//   void addToCart(Product product) {
//     var existingProduct =
//     cartItems.firstWhereOrNull((item) => item.id == product.id);
//
//     if (existingProduct == null) {
//       // If not present, add new product with initial quantity of 1
//       if (product.category == 1) {
//         // Assuming category 1 is the "offer" category
//         product.minimumOrderQuantity = 1; // Set to 1 for offer products
//       } else {
//         product.minimumOrderQuantity = (product.minimumOrderQuantity ?? 0) + 1;
//       }
//       cartItems.add(product);
//     } else {
//       // If already exists, increment quantity
//       if (product.category != 1) { // Only increment quantity for non-offer products
//         existingProduct.minimumOrderQuantity =
//             (existingProduct.minimumOrderQuantity ?? 0) + 1;
//       }
//     }
//     calculateTotalPrice();
//     Get.snackbar(
//       'Added to Cart',
//       '${product.productName ?? "Item"} has been added to your cart.',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
//
//   // Remove a single quantity of an item or remove it entirely
//   void removeFromCart(Product product) {
//     var existingProduct =
//     cartItems.firstWhereOrNull((item) => item.id == product.id);
//
//     if (existingProduct != null) {
//       cartItems.remove(existingProduct);
//       calculateTotalPrice();
//       Get.snackbar(
//         'Removed from Cart',
//         '${product.productName ?? "Item"} has been removed from your cart.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   // Increase quantity for a specific product
//   void increaseQuantity(Product product) {
//     var existingProduct =
//     cartItems.firstWhereOrNull((item) => item.id == product.id);
//
//     if (existingProduct != null && product.category != 1) {
//       // Don't increase quantity for offer category products
//       existingProduct.minimumOrderQuantity =
//           (existingProduct.minimumOrderQuantity ?? 0) + 1;
//       calculateTotalPrice();
//     }
//   }
//
//   // Decrease quantity for a specific product
//   void decreaseQuantity(Product product) {
//     var existingProduct =
//     cartItems.firstWhereOrNull((item) => item.id == product.id);
//
//     if (existingProduct != null && product.category != 1) {
//       // Don't decrease quantity for offer category products
//       if ((existingProduct.minimumOrderQuantity ?? 0) > 1) {
//         existingProduct.minimumOrderQuantity =
//             (existingProduct.minimumOrderQuantity ?? 0) - 1;
//         calculateTotalPrice();
//       } else {
//         // Remove item entirely if quantity becomes 0
//         removeFromCart(product);
//       }
//     }
//   }
//
//   void clearCart() {
//     cartItems.clear();
//     calculateTotalPrice();
//     Get.snackbar(
//       'Cart Cleared',
//       'All items have been removed from your cart.',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
//
//   // Calculate total price of items in the cart
//   void calculateTotalPrice() {
//     totalPrice.value = cartItems.fold(
//       0.0,
//           (sum, item) {
//         // Check if the product belongs to the "offer category"
//         final isOfferCategory = item.category == 1; // Adjust as needed (category 1 for offer products)
//         final itemPrice = item.price ?? 0.0;
//
//         // For offer category, add only the price; otherwise, multiply by quantity
//         if (isOfferCategory) {
//           return sum + itemPrice;
//         } else {
//           final itemQuantity = item.minimumOrderQuantity ?? 1;
//           return sum + (itemPrice * itemQuantity);
//         }
//       },
//     );
//   }
//
//   // Options for additional items
//   double get discountPrice => totalPrice.value > 100 ? 10.0 : 0.0;
//
//   LeafCoinController leafCoinController = LeafCoinController();
//
//   double get finalPrice {
//     return totalPrice.value +
//         (addSample.value ? 0.0 : 0.0) +
//         (addDisplayStand.value ? 0.0 : 0.0) +
//         (addBrochure.value ? 0.0 : 0.0) +
//         (addLeafcoin.value ? 0.0 : leafCoinController.availableCoins.value) -
//         discountPrice;
//   }
//
//   // Toggle methods for additional items
//   void toggleAddSample(bool value) => addSample.value = value;
//   void toggleAddDisplayStand(bool value) => addDisplayStand.value = value;
//   void toggleAddBrochure(bool value) => addBrochure.value = value;
//   void toggleAddLeafcoin(bool value) => addLeafcoin.value = value;
//
//   // Checkout method to submit the order and clear the cart
//   Future<void> checkout() async {
//     if (cartItems.isEmpty) {
//       Get.snackbar("Error", "Your cart is empty!");
//       return;
//     }
//
//     isLoading.value = true;
//
//     final orderData = {
//       "business_user": null,
//       "total_price": totalPrice.value,
//       "billing_address": address.value,
//       "status": "Processing",
//       "order_type": "Online",
//       "order_products": cartItems
//           .map((item) => {
//         "product": item.id,
//         "product_name": item.productName,
//         "quantity": item.minimumOrderQuantity,
//         "price": item.price.toString(),
//       })
//           .toList(),
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/orders'),
//         headers: {"Content-Type": "application/json"},
//         body: json.encode(orderData),
//       );
//
//       if (response.statusCode == 200) {
//         Get.snackbar("Success", "Your order has been placed successfully!");
//         clearCart();
//       } else {
//         Get.snackbar(
//             "Error", "Failed to place the order. ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // Method to update the user's address in the backend
//   Future<void> updateAddress(String newAddress) async {
//     isLoading.value = true;
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/orders/'), // Replace '1' with user ID
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'address': newAddress}),
//       );
//
//       if (response.statusCode == 200) {
//         address.value = newAddress;
//         Get.snackbar('Success', 'Address updated successfully.');
//       } else {
//         Get.snackbar(
//             'Error', 'Failed to update address. ${response.statusCode}');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'An error occurred: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> placeOrder(Product product) async {
//     if (cartItems.isEmpty) {
//       Get.snackbar('Error', 'Cart is empty');
//       return;
//     }
//
//     final loginController = Get.find<LoginController>();
//     final userModel = loginController.userModel;
//
//     if (userModel == null) {
//       Get.snackbar('Error', 'User not logged in. Please log in again.');
//       return;
//     }
//
//     print("UserModel ID: ${userModel.id}");
//
//     final orderData = {
//       "business_user": userModel.id, // Use ID from LoginController
//       "order_date": DateTime.now().toIso8601String(),
//       "total_price": totalPrice.toStringAsFixed(2),
//       "billing_address": address.value,
//       "status": "Processing",
//       "order_type": "Online",
//       "order_products": cartItems.map((item) {
//         return {
//           "product": item.id,
//           "product_name": item.productName ?? "Unknown Product",
//           "quantity": item.minimumOrderQuantity ?? 1,
//           "price": item.price?.toString() ?? "0.0",
//         };
//       }).toList(),
//     };
//
//     print('Order Data: ${json.encode(orderData)}');
//
//     try {
//       final response = await http.post(
//         Uri.parse('https://sadapi-production.up.railway.app/api/orders/'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(orderData),
//       );
//
//       print('Response Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//
//       if (response.statusCode == 201) {
//         Get.snackbar('Success', 'Order placed successfully');
//         Get.to(() => FadeInAndSlide());
//       } else {
//         final responseBody = jsonDecode(response.body);
//         final errorMessage = responseBody['detail'] ?? 'Unexpected error';
//         Get.snackbar('Error', errorMessage);
//         Get.to(() => FadeInAndSlide());
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//       Get.snackbar('Error', 'An error occurred while placing the order: $e');
//       Get.to(() => FadeInAndSlide());
//     }
//   }
// }
