import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../presentations/widgets/snackbar.dart';

void httpErrorHandler(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      ShowSnack(context, jsonDecode(response.body)['message']);
      break;
    case 500:
      ShowSnack(context, jsonDecode(response.body)['message']);
      break;
    default:
      ShowSnack(context, jsonDecode(response.body));
      break;
  }
}
