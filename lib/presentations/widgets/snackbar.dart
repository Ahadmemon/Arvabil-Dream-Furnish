import 'package:flutter/material.dart';

void ShowSnack(BuildContext context, String text) {
  if (!context.mounted) return; // Only return if the context is not mounted
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black87,
      showCloseIcon: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
