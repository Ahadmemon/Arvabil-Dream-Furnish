import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/categoryModel.dart';
import '../models/productModel.dart';
import '../presentations/widgets/snackbar.dart';
import '../provider/user_provider.dart';

class UserServices {
  Future<List<CategoryModel>> fetchAllCategories(BuildContext context) async {
    List<CategoryModel> categories = [];
    try {
      final response = await http.get(
        Uri.parse(
          "$BASE_URL/category/fetchAllCategories?cache_buster=${DateTime.now().millisecondsSinceEpoch}",
        ),
        headers: {"Content-Type": "application/json"},
      );

      // print("URL: ${response.request?.url}");
      // print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Ensure response is successful before proceeding with parsing
      if (response.statusCode == 200) {
        try {
          // Decode the response body
          final Map<String, dynamic> decodedData = jsonDecode(response.body);

          // Ensure the 'data' key exists and contains a list of products
          if (decodedData['data'] != null) {
            // Extract the list of products from the 'data' key
            categories =
                (decodedData['data'] as List)
                    .map(
                      (item) =>
                          CategoryModel.fromJson(item as Map<String, dynamic>),
                    )
                    .toList();
            // print(
            //     "Decoded Products: $categories"); // Debugging line to check parsed products
          } else {
            ShowSnack(context, "No categories found");
            categories = [];
          }
        } catch (e) {
          ShowSnack(context, "Data parsing error: ${e.toString()}");
          categories = [];
        }
      } else {
        ShowSnack(context, "Failed to fetch data: ${response.statusCode}");
        categories = [];
      }
    } on http.ClientException catch (e) {
      ShowSnack(context, "Connection failed: ${e.message}");
      categories = [];
    } catch (e) {
      ShowSnack(context, "Unexpected error: ${e.toString()}");
      categories = [];
    }
    return categories;
  }

  Future<List<ProductModel>> fetchProductsByCategory(
    BuildContext context,
    String category,
  ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> products = [];
    try {
      final response = await http.get(
        Uri.parse(
          "$BASE_URL/product/fetchProductsByCategory?category=$category",
        ),
        headers: {
          "Content-Type": "application/json",
          // 'x-auth-token': userProvider.user.token!,
        },
      );

      // print("URL: ${response.request?.url}");
      // print("Status Code: ${response.statusCode}");
      // print("Response Body: ${response.body}");

      // Ensure response is successful before proceeding with parsing
      if (response.statusCode == 200) {
        try {
          // Decode the response body
          final Map<String, dynamic> decodedData = jsonDecode(response.body);

          // Ensure the 'data' key exists and contains a list of products
          if (decodedData['data'] != null) {
            // Extract the list of products from the 'data' key
            products =
                (decodedData['data'] as List)
                    .map(
                      (item) =>
                          ProductModel.fromJson(item as Map<String, dynamic>),
                    )
                    .toList();
            // print(
            //     "Decoded Products: $category"); // Debugging line to check parsed products
          } else {
            ShowSnack(context, "No categories found");
            products = [];
          }
        } catch (e) {
          ShowSnack(context, "Data parsing error: ${e.toString()}");
          products = [];
        }
      } else {
        ShowSnack(context, "Failed to fetch data: ${response.statusCode}");
        products = [];
      }
    } on http.ClientException catch (e) {
      ShowSnack(context, "Connection failed: ${e.message}");
      products = [];
    } catch (e) {
      ShowSnack(context, "Unexpected error: ${e.toString()}");
      products = [];
    }
    return products;
  }

  Future<void> submitFeedback({
    required final BuildContext context,
    // int? rating,
    String? comment,
    String? productId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(myTokenKey);
    if (token == null) {
      ShowSnack(context, "User not authenticated!");
      return;
    }
    try {
      http.Response response = await http.post(
        Uri.parse('$BASE_URL/product/${productId}/addFeedback'),
        headers: {'x-auth-token': token, 'Content-Type': 'application/json'},
        body: jsonEncode({
          // 'rating': rating,
          'comment': comment,
        }),
      );

      if (response.statusCode == 200) {
        ShowSnack(context, "Feedback added!");
      } else {
        ShowSnack(context, "Error Submitting feedback!");
      }
    } catch (e) {
      // log("Error:${e}");
    }
  }

  Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    List<ProductModel> products = [];
    try {
      final response = await http.get(
        Uri.parse(
          "$BASE_URL/product/fetchAllProducts?cache_buster=${DateTime.now().millisecondsSinceEpoch}",
        ),
        headers: {"Content-Type": "application/json"},
      );

      // print("URL: ${response.request?.url}");
      // print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Ensure response is successful before proceeding with parsing
      if (response.statusCode == 200) {
        try {
          // Decode the response body
          final Map<String, dynamic> decodedData = jsonDecode(response.body);

          // Ensure the 'data' key exists and contains a list of products
          if (decodedData['data'] != null) {
            // Extract the list of products from the 'data' key
            products =
                (decodedData['data'] as List)
                    .map(
                      (item) =>
                          ProductModel.fromJson(item as Map<String, dynamic>),
                    )
                    .toList();
            // print(
            //     "Decoded Products: $products"); // Debugging line to check parsed products
          } else {
            ShowSnack(context, "No products found");
            products = [];
          }
        } catch (e) {
          // log("Error:${e}");
          ShowSnack(context, "Data parsing error: ${e.toString()}");
          products = [];
        }
      } else {
        ShowSnack(context, "Failed to fetch data: ${response.statusCode}");
        products = [];
      }
    } on http.ClientException catch (e) {
      // log("Error:${e}");

      ShowSnack(context, "Connection failed: ${e.message}");
      products = [];
    } catch (e) {
      // log("Error:${e}");

      ShowSnack(context, "Unexpected error: ${e.toString()}");
      products = [];
    }
    return products;
  }
}
