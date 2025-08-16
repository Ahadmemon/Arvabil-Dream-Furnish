import 'dart:convert';

import 'package:adf/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/orderModel.dart';
import '../presentations/screens/Orders/order_history_screen.dart';
import '../presentations/widgets/bottom_navigation_bar.dart';
import '../presentations/widgets/snackbar.dart';
import '../services/razorpay_services.dart';
import 'cart_provider.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<OrderModel> get orders => _orders;

  bool get isLoading => _isLoading;

  String? get error => _error;

  void setOrders(List<OrderModel> newOrders) {
    _orders = newOrders;
    notifyListeners();
  }

  Future<void> fetchOrdersForUser(BuildContext context) async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.user.token;

      if (token == null) {
        throw Exception('Authentication required');
      }

      final response = await http.get(
        Uri.parse("$BASE_URL/order/fetchOrderForUser"),
        headers: {"Content-Type": "application/json", "x-auth-token": token},
      );
      // debugPrint("Fetched Orders:    ${response.body}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          final List<dynamic> orderList = responseData['data'] as List<dynamic>;
          _orders = orderList.map((json) => OrderModel.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        _error = 'Failed to load orders: ${response.statusCode}';
        // log(_error!);
      }
    } catch (e) {
      _error = 'Error fetching orders: ${e.toString()}';
      // log(_error!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createOrder(BuildContext context, OrderModel order) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.user.token;
      // log("Token From order provider: $token");

      final url = Uri.parse("$BASE_URL/order/createOrder");

      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "x-auth-token": token!,
        },
        body: jsonEncode(order),
      );

      // log("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        order = OrderModel.fromJson(data['data']);

        ShowSnack(context, "Order created");
        bool? clearCart = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Clear cart after payment?"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      true,
                    ); // Close the dialog and return 'true'
                  },
                  child: Text("Yes"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      false,
                    ); // Close the dialog and return 'false'
                  },
                  child: Text("No"),
                ),
              ],
            );
          },
        );

        // If the user wants to clear the cart
        if (clearCart == true) {
          final cartProvider = Provider.of<CartProvider>(
            context,
            listen: false,
          );
          await cartProvider.clearCart(context);
        }

        // log("Updated OrderModel: ${jsonEncode(order)}");
        // log("Razorpay Order ID: ${order.razorPayOrderId}");
        // log("User ID: ${order.user?.id}");
        RazorpayServices.checkOutOrder(
          order,
          onSuccess: (response) async {
            order.status = "Order Placed";
            await updateOrder(
              order,
              context: context,
              paymentId: response.paymentId,
              signature: response.signature,
            );

            Navigator.pushReplacementNamed(
              context,
              OrderHistoryScreen.routeName,
            );
          },
          onFailure: (response) {
            Navigator.pushReplacementNamed(context, BottomNavBar.routeName);
            ShowSnack(context, "Payment failed!");
          },
          // context: context,
        );
      } else {
        throw Exception("Order creation failed");
      }
    } catch (e) {
      // debugPrint("Error creating order: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateOrder(
    OrderModel updatedOrder, {
    required BuildContext context,
    paymentId,
    signature,
  }) async {
    try {
      int index = _orders.indexWhere((order) => order == updatedOrder);
      if (index != -1) {
        _orders[index] = updatedOrder;
      }
      // log("Reached updateOrder function");
      final url = Uri.parse("$BASE_URL/order/updateOrder");

      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          // "x-auth-token": token!,
        },
        body: jsonEncode({
          "orderId": updatedOrder.sId,
          "status": updatedOrder.status,
          "razorPayPaymentId": paymentId,
          "razorPaySignature": signature,
        }), // ✅ Correct,
      );
      // log("${response.body}");

      if (response.statusCode == 200) {
        ShowSnack(context, "Order Updated Successfully!");
      } else {
        throw Exception("Order cannot be updated");
      }
    } catch (e) {
      // debugPrint("Error updating order: $e");
    } finally {
      notifyListeners();
    }
  }

  //
  // void removeOrder(String orderId) {
  //   _orders.removeWhere((order) => order.sId == orderId);
  //   notifyListeners();
  // }
}
