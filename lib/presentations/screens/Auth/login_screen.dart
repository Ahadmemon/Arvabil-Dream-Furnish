import 'package:adf/presentations/screens/Auth/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/primary_textfield.dart';

final _formKey = GlobalKey<FormState>();

class SignInScreen extends StatefulWidget {
  static const String routeName = "login";

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true; // for password visibility toggle
  bool isLoading = false;

  // Function to handle sign in
  signIn() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    authService.signIn(
      context: context,
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              "Login to use an app",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: Form(
            key: _formKey, // Associate the form key here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Email TextField
                PrimaryTextField(
                  controller: emailController,
                  hintText: "E-mail",
                  icon: Icon(Icons.mail),
                ),
                const SizedBox(height: 30),
                // Password TextField with Toggle
                PrimaryTextField(
                  hintText: "Password",
                  controller: passwordController,
                  obscureText: obscureText,
                  icon: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Forget Password Button
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {
                //       Navigator.pushReplacement(
                //         context,
                //         PageTransition(
                //           type: PageTransitionType.leftToRight,
                //           alignment: Alignment.bottomLeft,
                //           child: ForgetPasswordScreen(),
                //         ),
                //       );
                //     },
                //     child: const Text(
                //       "Forget Password?",
                //       style: TextStyle(
                //           fontSize: 18,
                //           color: Colors.black,
                //           decoration: TextDecoration.underline,
                //           decorationColor: Colors.black),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 30),
                // Sign In Button
                isLoading
                    ? const CircularProgressIndicator(
                      color: Colors.black,
                      strokeCap: StrokeCap.round,
                    )
                    : CustomButton(
                      icon: Icons.login,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signIn();
                        }
                      },
                      label: 'Sign In',
                    ),
                const SizedBox(height: 20),
                // Don't have an account link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            alignment: Alignment.bottomLeft,
                            child: const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.brown[500],
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
