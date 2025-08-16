import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../presentations/screens/Auth/login_screen.dart';
import '../presentations/screens/Auth/registration_screen.dart';
import '../presentations/screens/Home/category_screen.dart';
import '../presentations/screens/Initials/splash_screen.dart';
import '../presentations/screens/Initials/welcome_screen.dart';
import '../presentations/screens/Orders/order_history_screen.dart';
import '../presentations/screens/Product/product_detail_screen.dart';
import '../presentations/widgets/bottom_navigation_bar.dart';

class Routes {
  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return PageTransition(
          type: PageTransitionType.fade, // ✅ Add transition
          child: SplashScreen(),
          settings: settings,
        );
      case BottomNavBar.routeName:
        return PageTransition(
          type: PageTransitionType.fade, // ✅ Slide from right
          child: BottomNavBar(),
          duration: const Duration(milliseconds: 600),
          settings: settings,
        );
      case WelcomePage.routeName:
        return PageTransition(
          type: PageTransitionType.fade, // ✅ Slide from left
          child: WelcomePage(),
          settings: settings,
        );
      case OrderHistoryScreen.routeName:
        return PageTransition(
          type: PageTransitionType.fade, // ✅ Slide from bottom
          child: OrderHistoryScreen(),
          duration: Duration(milliseconds: 1000),

          settings: settings,
        );
      case RegisterScreen.routeName:
        return PageTransition(
          type: PageTransitionType.fade, // ✅ Slide from bottom
          child: RegisterScreen(),
          duration: Duration(milliseconds: 1000),

          settings: settings,
        );
      case SignInScreen.routeName:
        return PageTransition(
          type: PageTransitionType.fade, // ✅ Slide from top
          child: SignInScreen(),
          duration: Duration(milliseconds: 1000),

          settings: settings,
        );
      case CategoryScreen.routeName:
        var category = settings.arguments as String;
        return PageTransition(
          duration: Duration(milliseconds: 200),
          type: PageTransitionType.fade, // ✅ Slide from top
          child: CategoryScreen(category: category),

          settings: settings,
        );
      case ProductDetailScreen.routeName:
        return PageTransition(
          type: PageTransitionType.fade, // ✅ Slide from top
          child: SignInScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text("No route defined for ${settings.name}"),
                ),
              ),
        );
    }
  }
}

// // import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../presentations/screens/dashboard.dart';
// import '../presentations/screens/loginscreen.dart';
// import '../presentations/screens/registration.dart';
// import '../splashscreen.dart';
// import '../welcome_page.dart';
//
// class Routes {
//   static Route? onGenerateRoutes(RouteSettings settings) {
//     switch (settings.name) {
//       case SplashScreen.routeName:
//         return MaterialPageRoute(
//           settings: settings,
//           builder: (_) => SplashScreen(),
//         );
//       case DashBoardScreen.routeName:
//         return MaterialPageRoute(
//           settings: settings,
//           builder: (_) => DashBoardScreen(),
//         );
//       case WelcomePage.routeName:
//         return MaterialPageRoute(
//           settings: settings,
//           builder: (_) => WelcomePage(),
//         );
//       case RegisterScreen.routeName:
//         return MaterialPageRoute(
//           settings: settings,
//           builder: (_) => RegisterScreen(),
//         );
//       case SignInScreen.routeName:
//         return MaterialPageRoute(
//           settings: settings,
//           builder: (_) => SignInScreen(),
//         );
//       default:
//         return null;
//     }
//   }
// }
