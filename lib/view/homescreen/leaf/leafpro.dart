//
// import 'package:flutter/material.dart';
//
// class LeafCoinProvider with ChangeNotifier {
//   int availableCoins = 0; // Initial balance
//   List<Map<String, String>> transactions = [
//     {
//       "title": "Expire Coins",
//       "subtitle": "Debited on 03 Jul 2024",
//       "amount": "-10",
//     },
//     {
//       "title": "Expire Coins",
//       "subtitle": "Debited on 02 Jun 2024",
//       "amount": "-04",
//     },
//   ];
//
//   // Add coins and update transaction history
//   void addCoin(String title, String subtitle, String amount) {
//     availableCoins++;
//     transactions.add({
//       "title": title,
//       "subtitle": subtitle,
//       "amount": amount,
//     });
//     notifyListeners();
//   }
// }

import 'package:get/get.dart';

class LeafCoinController extends GetxController {
  var availableCoins = 0.obs; // Observable variable for available coins
  var transactions = <Map<String, String>>[
    {
      "title": "Expire Coins",
      "subtitle": "Debited on 03 Jul 2024",
      "amount": "-10",
    },
    {
      "title": "Expire Coins",
      "subtitle": "Debited on 02 Jun 2024",
      "amount": "-04",
    },
  ].obs; // Observable list of transactions

  // Add coins and update transaction history
  void addCoin(String title, String subtitle, String amount) {
    availableCoins.value++;
    transactions.add({
      "title": title,
      "subtitle": subtitle,
      "amount": amount,
    });
  }
}
