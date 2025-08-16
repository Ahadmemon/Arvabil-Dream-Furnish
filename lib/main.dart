import 'package:adf/presentations/screens/Initials/splash_screen.dart';
import 'package:adf/provider/cart_provider.dart';
import 'package:adf/provider/feedback_provider.dart';
import 'package:adf/provider/order_provider.dart';
import 'package:adf/provider/user_provider.dart';
import 'package:adf/provider/wishlist_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/routes.dart';

const String myTokenKey = "x-auth-token";
const String BASE_URL = "https://https-github-com-ahadmemon.onrender.com/api";

void main() {
  WidgetsApp.debugAllowBannerOverride = false;
  debugPrintGestureArenaDiagnostics = false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => FeedbackProvider()),
        // ChangeNotifierProvider(create: (context) => ProductProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setOptimalDisplayMode();
  }

  Future<void> setOptimalDisplayMode() async {
    final List<DisplayMode> supportedModes = await FlutterDisplayMode.supported;
    final DisplayMode activeMode = await FlutterDisplayMode.active;

    if (supportedModes.isEmpty) return;

    // Filter modes that match the current resolution
    final List<DisplayMode> matchingModes =
        supportedModes
            .where(
              (mode) =>
                  mode.width == activeMode.width &&
                  mode.height == activeMode.height,
            )
            .toList();

    // Prioritize highest refresh rate but ensure compatibility across devices
    matchingModes.sort((a, b) => b.refreshRate.compareTo(a.refreshRate));

    // Select best mode considering min (1Hz) and max (120Hz) refresh rates
    final DisplayMode optimalMode = matchingModes.firstWhere(
      (mode) => mode.refreshRate >= 60 && mode.refreshRate <= 120,
      orElse: () => matchingModes.isNotEmpty ? matchingModes.first : activeMode,
    );

    await FlutterDisplayMode.setPreferredMode(optimalMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Arvabil Dream Furnish",
      onGenerateRoute: (settings) => Routes.onGenerateRoutes(settings),
      initialRoute: SplashScreen.routeName,

      // Set the initial route
      theme: appTheme,

      debugShowCheckedModeBanner: false,
      // home: const SplashScreen(),
    );
  }
}

final ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFC0B4AC),
  // Saddle Brown
  scaffoldBackgroundColor: Color(0xFFEEE9E9),
  // Light Beige
  appBarTheme: const AppBarTheme(
    // backgroundColor: Color(0xFFEEE9E9), // Dark Brown
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(
      color: Color(0xFFF5DEB3), // Tan
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white, // Wheat
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  drawerTheme: const DrawerThemeData(
    // backgroundColor: Color(0xFF8B4513), // Saddle Brown
    backgroundColor: Colors.black,
  ),
  iconTheme: IconThemeData(
    color: Color(0xFFDEB887), // Burlywood
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF8B4513), // Saddle Brown
    textTheme: ButtonTextTheme.primary,
  ),
  fontFamily: GoogleFonts.balooPaaji2().fontFamily,
);
