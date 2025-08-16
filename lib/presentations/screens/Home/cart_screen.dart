import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/cart_provider.dart';
import '../../widgets/snackbar.dart';
import '../Orders/order_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        // First Row: Image and Product Details
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.product!.image?.isNotEmpty == true
                                    ? item.product!.image![0]
                                    : 'https://via.placeholder.com/150',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product!.name ?? 'No Name',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rs ${item.product!.price?.toStringAsFixed(2) ?? '0.00'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item.product!.description ??
                                        'No description',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Second Row: Remove and Quantity Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Remove Button
                            TextButton.icon(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              label: const Text(
                                'Remove',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                // log("Product id: ${item.product?.id}");
                                cartProvider.removeFromCart(
                                  context,
                                  item.product?.id.toString() ?? "",
                                );
                              },
                            ),
                            // Quantity Controls
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    cartProvider.decrementQuantity(
                                      context,
                                      item.product?.id.toString() ?? "",
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(item.quantity.toString()),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    cartProvider.incrementQuantity(
                                      context,
                                      item.product?.id.toString() ?? "",
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Total Price Section
          Container(
            color: Color(0xFFDEB887),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sub total: Rs. ${cartProvider.totalPrice}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // log("From cartScreen ${cartProvider.fetchCart(context)}");
                      // debugPrint(jsonEncode(cartProvider.items));
                      cartProvider.items.length == 0
                          ? ShowSnack(context, "No products found")
                          : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ConfirmOrderScreen(
                                    List.from(cartProvider.items),
                                  ),
                            ),
                          );
                    },
                    child: Text("Order Now", style: TextStyle(fontSize: 18)),
                  ),
                  // Text(
                  //   '\$${_calculateTotal(cartItems).toStringAsFixed(2)}',
                  //   style: const TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.green,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
