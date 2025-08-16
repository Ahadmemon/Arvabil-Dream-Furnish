import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import '../screens/Home/cart_screen.dart';
import '../screens/Home/home_screen.dart';
import '../screens/Home/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  static const String routeName = 'home';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const CartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeCart();
  }

  Future<void> _initializeCart() async {
    await Provider.of<CartProvider>(context, listen: false).fetchCart(context);
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final cartItemCount = cartProvider.items.length;

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: _buildNavigationBar(cartItemCount),
    );
  }

  Widget _buildNavigationBar(int cartCount) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: NavigationBar(
          backgroundColor: Colors.white,
          height: 70,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: cartCount > 0,
                label: Text(cartCount.toString()),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              selectedIcon: const Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:admin/presentations/screens/cart_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../provider/cart_provider.dart';
// import '../screens/home_screen.dart';
// import '../screens/profile_screen.dart';
//
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});
//
//   static const String routeName = 'home';
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _pages = [
//     const HomeScreen(),
//     const CartScreen(),
//     ProfilePage(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);
//   }
//
//   void _fetchCartItems() async {
//     await Provider.of<CartProvider>(context).fetchCart(context);
//     setState(() {});
//   }
//
//   void initState() {
//     super.initState();
//     _fetchCartItems();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final cartItemCount = context
//     //     .select<UserProvider, int>((provider) => provider.user.cart.length);
//     // final userProvider = context.watch<UserProvider>().user;
//     // print("User Name: ${userProvider.name}");
//     // final cartItemCount = userProvider.cart.length;
//     // log(cartItemCount.toString());
//
//     final cartProvider = context.watch<CartProvider>();
//     final cartItemCount = cartProvider.items.length;
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _pages,
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           child: NavigationBar(
//             backgroundColor: const Color(0xFFEEE9E9),
//             height: 60,
//             elevation: 0,
//             selectedIndex: _selectedIndex,
//             onDestinationSelected: _onItemTapped,
//             destinations: [
//               const NavigationDestination(
//                 icon: Icon(Icons.home),
//                 label: "Home",
//               ),
//               NavigationDestination(
//                 icon: Badge(
//                   backgroundColor: Colors.blue,
//                   isLabelVisible: cartItemCount > 0,
//                   label: Text('$cartItemCount'),
//                   child: const Icon(Icons.shopping_cart),
//                 ),
//                 label: "Cart",
//               ),
//               const NavigationDestination(
//                 icon: Icon(Icons.account_circle),
//                 label: "Profile",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
