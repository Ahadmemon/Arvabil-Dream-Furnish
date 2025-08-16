// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
//
// const String BASE_URL = "http://192.168.0.103:3000/api";
// const Map<String, dynamic> DEFAULT_HEADERS = {
//   "Content-type": "application/json"
// };
//
// class Api {
//   final Dio dio = Dio();
//
//   Api() {
//     dio.options.baseUrl = BASE_URL;
//     dio.options.headers = DEFAULT_HEADERS;
//     //interceptors: works as middleware and works on res or req or both
//     dio.interceptors.add(
//       PrettyDioLogger(
//           requestBody: true,
//           requestHeader: true,
//           responseBody: true,
//           responseHeader: true),
//     );
//   }
//
//   Dio get sendRequest => dio;
// }
//
// class ApiResponse {
//   bool success;
//   dynamic data;
//   String? message;
//
//   ApiResponse({required this.success, this.data, this.message});
//
//   factory ApiResponse.fromResponse(Response response) {
//     final data = response.data as Map<String, dynamic>;
//     return ApiResponse(
//         success: data["success"],
//         data: data["data"],
//         message: data["message"] ?? "No message");
//   }
// }
