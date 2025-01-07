import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/ordermodel.dart';
import '../model/productmodel.dart';
import '../view/homescreen/leaf/leafpro.dart';
import '../view/homescreen/payment/success.dart';
import 'loginctrlr.dart';

class CartController extends GetxController {
  final String baseUrl =
      'https://sadapi-production.up.railway.app/api/';
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
  // Future<void> checkout() async {
  //   if (cartItems.isEmpty) {
  //     Get.snackbar("Error", "Your cart is empty!");
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //
  //   final orderData = {
  //     "business_user": null,
  //     "total_price": totalPrice.value,
  //     "billing_address": address.value,
  //     "status": "Processing",
  //     "order_type": "Online",
  //     "order_products": cartItems
  //         .map((item) => {
  //       "product": item.id,
  //       "product_name": item.productName,
  //       "quantity": item.minimumOrderQuantity,
  //       "price": item.price.toString(),
  //     })
  //         .toList(),
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/orders'),
  //       headers: {"Content-Type": "application/json"},
  //       body: json.encode(orderData),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       Get.snackbar("Success", "Your order has been placed successfully!");
  //       clearCart();
  //     } else {
  //       Get.snackbar(
  //           "Error", "Failed to place the order. ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "An error occurred: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
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


  //
  // Future<void> placeOrder(Product product) async {
  //   if (cartItems.isEmpty) {
  //     Get.snackbar('Error', 'Cart is empty');
  //     return;
  //   }
  //
  //   final loginController = Get.find<LoginController>();
  //   final userModel = loginController.userModel;
  //
  //
  //   if (userModel == null) {
  //     Get.snackbar('Error', 'User not logged in. Please log in again.');
  //     return;
  //   }
  //
  //   print("UserModel ID: ${userModel.id}");
  //
  //   final orderData = {
  //     "business_user": userModel.id, // Use ID from LoginController
  //     "order_date": DateTime.now().toIso8601String(),
  //     "total_price": totalPrice.toStringAsFixed(2),
  //     "billing_address": address.value,
  //     "status": "Processing",
  //     "order_type": "Online",
  //     "order_products": cartItems.map((item) {
  //       return {
  //         "product": item.id,
  //         "product_name": item.productName ?? "Unknown Product",
  //         "quantity": item.minimumOrderQuantity ?? 1,
  //         "price": item.price?.toString() ?? "0.0",
  //       };
  //     }).toList(),
  //   };
  //
  //   print('Order Data: ${json.encode(orderData)}');
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://sadapi-production.up.railway.app/api/orders/'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(orderData),
  //     );
  //
  //     print('Response Status Code: ${response.statusCode}');
  //     print('Response Body: ${response.body}');
  //
  //     if (response.statusCode == 201) {
  //
  //       Get.snackbar('Success', 'Order placed successfully');
  //       Get.to(() => FadeInAndSlide());
  //     } else {
  //       final responseBody = jsonDecode(response.body);
  //       final errorMessage = responseBody['detail'] ?? 'Unexpected error';
  //       Get.snackbar('Error', errorMessage);
  //       Get.to(() => FadeInAndSlide());
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e');
  //     Get.snackbar('Error', 'An error occurred while placing the order: $e');
  //     Get.to(() => FadeInAndSlide());
  //   }
  // }
//.....
  //
  // Future<void> placeOrder(Product product) async {
  //   if (cartItems.isEmpty) {
  //     Get.snackbar('Error', 'Cart is empty');
  //     return;
  //   }
  //
  //   final loginController = Get.find<LoginController>();
  //   final userModel = loginController.userModel;
  //
  //   if (userModel == null) {
  //     Get.snackbar('Error', 'User not logged in. Please log in again.');
  //     return;
  //   }
  //
  //   // Create a list of OrderProduct objects
  //   List<OrderProduct> orderProducts = cartItems.map((item) {
  //     return OrderProduct(
  //       quantity: item.minimumOrderQuantity ?? 1,
  //       price: double.parse(item.price?.toStringAsFixed(2) ?? "0.0"),
  //       product: Product(
  //         id: item.id,
  //         categoryName: item.categoryName ?? '',
  //         productName: item.productName ?? 'Unknown Product',
  //         productDetails: item.productDetails ?? '',
  //         image: item.image ?? '',
  //         price: item.price != null ? double.tryParse(item.price.toString()) ?? 0.0 : 0.0,
  //         wholesalePrice: item.wholesalePrice != null ? double.tryParse(item.wholesalePrice.toString()) ?? 0.0 : 0.0,
  //
  //         minimumOrderQuantity: item.minimumOrderQuantity ?? 1,
  //         stockQuantity: item.stockQuantity ?? 0,
  //         isInStock: item.isInStock ?? false,
  //         category: item.category ?? 0,
  //       ),
  //     );
  //   }).toList();
  //
  //   // Create the Order model with the order details
  //   Order order = Order(
  //     id: 0, // The server will assign an ID when creating the order
  //     businessUserId: userModel.id ?? 0, // Ensure the user ID is not null
  //     orderDate: DateTime.now().toIso8601String(),
  //     totalPrice: double.parse(totalPrice.value.toStringAsFixed(2)),
  //     billingAddress: address.value,
  //     status: "Processing",
  //     orderType: "Online",
  //     cashbackApplied: 0.0, // Assuming no cashback for now
  //     orderProducts: orderProducts,
  //   );
  //
  //   // Convert the Order object to JSON for sending in the API request
  //   Map<String, dynamic> orderData = order.toJson();
  //
  //   print('Order Data: ${json.encode(orderData)}'); // Log the request data
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://sadapi-production.up.railway.app/api/orders'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(orderData),
  //     );
  //
  //     print('Response Status Code: ${response.statusCode}');
  //     print('Response Body: ${response.body}');
  //
  //     if (response.statusCode == 201) {
  //       // Order placed successfully
  //       Get.snackbar('Success', 'Order placed successfully');
  //       clearCart(); // Clear the cart after successful order
  //       Get.to(() => FadeInAndSlide());
  //     } else if (response.statusCode >= 400 && response.statusCode < 500) {
  //       // Client-side error
  //       final responseBody = jsonDecode(response.body);
  //       final errorMessage = responseBody['detail'] ?? 'Validation error occurred';
  //       Get.snackbar('Error', errorMessage);
  //       Get.to(() => FadeInAndSlide());
  //     } else if (response.statusCode >= 500) {
  //       // Server-side error
  //       Get.snackbar('Error', 'Server error occurred. Please try again later.');
  //       Get.to(() => FadeInAndSlide());
  //     } else {
  //       // Unexpected status code
  //       Get.snackbar('Error', 'Unexpected error occurred. Status: ${response.statusCode}');
  //       Get.to(() => FadeInAndSlide());
  //     }
  //   } catch (e) {
  //     // Handle network errors or any other exception
  //     print('Error occurred: $e');
  //     Get.snackbar('Error', 'An error occurred while placing the order: $e');
  //     Get.to(() => FadeInAndSlide());
  //   }
  // }

