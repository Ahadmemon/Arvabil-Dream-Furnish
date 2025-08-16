import 'package:adf/presentations/screens/Product/view_3d.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/cartModel.dart';
import '../../../models/productModel.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/feedback_provider.dart';
import '../../../services/user_services.dart';
import '../../widgets/custom_button.dart';
import 'feedback_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = "productDetailScreen";
  final ProductModel product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  UserServices userServices = UserServices();
  int _currentImageIndex = 0;
  final TextEditingController feedbackController = TextEditingController();

  addFeedback() {
    final feedbackProvider = Provider.of<FeedbackProvider>(
      context,
      listen: false,
    );
    feedbackProvider.submitFeedback(
      // Fetch from auth provider or context
      widget.product.id.toString(),
      feedbackController.text.trim(),
    );
    feedbackController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    // final feedbackProvider = context.watch<FeedbackProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.product.image![0],
                child: SizedBox(
                  height: 250,
                  child: Stack(
                    children: [
                      PageView.builder(
                        itemCount: widget.product.image!.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentImageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.product.image![index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                      ),
                      // Positioned 3D View button
                      Positioned(
                        top: 10,
                        right: 10,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => Product360ViewScreen(
                                      productName: '${widget.product.name}',
                                      selected3dImage:
                                          '${widget.product.selected3dImage}',
                                    ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.threed_rotation,
                            size: 18,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "360 View",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.product.image!.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentImageIndex == index ? 12 : 8,
                      height: _currentImageIndex == index ? 12 : 8,
                      decoration: BoxDecoration(
                        color:
                            _currentImageIndex == index
                                ? Colors.black
                                : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              const SizedBox(height: 20),
              const Divider(thickness: 1.5),
              const SizedBox(height: 10),
              Text(
                widget.product.name!,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 10),
              const Divider(thickness: 1.5),
              // const SizedBox(height: 10),
              Text(
                "Rs. ${widget.product.price}",
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
              // const SizedBox(height: 20),
              const Divider(thickness: 1.5),
              // const SizedBox(height: 20),
              Text(
                widget.product.description!,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              // const SizedBox(height: 20),
              const Divider(thickness: 1.5),
              const SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    CustomButton(
                      label: "Add To Cart",
                      icon: Icons.add_shopping_cart,
                      onPressed: () {
                        final cartItem = CartItem(product: widget.product);
                        cartProvider.addToCart(context, cartItem);
                      },
                    ),
                    const SizedBox(height: 15),

                    const SizedBox(height: 20),

                    // Feedback TextField
                    TextField(
                      controller: feedbackController,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Write your feedback...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            addFeedback();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    CustomButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ProductFeedbackScreen(
                                  productId: widget.product.id.toString(),
                                ),
                          ),
                        );
                      },
                      label: "Show feedbacks",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
