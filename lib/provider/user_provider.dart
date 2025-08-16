import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../models/userModel.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    name: '',
    email: '',
    password: '',
    role: '',
    phone: '',
    address: '',
    profileImage: "",

    token: '',
    // city: '',
    // country: '',
    // state: '',
  );

  UserModel get user => _user;

  void setUser(String userJson) {
    try {
      final userData = jsonDecode(userJson);
      // print("User Json: $userJson"); // Log the raw JSON string
      // print(
      //     "Raw User Data: ${userData.toString()}"); // Log the entire decoded JSON

      // Extract the user object and the token
      final userObject = userData['user'];
      final token = userData['token'];

      // Log the extracted user object and token
      // print("User Object: ${userObject.toString()}");
      // print("Token: $token");

      // Ensure that you're correctly parsing the user object
      _user = UserModel.fromJson(userObject)..token = token;

      // Optionally, you can handle the token here (if required):
      // _user.token = token;

      print("User Name after parsing: ${_user.name}");

      // This should notify the listeners and trigger the UI update
      notifyListeners();
    } catch (e) {
      print("Error setting user: $e");
    }
  }
}
