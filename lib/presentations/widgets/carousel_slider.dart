import 'dart:math'; // ✅ For randomness

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/categoryModel.dart';
import '../../models/productModel.dart';
import '../../services/user_services.dart';
import '../screens/Product/product_detail_screen.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({super.key});

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  final UserServices userServices = UserServices();
  List<ProductModel>? productsList;
  List<CategoryModel>? categories;
  List<ProductModel> randomProducts = [];

  @override
  void initState() {
    super.initState();
    fetchAllCategoriesAndProducts();
  }

  Future<void> fetchAllCategoriesAndProducts() async {
    categories = await userServices.fetchAllCategories(context);
    productsList = await userServices.fetchAllProducts(context);

    if (categories != null && productsList != null) {
      final random = Random();
      randomProducts =
          categories!
              .map((cat) {
                final categoryProducts =
                    productsList!
                        .where(
                          (p) => p.category == cat.name,
                        ) // match by category name
                        .toList();
                if (categoryProducts.isNotEmpty) {
                  return categoryProducts[random.nextInt(
                    categoryProducts.length,
                  )];
                }
                return null;
              })
              .whereType<ProductModel>()
              .toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (randomProducts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CarouselSlider(
        items:
            randomProducts
                .map((product) => _buildCarouselItem(context, product))
                .toList(),
        options: CarouselOptions(
          height: screenHeight * 0.3,
          autoPlay: true,
          autoPlayCurve: Curves.easeInOut,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          viewportFraction: 1,
        ),
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, ProductModel product) {
    final imagePath = product.image![0];

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 600),
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    ProductDetailScreen(product: product),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              // ✅ Fade + Scale transition
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
                  child: child,
                ),
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
