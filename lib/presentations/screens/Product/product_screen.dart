// import 'package:admin/presentations/screens/wishlist_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import '../../productDetail/product_detail_screen.dart';
//
// class ProductScreen extends StatefulWidget {
//   const ProductScreen({super.key});
//
//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }
//
// class _ProductScreenState extends State<ProductScreen> {
//   final List<Color> _iconColors = [];
//   final List<Map<String, String>> _favoriteProducts = [];
//
//   final List<Map<String, String>> products = [
//     {
//       'name': 'Premium Swing',
//       'price': 'Rs.10000',
//       'image': 'assets/ArvabilSwings/s1.png'
//     },
//     {
//       'name': 'Premium Sofa',
//       'price': 'Rs.20000',
//       'image': 'assets/ArvabilSofa/s4.png'
//     },
//     {
//       'name': 'Premium Table',
//       'price': 'Rs.2000',
//       'image': 'assets/ArvabilTables/t1.png'
//     },
//     {
//       'name': 'Premium Chair',
//       'price': 'Rs.1000',
//       'image': 'assets/ArvabilChairs/c1.png'
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize icon colors to white for all products
//     _iconColors.addAll(List.generate(products.length, (_) => Colors.white));
//   }
//
//   void _toggleIconColor(int index) {
//     setState(() {
//       if (_iconColors[index] == Colors.red) {
//         _iconColors[index] = Colors.white;
//         _favoriteProducts.removeWhere(
//             (product) => product['name'] == products[index]['name']);
//       } else {
//         _iconColors[index] = Colors.red;
//         _favoriteProducts.add(products[index]);
//       }
//     });
//   }
//
//   void _viewFavorites() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => WishListScreen(favorites: _favoriteProducts),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Our Products"),
//         actions: [
//           IconButton(
//             icon: const Icon(CupertinoIcons.heart_fill),
//             onPressed: _viewFavorites,
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemExtent: 150,
//         itemBuilder: (context, index) {
//           return ProductTile(
//             productName: products[index]['name']!,
//             productPrice: products[index]['price']!,
//             productImage: products[index]['image']!,
//             iconColor: _iconColors[index],
//             onFavoritePressed: () => _toggleIconColor(index),
//             onProductTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductDetailScreen(
//                     productName: products[index]['name']!,
//                     productPrice: products[index]['price']!,
//                     productImage: products[index]['image']!,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ProductTile extends StatelessWidget {
//   final String productName;
//   final String productPrice;
//   final String productImage;
//   final Color iconColor;
//   final VoidCallback onFavoritePressed;
//   final VoidCallback onProductTap;
//
//   const ProductTile({
//     super.key,
//     required this.productName,
//     required this.productPrice,
//     required this.productImage,
//     required this.iconColor,
//     required this.onFavoritePressed,
//     required this.onProductTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withValues(alpha: 0.5),
//             spreadRadius: 3,
//             blurRadius: 7,
//             offset: const Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: onProductTap,
//             child: Row(
//               children: [
//                 Image.asset(
//                   productImage,
//                   height: 120,
//                   width: 150,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5, top: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         productName,
//                         textAlign: TextAlign.start,
//                         maxLines: null,
//                         overflow: TextOverflow.ellipsis,
//                         softWrap: true,
//                         style: const TextStyle(fontSize: 18),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         productPrice,
//                         style: TextStyle(fontSize: 18, color: Colors.grey[700]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(FontAwesomeIcons.solidHeart),
//             color: iconColor,
//             onPressed: onFavoritePressed,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
