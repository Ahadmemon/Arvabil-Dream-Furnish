import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import '../../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/primary_textfield.dart';
import '../../widgets/snackbar.dart';
import 'login_screen.dart';

final _formkey = GlobalKey<FormState>();

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>().user;
    void setPassword() {
      if (newPassword.text == confirmPassword.text) {
        ShowSnack(context, "Password reset successfully");

        authService.updatePassword(
          context: context,
          password: confirmPassword.text.trim().toString(),
          id: userProvider.id,
        );
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Passwords do not match",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    }

    String? validatePassword(String? password) {
      if (password == null || password.length < 6) {
        return 'Password must be at least 6 characters';
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Create new password"),
        ),
      ),
      body: Form(
        key: _formkey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text("Reset Password", style: TextStyle(fontSize: 40)),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: PrimaryTextField(
                  controller: newPassword,
                  icon: Icon(Icons.lock),
                  hintText: "New Password",
                  validator: validatePassword,
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: PrimaryTextField(
                  controller: confirmPassword,
                  icon: Icon(Icons.lock_outline),
                  hintText: "Confirm Password",
                  validator: validatePassword,
                  obscureText: true,
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    setPassword();
                  }
                },
                label: "Reset Password",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
