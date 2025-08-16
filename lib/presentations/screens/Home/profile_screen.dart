import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import '../Orders/order_history_screen.dart';
import '../wishlist/wishlist_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<MenuOption> menuOptions = [
    MenuOption(Icons.person, "Edit Profile", EditProfileScreen()),
    // MenuOption(Icons.location_on, "Shopping Address", ShoppingAddressPage()),
    MenuOption(Icons.favorite, "Wishlist", WishlistScreen()),
    MenuOption(Icons.history, "My Orders", OrderHistoryScreen()),
    // MenuOption(Icons.notifications, "Notification", NotificationPage()),
    // MenuOption(Icons.credit_card, "Cards", CardsPage()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // elevation: 0,
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture and Info
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[400],
              child:
                  userProvider.profileImage != null
                      ? ClipOval(
                        child: Image.network(
                          userProvider.profileImage!,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey[900],
                            );
                          },
                        ),
                      )
                      : const Icon(Icons.person, size: 60, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              userProvider.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            // s
            SizedBox(height: 20),

            // List of Menu Options
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: menuOptions.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final option = menuOptions[index];
                return ListTile(
                  leading: Icon(option.icon),
                  title: Text(option.title),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to the respective page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => option.page),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuOption {
  final IconData icon;
  final String title;
  final Widget page;

  MenuOption(this.icon, this.title, this.page);
}

// Placeholder Screens for Navigation
// class EditProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Profile"),
//       ),
//       body: Center(child: Text("Edit Profile Page")),
//     );
//   }
// }

// class ShoppingAddressPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Shopping Address"),
//       ),
//       body: Center(child: Text("Shopping Address Page")),
//     );
//   }
// }

// class WishlistPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Wishlist"),
//       ),
//       body: Center(child: Text("Wishlist Page")),
//     );
//   }
// }

// class OrderHistoryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Order History"),
//       ),
//       body: Center(child: Text("Order History Page")),
//     );
//   }
// }

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification")),
      body: Center(child: Text("Notification Page")),
    );
  }
}

// class CardsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Cards"),
//       ),
//       body: Center(child: Text("Cards Page")),
//     );
//   }
// }
