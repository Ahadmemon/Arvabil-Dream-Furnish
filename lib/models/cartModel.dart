import 'dart:developer';

import 'package:adf/models/productModel.dart';

class CartItem {
  ProductModel? product;
  int? quantity;

  CartItem({this.product, this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    try {
      return CartItem(
        product:
            json['product'] != null
                ? ProductModel.fromJson(json['product'] as Map<String, dynamic>)
                : null,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      );
    } catch (e) {
      log("CartItem parsing failed: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {'product': product?.toJson() ?? {}, 'quantity': quantity};
  }
}
