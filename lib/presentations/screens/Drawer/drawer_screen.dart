import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../../provider/user_provider.dart';
import '../Auth/login_screen.dart';
import '../wishlist/wishlist_screen.dart';
import 'about_us_screen.dart';
import 'contact_us_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>().user;
    return Drawer(
      width: 230,
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              accountName: Text(
                "${userProvider.name}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              accountEmail: Text(
                "${userProvider.email}",
                // Static email as firebase is removed
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  userProvider.profileImage.toString(),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Home

            // Wishlist
            DrawerListTile(
              icon: CupertinoIcons.heart_fill,
              text: 'Wishlist Items',
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WishlistScreen(),
                    ),
                  ),
            ),
            // Products
            // DrawerListTile(
            //   icon: Icons.production_quantity_limits,
            //   text: 'Products',
            //   onTap: () => Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const ProductScreen())),
            // ),
            // About Us
            DrawerListTile(
              icon: Icons.person_2_outlined,
              text: 'About Us',
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUsScreen(),
                    ),
                  ),
            ),
            // Contact Us
            DrawerListTile(
              icon: Icons.call,
              text: 'Contact Us',
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactUsScreen()),
                  ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            // Log Out (without firebase code)
            DrawerListTile(
              icon: Icons.logout,
              text: 'Log Out',
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final token = prefs.getString(myTokenKey);

                await prefs.remove(myTokenKey);
                // debugPrint(token);

                // You can handle logout here without Firebase, for example, navigate to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback onTap;

  const DrawerListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black38),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}

// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class MyDrawer extends StatefulWidget {
//   const MyDrawer({super.key});
//
//   @override
//   State<MyDrawer> createState() => _MyDrawerState();
// }
//
// class _MyDrawerState extends State<MyDrawer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     )..forward(); // Automatically open drawer when this file is invoked
//   }
//
//   void _closeDrawer() => _controller.reverse();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Blur and Fade Background
//         AnimatedBuilder(
//           animation: _controller,
//           builder: (context, _) {
//             double blurValue = 10.0 * _controller.value;
//             double opacityValue = _controller.value;
//
//             return GestureDetector(
//               onTap: _closeDrawer, // Close drawer when tapping outside
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(
//                   sigmaX: blurValue,
//                   sigmaY: blurValue,
//                 ),
//                 child: Container(
//                   color: Colors.black.withOpacity(0.3 * opacityValue),
//                 ),
//               ),
//             );
//           },
//         ),
//
//         // Animated Drawer
//         Align(
//           alignment: Alignment.centerLeft,
//           child: AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               double translateX = -260 + (260 * _controller.value);
//               return Transform.translate(
//                 offset: Offset(translateX, 0),
//                 child: child,
//               );
//             },
//             child: SizedBox(
//               width: 260,
//               child: Drawer(
//                 child: Container(
//                   color: Colors.white,
//                   child: ListView(
//                     padding: EdgeInsets.zero,
//                     children: [
//                       UserAccountsDrawerHeader(
//                         decoration: const BoxDecoration(
//                           color: Colors.brown,
//                         ),
//                         accountName: const Text(
//                           'Ahad Memon',
//                           style: TextStyle(fontSize: 20, color: Colors.white),
//                         ),
//                         accountEmail: const Text(
//                           'guest@example.com',
//                           style: TextStyle(fontSize: 16, color: Colors.white70),
//                         ),
//                         currentAccountPicture: const CircleAvatar(
//                           backgroundImage: AssetImage("assets/icon/icon3.png"),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       DrawerListTile(
//                         icon: CupertinoIcons.house_fill,
//                         text: 'Home',
//                         onTap: () {
//                           // Close drawer and navigate
//                           _closeDrawer();
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const Placeholder()));
//                         },
//                       ),
//                       // Add other DrawerListTile items here
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class DrawerListTile extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   final GestureTapCallback onTap;
//
//   const DrawerListTile(
//       {super.key, required this.icon, required this.text, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: Colors.brown,
//       ),
//       title: Text(
//         text,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//       onTap: onTap,
//     );
//   }
// }
