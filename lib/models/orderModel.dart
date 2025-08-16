import 'package:adf/models/userModel.dart';
import 'package:equatable/equatable.dart';

import 'cartModel.dart';

class OrderModel extends Equatable {
  String? sId;
  UserModel? user;

  // String? userId;
  List<CartItem>? items;
  String? razorPayOrderId;
  String? status;
  String? createdOn;
  String? updatedOn;

  OrderModel({
    this.sId,
    // this.userId,
    this.user,
    this.items,
    this.razorPayOrderId,
    this.status,
    this.createdOn,
    this.updatedOn,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      sId: json['_id'] as String?,
      razorPayOrderId: json['razorPayOrderId'] as String?,
      status: json['status'] as String?,
      createdOn: json['createdOn'] as String?,
      updatedOn: json['updatedOn'] as String?,
      // userId: json['userId'] as String?,
      user:
          json['user'] != null
              ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
              : null,
      items:
          json['items'] != null
              ? (json['items'] as List<dynamic>)
                  .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'razorPayOrderId': razorPayOrderId,
    'status': status,
    'createdOn': createdOn,
    'updatedOn': updatedOn,
    // 'userId': userId,
    'user': user?.toJson(),
    'items': items?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [sId];
}

// import 'package:admin/models/cartModel.dart';
// import 'package:admin/models/userModel.dart';
// import 'package:equatable/equatable.dart';
//
// class OrderModel extends Equatable {
//   String? sId;
//   UserModel? user;
//   List<CartItem>? items;
//   String? razorPayOrderId;
//
//   String? status;
//   String? createdOn;
//   String? updatedOn;
//
//   OrderModel({
//     this.sId,
//     this.status,
//     this.razorPayOrderId,
//     this.createdOn,
//     this.updatedOn,
//     this.items,
//     this.user,
//   });
//
//   OrderModel.fromJson(Map<String, dynamic> json) {
//     // Access the 'data' field
//     var data = json['data'] ?? {};
//
//     // Assign _id from the 'data' object
//     sId = data['_id'];
//
//     // Parse other fields from 'data'
//     status = data['status'] ?? "";
//     razorPayOrderId = data['razorPayOrderId'];
//
//     user = data['user'] != null ? UserModel.fromJson(data['user']) : null;
//     createdOn = data['createdOn'];
//     updatedOn = data['updatedOn'];
//
//     if (data['items'] != null) {
//       items = (data['items'] as List<dynamic>)
//           .map((item) => CartItem.fromJson(item))
//           .toList();
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': sId,
//       'status': status ?? "",
//       'razorPayOrderId': razorPayOrderId,
//       'user': user?.toJson(),
//       'items': items?.map((item) => item.toJson()).toList(),
//       'createdOn': createdOn,
//       'updatedOn': updatedOn,
//     };
//   }
//
//   @override
//   List<Object?> get props => [sId];
// }
//
