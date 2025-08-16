import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? icon; // Add suffixIcon as a parameter

  const PrimaryTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText,
    this.icon, // Include suffixIcon in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: icon,
        // Use suffixIcon for the eye icon
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), // Adjusted to squircle-like
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), // Same here
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), // Also here
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}
