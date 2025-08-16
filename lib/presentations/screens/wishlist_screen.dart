import 'package:flutter/material.dart';

class WishListScreen extends StatefulWidget {
  static const routName = "wishlistScreen";

  final List<Map<String, String>> favorites;

  const WishListScreen({super.key, required this.favorites});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Favourite"),
      ),
      // drawer: const MyDrawer(),
      body: widget.favorites.isEmpty
          ? const Center(
              child: Text(
                "No favorite products added yet",
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: widget.favorites.length,
              itemBuilder: (context, index) {
                final product = widget.favorites[index];
                return ListTile(
                  leading: Image.asset(product['image']!),
                  title: Text(product['name']!),
                  subtitle: Text(product['price']!),
                  trailing: const Icon(Icons.favorite, color: Colors.red),
                );
              },
            ),
    );
  }
}
