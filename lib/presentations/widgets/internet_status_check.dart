// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// class InternetCheckWidget extends StatefulWidget {
//   @override
//   _InternetCheckWidgetState createState() => _InternetCheckWidgetState();
// }
//
// class _InternetCheckWidgetState extends State<InternetCheckWidget> {
//   late Stream<ConnectivityResult> connectivityStream;
//
//   @override
//   void initState() {
//     super.initState();
//     connectivityStream =
//         Connectivity().onConnectivityChanged as Stream<ConnectivityResult>;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<ConnectivityResult>(
//       stream: connectivityStream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active &&
//             snapshot.hasData &&
//             snapshot.data == ConnectivityResult.none) {
//           return Container(
//             width: double.infinity,
//             color: Colors.red,
//             padding: EdgeInsets.all(10),
//             child: Center(
//               child: Text(
//                 'No Internet Connection',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           );
//         }
//         return SizedBox.shrink();
//       },
//     );
//   }
// }
