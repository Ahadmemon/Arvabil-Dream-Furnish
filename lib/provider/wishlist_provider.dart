import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentations/widgets/snackbar.dart';

class WishlistProvider extends ChangeNotifier {
  final Set<String> _wishlist = {}; // Store product IDs

  Set<String> get wishlist => _wishlist;

  WishlistProvider() {
    _loadWishlist(); // Load saved wishlist on startup
  }

  bool isInWishlist(String productId) => _wishlist.contains(productId);

  void toggleWishlist(String productId, BuildContext context) async {
    if (_wishlist.contains(productId)) {
      ShowSnack(context, "Item removed from wishlist");
      _wishlist.remove(productId);
    } else {
      ShowSnack(context, "Item added to wishlist");
      _wishlist.add(productId);
    }
    await _saveWishlist(); // Save changes to SharedPreferences
    notifyListeners();
  }

  Future<void> _saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('wishlist', _wishlist.toList());
  }

  Future<void> _loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedWishlist = prefs.getStringList('wishlist');
    if (savedWishlist != null) {
      _wishlist.addAll(savedWishlist);

      notifyListeners(); // Update UI after loading
    }
  }
}
