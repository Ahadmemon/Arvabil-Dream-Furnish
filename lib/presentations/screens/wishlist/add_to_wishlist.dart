import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/wishlist_provider.dart';

class AddToWishlist extends StatelessWidget {
  final String productId;

  const AddToWishlist({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final bool isInWishlist = wishlistProvider.isInWishlist(productId);

    return IconButton(
      icon: Icon(
        isInWishlist ? Icons.favorite : Icons.favorite_border,
        color: isInWishlist ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        wishlistProvider.toggleWishlist(productId, context);
      },
    );
  }
}
