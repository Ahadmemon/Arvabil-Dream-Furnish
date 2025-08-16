import 'package:flutter/material.dart';

import '../../models/productModel.dart';
import '../../services/user_services.dart';
import '../screens/Product/product_detail_screen.dart';
import '../screens/wishlist/add_to_wishlist.dart';

class HomeGridItems extends StatefulWidget {
  const HomeGridItems({super.key});

  @override
  State<HomeGridItems> createState() => _HomeGridItemsState();
}

class _HomeGridItemsState extends State<HomeGridItems> {
  final UserServices userServices = UserServices();
  List<ProductModel>? productsList;

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
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  void fetchAllProducts() async {
    productsList = await userServices.fetchAllProducts(context);
    setState(() {});
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    // ProductModel product = ProductModel();
    // final randomProducts = getRandomProducts(6);
    if (productsList == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (productsList!.isEmpty) {
      return const Center(child: Text("No products available"));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 15,
          childAspectRatio: 0.8,
        ),
        itemCount: productsList!.length,
        itemBuilder: (context, index) {
          final product = productsList![index];
          return GestureDetector(
            onTap: () => _navigateToDetail(context, product),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Hero(
                          // tag: product.name!, // Unique Hero tag
                          tag:
                              product.image!.isNotEmpty
                                  ? product.image![0]
                                  : "placeholder_tag", // Unique Hero tag
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.network(
                              product.image!.isNotEmpty
                                  ? product.image![0]
                                  : "assets/arvabil_swings/s1.png",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${product.name}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Rs. ${product.price}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: screenHeight * 0,
                    right: screenWidth * 0,
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
