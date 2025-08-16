import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../widgets/bottom_navigation_bar.dart';
import '../Auth/login_screen.dart';
import '../Auth/registration_screen.dart';
// Import your DashboardScreen file

class WelcomePage extends StatefulWidget {
  static const routeName = "welcomePage";

  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bgImg.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Welcome!',
                    style: TextStyle(fontSize: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 100),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 600),
                          child: const RegisterScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 53,
                      width: 320,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white),
                      ),
                      child: const Center(
                        child: Text(
                          'Register Yourself',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 600),
                          child: const SignInScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 53,
                      width: 320,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Skip Button
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 900),
                    child: const BottomNavBar(),
                  ),
                );
              },
              child: Center(
                child: Container(
                  height: 45,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
