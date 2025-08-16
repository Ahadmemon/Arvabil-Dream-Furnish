import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/feedbackModel.dart';

class FeedbackProvider with ChangeNotifier {
  List<FeedbackModel> _feedbacks = [];
  bool _isLoading = false;

  List<FeedbackModel> get feedbacks => _feedbacks;

  bool get isLoading => _isLoading;

  Future<void> submitFeedback(String productId, String feedback) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(myTokenKey);
    if (token == null) return; // Ensure the user is authenticated

    try {
      final response = await http.post(
        Uri.parse("$BASE_URL/feedback/submitFeedback"),
        headers: {"Content-Type": "application/json", "x-auth-token": token},
        body: jsonEncode({"productId": productId, "feedback": feedback}),
      );

      if (response.statusCode == 201) {
        _feedbacks.add(
          FeedbackModel(
            productId: productId,
            feedback: feedback,
            timestamp: DateTime.now(),
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      print("Error submitting feedback: $e");
    }
  }

  Future<void> fetchFeedbacks(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(myTokenKey);
    if (token == null) return;

    _isLoading = true; // Start loading
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("$BASE_URL/feedback/$productId/getFeedbacks"),
        headers: {"x-auth-token": token},
      );
      // log(response.body);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        _feedbacks = data.map((e) => FeedbackModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error fetching feedbacks: $e");
    }

    _isLoading = false; // Stop loading
    notifyListeners();
  }
}
