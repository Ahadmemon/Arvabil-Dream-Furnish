import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/http_error_handler.dart';
import '../main.dart';
import '../models/userModel.dart';
import '../presentations/widgets/bottom_navigation_bar.dart';
import '../presentations/widgets/snackbar.dart';
import '../provider/user_provider.dart';

class AuthService {
  void updatePassword({
    required BuildContext context,
    String? id,
    String password = "",
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$BASE_URL/user/updatePassword'),
        body: jsonEncode({'_id': id, 'password': password}),
      );
      Map<String, dynamic> responseData = jsonDecode(res.body);
      if (res.statusCode == 401) {
        String message =
            responseData['message']; // Extracting the error message correctly
        // print("Error: $message");
      }
      // log('Response status: ${res.statusCode}');
      // log('Response body: ${res.body}');
      // Map<String, dynamic> responseData = jsonDecode(res.body);
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          ShowSnack(context, "Saved Changes");
        },
      );
    } catch (er) {
      ShowSnack(context, er.toString());
      // log(er.toString());
    }
  }

  void editProfile({
    required BuildContext context,
    String email = "",
    String password = "",
    String name = "",
    String phone = "",
    String address = "",
    String profileImage = "",
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(myTokenKey);

      if (token == null || token.isEmpty) {
        ShowSnack(context, "User not registered");
        return;
      }
      http.Response res = await http.post(
        Uri.parse('$BASE_URL/user/editUser'),
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
          'address': address,
          'profileImage': profileImage,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': token,
        },
      );
      Map<String, dynamic> responseData = jsonDecode(res.body);
      if (res.statusCode == 401) {
        String message =
            responseData['message']; // Extracting the error message correctly
        // print("Error: $message");
      }
      // log('Response status: ${res.statusCode}');
      // log('Response body: ${res.body}');
      // Map<String, dynamic> responseData = jsonDecode(res.body);
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          ShowSnack(context, "Saved Changes");
        },
      );
    } catch (er) {
      ShowSnack(context, er.toString());
      // log(er.toString());
    }
  }

  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$BASE_URL/user/signIn'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );
      Map<String, dynamic> responseData = jsonDecode(res.body);
      if (res.statusCode == 401) {
        String message =
            responseData['message']; // Extracting the error message correctly
        // print("Error: $message");
      }
      // log('Response status: ${res.statusCode}');
      // log('Response body: ${res.body}');
      // Map<String, dynamic> responseData = jsonDecode(res.body);
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          // Map<String, dynamic> responseData = jsonDecode(res.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();

          String token = jsonDecode(res.body)['token'];
          // log('Token Saved (SignIn): $token');

          await prefs.setString(myTokenKey, responseData['token']);
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomNavBar.routeName,
            (route) => false,
          );
          ShowSnack(context, "User logged in successfully");
        },
      );
    } catch (er) {
      ShowSnack(context, "Invalid Password");
      // log(er.toString());
    }
  }

  Future<void> getUserData({required BuildContext context}) async {
    // log("Reached to getUserData");
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(myTokenKey);

      if (token == null || token.isEmpty) {
        if (context.mounted) return;
        return;
      }

      // 1. Validate Token
      final tokenRes = await http.post(
        Uri.parse('$BASE_URL/user/isTokenValid'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      // log("Token res: ${tokenRes.body}");

      if (tokenRes.statusCode != 200) {
        if (context.mounted) ShowSnack(context, "Token validation failed");
        return;
      }

      final tokenResponse = jsonDecode(tokenRes.body);

      // 2. Check server response structure
      if (tokenResponse['success'] != true) {
        if (context.mounted) ShowSnack(context, "Session expired");
        return;
      }

      // 3. Fetch User Data
      final userRes = await http.get(
        Uri.parse('$BASE_URL/user/'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      // log(userRes.body);

      if (userRes.statusCode == 200) {
        if (context.mounted) {
          final userProvider = Provider.of<UserProvider>(
            context,
            listen: false,
          );
          userProvider.setUser(userRes.body);
          // log(userProvider.user.name.toString());
        }
      } else {
        if (context.mounted)
          ShowSnack(context, "User data fetched successfully!");
        // log("User data error: ${userRes.statusCode} ${userRes.body}");
      }
    } catch (e) {
      if (context.mounted)
        ShowSnack(context, "Session expired - Please login again");
      // log("GetUserData error: $e");
    }
  }

  void signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserModel user = UserModel(
        name: name,
        email: email,
        password: password,
        role: 'user',
        phone: '',
        token: '',
        profileImage: '',
        // cart: [],
        address: '',
        // city: '',
        // country: '',
        // state: '',
      );
      // log("Request body: ${jsonEncode(user.toJson())}");
      http.Response res = await http.post(
        Uri.parse('$BASE_URL/user/signUp'),
        body: jsonEncode(user.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      // log('Response status: ${res.statusCode}');
      // log('Response body: ${res.body}');

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          final responseData = jsonDecode(res.body);
          // Map<String, dynamic> responseData = jsonDecode(res.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();

          String token = jsonDecode(res.body)['token'];
          // log('Token Saved (Signup): $token');

          await prefs.setString(myTokenKey, responseData['token']);
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          ShowSnack(context, "Account created successfully");
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomNavBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (er) {
      ShowSnack(context, er.toString());
      // log(er.toString());
    }
  }
}
