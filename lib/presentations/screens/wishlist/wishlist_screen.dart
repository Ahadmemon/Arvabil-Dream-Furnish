import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/productModel.dart';
import '../../../provider/wishlist_provider.dart';
import '../../../services/user_services.dart';
import '../Product/product_detail_screen.dart';
import 'add_to_wishlist.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final UserServices userServices = UserServices();
  List<ProductModel>? allProducts;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void fetchAllProducts() async {
    allProducts = await userServices.fetchAllProducts(context);
    setState(() {});
  }

  void _navigateToDetail(BuildContext context, ProductModel product) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => ProductDetailScreen(product: product),
        //_, __, ___ these are unused paramaters, To avoid unused parameter warnings, we use _, __, and ___ as dummy variables.but they are used as placeholders for unused parameters in anonymous functions (lambdas) to improve code readability.
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItems =
        allProducts
            ?.where((product) => wishlistProvider.isInWishlist(product.id!))
            .toList() ??
        [];

    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body:
          allProducts == null
              ? const Center(child: CircularProgressIndicator())
              : wishlistItems.isEmpty
              ? const Center(child: Text("No items in Wishlist"))
              : GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: wishlistItems.length,
                itemBuilder: (context, index) {
                  final product = wishlistItems[index];

                  return GestureDetector(
                    onTap: () => _navigateToDetail(context, product),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  product.image!.isNotEmpty
                                      ? product.image![0]
                                      : "assets/placeholder.png",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.name!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: AddToWishlist(productId: product.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
