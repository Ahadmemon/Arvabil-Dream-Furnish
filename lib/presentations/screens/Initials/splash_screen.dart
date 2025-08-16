import 'package:adf/presentations/screens/Initials/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import '../../../services/auth_service.dart';
import '../../widgets/bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "splashScreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final AuthService authService = AuthService();

  // bool isLoggedIn = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // log("Splash Screen init");

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();

    // Ensure we wait for user data before checking the token
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await authService.getUserData(context: context); // Ensure it completes

      final userProvider =
          Provider.of<UserProvider>(context, listen: false).user.token;
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          userProvider!.isNotEmpty
              ? BottomNavBar.routeName
              : WelcomePage.routeName,
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/bg1.jpeg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: screenWidth * 0.6, // Set the size of the circle
                height: screenHeight * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/icon/icon1.png"),
                    // fit: BoxFit
                    //     .cover, // Ensures the image fits within the circle
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