  Future<bool> placeOrders(Product product) async {
    if (cartItems.isNotEmpty) {
      final businessUserPhone = 'USER_PHONE_NUMBER'; // Replace with actual phone number
      final billingAddress = 'Your billing address here';
      final orderType = 'Online';

      final List<Map<String, dynamic>> orderProducts = cartItems.map((product) {
        // Handle null safety for price and quantity
        final int quantity = product.minimumOrderQuantity ??
            1; // Default to 1 if quantity is null
        final double price = product.price?.toDouble() ??
            0.0; // Convert to double and default to 0.0 if null

        return {
          "product": {
            "id": product.id,
            "category_name": product.categoryName,
            "product_name": product.productName,
            "product_details": product.productDetails,
            "image": product.image, // Pass image if required
            "price": price.toString(), // Ensure it's sent as a string
            "wholesale_price": (product.wholesalePrice ?? 0.0).toString(),
            "minimum_order_quantity": product.minimumOrderQuantity ?? 0,
            "stock_quantity": product.stockQuantity ?? 0,
            "is_in_stock": product.isInStock ?? false,
            "category": product.category,
          },
          "quantity": quantity, // Ensure quantity is non-null
          "price": (price * quantity).toString(), // Calculate total price
        };
      }).toList();

      final orderData = {
        "business_user_phone": businessUserPhone,
        "order_products": orderProducts,
        "billing_address": billingAddress,
        "order_type": orderType,
      };

      try {
        final response = await http.post(
          Uri.parse(
              'https://sadapi-production.up.railway.app/api/orders/create_order/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(orderData),
        );

        if (response.statusCode == 201) {
          Get.snackbar("Success", "Order placed successfully.");
          return true; // Order successfully placed
        } else {
          Get.snackbar("Error", "Failed to place order: ${response.body}");
          return false; // Order placement failed
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to place order: $e");
        return false; // Order placement failed due to an exception
      }
    } else {
      Get.snackbar("Error", "Your cart is empty.");
      return false; // Order placement failed due to empty cart
    }
  }

  Future<bool> placeOrder(Product product) async {
    if (cartItems.isEmpty) {

      Get.snackbar('Error', 'Cart is empty');
      return false;
    }

    final loginController = Get.find<LoginController>();
    final userModel = loginController.userModel;

    if (userModel == null) {
      Get.snackbar('Error', 'User not logged in. Please log in again.');
      return false;
    }

    print("UserModel ID: ${userModel.id}");

    final orderData = {
      "business_user": userModel.id,
      "order_date": DateTime.now().toIso8601String(),
      "total_price": totalPrice.toStringAsFixed(2),
      "billing_address": 'default address',
      "status": "Processing",
      "order_type": "Online",
      "order_products": cartItems.map((item) {
        return {
          "product": {
            "id": product.id,
            "category_name": product.categoryName,
            "product_name": product.productName,
            "product_details": product.productDetails,
            "image": product.image,
            "price": product.price.toString(),
            "wholesale_price": product.wholesalePrice?.toString() ?? "0.0",
            "minimum_order_quantity": product.minimumOrderQuantity ?? 0,
            "stock_quantity": product.stockQuantity ?? 0,
            "is_in_stock": product.isInStock ?? false,
            "category": product.category,
          },
          "quantity": item.minimumOrderQuantity ?? 1,
          "price": (item.price ?? 0).toString(),
        };
      }).toList(),
    };

    print('Order Data: ${json.encode(orderData)}');

    try {
      final response = await http.post(
        Uri.parse('https://sadapi-production.up.railway.app/api/orders/create_order/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orderData),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }

}











