import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/order_provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  static const routeName = "orderHistoryScreen";

  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch orders when the screen is initialized
    Future.microtask(() {
      Provider.of<OrderProvider>(
        context,
        listen: false,
      ).fetchOrdersForUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the orders from the provider
    final orders = Provider.of<OrderProvider>(context).orders;

    return Scaffold(
      appBar: AppBar(title: const Text("Your Orders")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:
            orders.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                  itemExtent: 180,
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Displaying items in the order
                              Wrap(
                                children:
                                    order.items?.map<Widget>((cartItem) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Hero(
                                            tag: cartItem.product?.image ?? '',
                                            child: Image.network(
                                              cartItem.product?.image![0] ?? '',
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            cartItem.product?.name ??
                                                'No title',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "Rs ${cartItem.product?.price?.toString() ?? 'No price'}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList() ??
                                    [],
                              ),
                              const SizedBox(height: 8),
                              // Display Order ID
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Order ID: ${order.sId ?? 'Unknown'}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Date: ${order.createdOn!.split('T')[0]}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          (order.status == "Delivered" ||
                                                  order.status ==
                                                      "Order Placed")
                                              ? Colors.green
                                              : order.status == "Shipping"
                                              ? Colors.orange
                                              : Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      order.status ?? 'Unknown Status',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
