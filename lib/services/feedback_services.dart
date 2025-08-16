// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../main.dart';
// import '../models/feedbackModel.dart';
//
// class FeedbackService {
//   Future<void> submitFeedback(String productId, String feedbackText) async {
//     // Retrieve the JWT token from secure storage or shared preferences
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString(myTokenKey);
//
//     final response = await http.post(
//       Uri.parse('http://<YOUR_SERVER_URL>/api/feedback/submit'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token', // Send the token in the header
//       },
//       body: json.encode({
//         'productId': productId,
//         'feedbackText': feedbackText,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       print('Feedback submitted');
//     } else {
//       print('Error submitting feedback');
//     }
//   }
//
//   Future<List<Feedback>> fetchFeedbacks(String productId) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString(myTokenKey); // Retrieve JWT token
//
//     final response = await http.get(
//       Uri.parse('http://<YOUR_SERVER_URL>/api/feedback/fetch/$productId'),
//       headers: {
//         'Authorization': 'Bearer $token', // Send token in the header
//       },
//     );
//
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       return data.map((item) => Feedback.fromJson(item)).toList();
//     } else {
//       throw Exception('Error fetching feedbacks');
//     }
//   }
// }
