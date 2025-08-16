import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/cartModel.dart';
import '../presentations/widgets/snackbar.dart';
import '../provider/user_provider.dart';
// Ensure BASE_URL is defined

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  bool _isLoading = false;
  String? _error;

  List<CartItem> get items => _items;

  bool get isLoading => _isLoading;

  String? get error => _error;

  double get totalPrice {
    return _items.fold(
      0,
      (sum, item) => sum + (item.product!.price! * item.quantity!),
    );
  }

  // Fetch Cart Items from Database
  Future<void> fetchCart(BuildContext context) async {
    if (_isLoading) return;
    _isLoading = true;
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.user.token;

      if (token == null) {
        throw Exception('Authentication required');
      }

      final response = await http.get(
        Uri.parse("$BASE_URL/cart/fetchCartItems"),
        headers: {"Content-Type": "application/json", "x-auth-token": token},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final rawCart = responseData['data']['items'] as List? ?? [];

        _items =
            rawCart
                .map((item) {
                  try {
                    return CartItem.fromJson(item as Map<String, dynamic>);
                  } catch (e) {
                    // log('Invalid cart item: $e');
                    return null;
                  }
                })
                .whereType<CartItem>()
                .toList();

        // log('Successfully fetched ${_items.length} cart items');
      } else {
        _error = 'Failed to load cart: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error fetching cart: ${e.toString()}';
      // log(_error!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add Item to Cart and Save in Database
  Future<void> addToCart(BuildContext context, CartItem item) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.user.token;
      // log("Token From cart provider: ${token}");
      final url = Uri.parse("$BASE_URL/cart/addToCart");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "x-auth-token": token!,
        },
        body: json.encode({"product": item.product, "quantity": item.quantity}),
      );

      if (response.statusCode == 200) {
        await fetchCart(context); // Reload cart from DB
        // debugPrint("Product added to cart");
        ShowSnack(context, "Product added to cart");
      } else {
        throw Exception("Failed to add item to cart");
      }
    } catch (e) {
      // debugPrint("Error adding to cart: $e");
    }
  }

  // Remove Item from Cart and Update Database
  Future<void> removeFromCart(BuildContext context, String productId) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.user.token;
      // log("Token::: ${token}");
      final url = Uri.parse("$BASE_URL/cart/removeFromCart");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json", "x-auth-token": token!},
        body: jsonEncode({"productId": productId}),
      );

      if (response.statusCode == 200) {
        await fetchCart(context); // Reload cart from DB
        ShowSnack(context, "Product removed from cart");
      } else {
        throw Exception("Failed to remove item from cart");
      }
    } catch (e) {
      // debugPrint("Error removing from cart: $e");
    }
  }

  // Clear Entire Cart and Update Database
  Future<void> clearCart(BuildContext context) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.user.token;
      final url = Uri.parse("$BASE_URL/cart/clearCart");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json", "x-auth-token": token!},
      );

      if (response.statusCode == 200) {
        _items.clear();
        notifyListeners();
        ShowSnack(context, "Cart cleared!");
      } else {
        throw Exception("Failed to clear cart");
      }
    } catch (e) {
      // debugPrint("Error clearing cart: $e");
    }
  }

  Future<void> decrementQuantity(BuildContext context, String productId) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.user.token;
      // log("Token::: ${token}");
      final url = Uri.parse("$BASE_URL/cart/decrementQuantity");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json", "x-auth-token": token!},
        body: jsonEncode({"productId": productId}),
      );

      if (response.statusCode == 200) {
        await fetchCart(context); // Reload cart from DB
        // ShowSnack(context, "Product removed from cart", Colors.grey);
      } else {
        // throw Exception("Failed to remove item from cart");
      }
    } catch (e) {
      // debugPrint("Error removing from cart: $e");
    }
  }

  Future<void> incrementQuantity(BuildContext context, String productId) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.user.token;
      // log("Token::: ${token}");
      final url = Uri.parse("$BASE_URL/cart/incrementQuantity");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json", "x-auth-token": token!},
        body: jsonEncode({"productId": productId}),
      );

      if (response.statusCode == 200) {
        await fetchCart(context); // Reload cart from DB
        // ShowSnack(context, "Product removed from cart", Colors.grey);
      } else {
        // throw Exception("Failed to remove item from cart");
      }
    } catch (e) {
      // debugPrint("Error removing from cart: $e");
    }
  }
}
