import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/cartModel.dart';
import '../../../models/orderModel.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/user_provider.dart';
import '../../widgets/custom_button.dart';
import '../Home/edit_profile_screen.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  ConfirmOrderScreen(this.cartItems);

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("Order Screen Items: ${jsonEncode(widget.cartItems)}");
    final userProvider = context.watch<UserProvider>().user;
    final orderProvider = context.watch<OrderProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('Confirm Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              // height: 200,
              decoration: BoxDecoration(
                color: Color(0xFFDEB887),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${userProvider.name}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Number: +91 ${userProvider.phone}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Address: ${userProvider.address}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              }, // Does nothing
              child: Text('Edit Profile', style: TextStyle(fontSize: 16)),
            ),
            Spacer(),
            CustomButton(
              onPressed: () {
                // log("Reached place order button");
                final cartItems = widget.cartItems;

                // debugPrint("Debug Print${jsonEncode(cartItems)}");

                OrderModel orderModel = OrderModel(items: cartItems);
                print("Order Model before sending:  ${orderModel.toJson()}");
                // log("From order Screen ${orderModel}");
                orderProvider.createOrder(context, orderModel);
              },
              label: 'Confirm Details and Pay',
            ),
          ],
        ),
      ),
    );
  }
}

// class PaymentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Payment')),
//       body: Center(child: Text('Payment Screen')),
//     );
//   }
// }
