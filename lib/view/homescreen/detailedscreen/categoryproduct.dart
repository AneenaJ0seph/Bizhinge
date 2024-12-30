//
// import 'package:biztrail/view/homescreen/detailedscreen/productdetail.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../common/app_colors.dart';
// import '../../../../common/textconstants.dart';
// import '../../../../controller/app_controller.dart';
// import '../../../../model/categorymodel.dart';
//
// class CategoryProductPage extends StatelessWidget {
//   final Category category;
//   final AppController controller = Get.find();
//
//   CategoryProductPage({required this.category});
//
//   @override
//   Widget build(BuildContext context) {
//     final categoryProducts = controller.products
//         .where((product) => product.category == category.id)
//         .toList();
//
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//         surfaceTintColor: Colors.transparent,
//         backgroundColor: white,
//         title: Text('${category.name} Products',
//           style: NeededTextstyles.commonhead,),
//       ),
//       body: categoryProducts.isEmpty
//           ? Center(child: Text('No products available for this category.'))
//           : ListView.builder(
//         itemCount: categoryProducts.length,
//         itemBuilder: (context, index) {
//           final product = categoryProducts[index];
//           return Padding(
//             padding: const  EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//             child: Card(
//               color: white,
//               elevation: 5,
//               child: ListTile(
//                 onTap: () {
//                   // Use GetX for navigation
//                   Get.to(() => ProductDetail(product: product, companyName: 'cfcv',));
//                 },
//                 leading: Image.network(
//                   product.image!,
//                   width: 70,
//                   height: 80,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Icon(Icons.broken_image, size: 50, color: Colors.grey);
//                   },
//                 ),
//                 title: Text(
//                     product.productName!,
//                     style: NeededTextstyles.style21
//                 ),
//                 subtitle: Text(
//                   product.productDetails!,
//                   style: NeededTextstyles.style24,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 trailing: Text(
//                   '\$${product.price?.toStringAsFixed(2)}',
//                   style: NeededTextstyles.style21,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:biztrail/view/homescreen/detailedscreen/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/textconstants.dart';
import '../../../../controller/app_controller.dart';
import '../../../../model/categorymodel.dart';

class CategoryProductPage extends StatelessWidget {
  final Category category;
  final AppController controller = Get.find();

  CategoryProductPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final categoryProducts = controller.products
        .where((product) => product.category == category.id)
        .toList();

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: white,
        title: Text(
          '${category.name} Products',
          style: NeededTextstyles.commonhead,
        ),
      ),
      body: categoryProducts.isEmpty
          ? Center(child: Text('No products available for this category.'))
          : ListView.builder(
        itemCount: categoryProducts.length,
        itemBuilder: (context, index) {
          final product = categoryProducts[index];
          final isOutOfStock =
              product.stockQuantity == null || product.stockQuantity! <= 16;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Card(
              color: isOutOfStock ? Colors.grey[300] : white,
              elevation: isOutOfStock ? 5 : 5,
              child: ListTile(
                onTap: isOutOfStock
                    ? null // Disable tap for out-of-stock products
                    : () {
                  // Navigate to details for in-stock products
                  Get.to(() => ProductDetail(
                    product: product,
                    companyName: 'cfcv',
                  ));
                },
                leading: Image.network(
                  product.image!,
                  width: 70,
                  height: 80,
                  fit: BoxFit.cover,
                  color: isOutOfStock
                      ? Colors.black.withOpacity(0.5)
                      : null, // Dim the image for out-of-stock products
                  colorBlendMode: isOutOfStock ? BlendMode.darken : null,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image,
                        size: 50, color: Colors.grey);
                  },
                ),
                title: Text(
                  product.productName!,
                  style: NeededTextstyles.style21.copyWith(
                    color: isOutOfStock ? Colors.grey : null, // Dim text
                  ),
                ),
                trailing:  Text(
                  '\$${product.price?.toStringAsFixed(2)}',
                  style: NeededTextstyles.style11.copyWith(
                    color: isOutOfStock ? Colors.grey : null, // Dim text
                  ),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 8),
                    isOutOfStock
                        ? Text(
                      'Out of Stock',
                      style: TextStyle(color: Colors.red),
                    )
                        : ElevatedButton(
                      onPressed: () {
                        Get.to(() => ProductDetail(
                          product: product,
                          companyName: 'cfcv',
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lighttheme79,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Buy Now',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
