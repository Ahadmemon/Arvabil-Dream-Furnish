// import 'package:admin/models/orderModel.dart';
// import 'package:flutter/material.dart';
//
// class OrderDetailScreen extends StatelessWidget {
//   final OrderModel order;
//
//   const OrderDetailScreen({super.key, required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Order Detail")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Hero(
//               tag: order["image"]!,
//               child: Image.asset(
//                 order["image"]!,
//                 height: 200,
//                 width: 200,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               order["title"]!,
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               order["price"]!,
//               style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: order["status"] == "Delivered"
//                     ? Colors.green
//                     : order["status"] == "Shipping"
//                         ? Colors.orange
//                         : Colors.red,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 order["status"]!,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
