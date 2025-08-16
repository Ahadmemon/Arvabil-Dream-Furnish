// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../main.dart';
// import '../models/productModel.dart';
// import '../presentations/widgets/snackbar.dart';
// // Make sure to import your showSnack function (or create it if you don't have one)
//
// class ProductProvider with ChangeNotifier {
//   List<ProductModel> _products = [];
//   bool _loading = false;
//
//   List<ProductModel> get products => _products;
//
//   bool get loading => _loading;
//
//   // Fetch all products
//   Future<void> fetchAllProducts(BuildContext context) async {
//     if (_loading) return;
//     _loading = true;
//     // Notify listeners that the loading state is changed
//
//     try {
//       final response = await http.get(
//         Uri.parse(
//             "$BASE_URL/product/fetchAllProducts?cache_buster=${DateTime.now().millisecondsSinceEpoch}"),
//         headers: {"Content-Type": "application/json"},
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> decodedData = jsonDecode(response.body);
//
//         if (decodedData['data'] != null) {
//           _products = (decodedData['data'] as List)
//               .map(
//                   (item) => ProductModel.fromJson(item as Map<String, dynamic>))
//               .toList();
//         } else {
//           ShowSnack(context, "No products found", Colors.red);
//           _products = [];
//         }
//       } else {
//         ShowSnack(context, "Failed to fetch data: ${response.statusCode}",
//             Colors.red);
//         _products = [];
//       }
//     } catch (e) {
//       log("Error:${e}");
//       ShowSnack(context, "Unexpected error: ${e.toString()}", Colors.red);
//       _products = [];
//     } finally {
//       _loading = false;
//       notifyListeners(); // Notify listeners that the loading state has ended
//     }
//   }
//
//   // Fetch products by category
//   Future<void> fetchProductsByCategory(
//       BuildContext context, String category) async {
//     _loading = true;
//     notifyListeners();
//
//     try {
//       final response = await http.get(
//         Uri.parse(
//             "$BASE_URL/product/fetchProductsByCategory?category=$category"),
//         headers: {"Content-Type": "application/json"},
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> decodedData = jsonDecode(response.body);
//
//         if (decodedData['data'] != null) {
//           _products = (decodedData['data'] as List)
//               .map(
//                   (item) => ProductModel.fromJson(item as Map<String, dynamic>))
//               .toList();
//         } else {
//           ShowSnack(context, "No products found in this category", Colors.red);
//           _products = [];
//         }
//       } else {
//         ShowSnack(context, "Failed to fetch data: ${response.statusCode}",
//             Colors.red);
//         _products = [];
//       }
//     } catch (e) {
//       log("Error:${e}");
//       ShowSnack(context, "Unexpected error: ${e.toString()}", Colors.red);
//       _products = [];
//     } finally {
//       _loading = false;
//       notifyListeners();
//     }
//   }
//
//   // Submit feedback for a product
//   Future<void> submitFeedback({
//     required BuildContext context,
//     String? comment,
//     String? productId,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString(myTokenKey);
//     if (token == null) {
//       ShowSnack(context, "User not authenticated!", Colors.red);
//       return;
//     }
//
//     try {
//       final response = await http.post(
//         Uri.parse('$BASE_URL/product/${productId}/addFeedback'),
//         headers: {
//           'x-auth-token': token,
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'comment': comment,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         ShowSnack(context, "Feedback added!", Colors.blueGrey);
//       } else {
//         ShowSnack(context, "Error Submitting feedback!", Colors.red);
//       }
//     } catch (e) {
//       log("Error:${e}");
//     }
//   }
//
//   // Set new products list (optional)
//   void setProducts(List<ProductModel> products) {
//     _products = products;
//     notifyListeners();
//   }
// }
