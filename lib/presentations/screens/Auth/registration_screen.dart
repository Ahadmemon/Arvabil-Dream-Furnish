import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/primary_textfield.dart';
import 'login_screen.dart';

final _formKey = GlobalKey<FormState>();

class RegisterScreen extends StatefulWidget {
  static const routeName = "signUp";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthService authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true; // To track the visibility of the password
  bool isLoading = false;

  void signUp() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    authService.signUp(
      context: context,
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: nameController.text.trim(),
    );
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents screen from moving up
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Create an Account",
            style: TextStyle(fontSize: 22),
          ),
          centerTitle: false,
          elevation: 2,
          titleSpacing: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          PrimaryTextField(
                            controller: nameController,
                            icon: const Icon(Icons.person),
                            hintText: "Name",
                          ),
                          const SizedBox(height: 20),
                          PrimaryTextField(
                            controller: emailController,
                            icon: const Icon(Icons.email),
                            hintText: "Email",
                          ),
                          const SizedBox(height: 20),
                          // Password field with eye icon
                          PrimaryTextField(
                            controller: passwordController,
                            hintText: "Password",
                            obscureText: _obscureText,
                            icon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.black,
                                strokeCap: StrokeCap.round,
                              )
                              : CustomButton(
                                icon: Icons.logout,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signUp();
                                  }
                                },
                                label: 'Sign Up',
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: SignInScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
