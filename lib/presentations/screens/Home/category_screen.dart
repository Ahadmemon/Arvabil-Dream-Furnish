import 'package:flutter/material.dart';

import '../../../models/productModel.dart';
import '../../../services/user_services.dart';
import '../Product/product_detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "categoryScreen";
  final String? category;

  const CategoryScreen({super.key, this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final UserServices userServices = UserServices();
  List<ProductModel>? productsList;
  String selectedSortOrder =
      'Price: Low to High'; // Default sort order is Ascending

  @override
  void initState() {
    super.initState();
    fetchProductsByCategory();
  }

  void fetchProductsByCategory() async {
    productsList = await userServices.fetchProductsByCategory(
      context,
      widget.category!,
    );
    sortProducts(); // Sort products when they are fetched
    setState(() {});
  }

  // Sorting products by price based on selected sort order
  void sortProducts() {
    if (selectedSortOrder == 'Price: Low to High') {
      productsList!.sort(
        (a, b) => a.price!.compareTo(b.price!),
      ); // Sort in ascending order
    } else {
      productsList!.sort(
        (a, b) => b.price!.compareTo(a.price!),
      ); // Sort in descending order
    }
  }

  void _navigateToDetail(BuildContext context, ProductModel product) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => ProductDetailScreen(product: product),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category!),
        actions: [
          // DropdownButton to select sorting order
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              dropdownColor: Colors.black38,
              value: selectedSortOrder,
              items:
                  <String>[
                    'Price: Low to High',
                    'Price: High to Low',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.white)),
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedSortOrder = newValue!;
                  sortProducts(); // Re-sort products when sort order changes
                });
              },
            ),
          ),
        ],
      ),
      body:
          productsList == null
              ? const Center(child: CircularProgressIndicator())
              : productsList!.isEmpty
              ? const Center(child: Text("No products available"))
              : Padding(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Hero(
                                tag:
                                    product.image!.isNotEmpty
                                        ? product.image![0]
                                        : "placeholder_tag",
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
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
