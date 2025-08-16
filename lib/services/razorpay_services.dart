import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../models/orderModel.dart';

class RazorpayServices {
  static final razorpay = Razorpay();

  static Future<void> checkOutOrder(
    OrderModel orderModel, {
    required Function(PaymentSuccessResponse) onSuccess,
    // required BuildContext context,
    required Function(PaymentFailureResponse) onFailure,
  }) async {
    // final userProvider = context.watch<UserProvider>().user;
    // log(orderModel.user.toString());
    var options = {
      'key': 'rzp_test_gAAQMXIERLag3u',
      "order_id": "${orderModel.razorPayOrderId}",
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {
        'contact': '${orderModel.user!.phone}',
        'email': '${orderModel.user!.email}',
      },
    };
    razorpay.open(options);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (
      PaymentSuccessResponse response,
    ) {
      onSuccess(response);
      // log("Payment Successful");
      razorpay.clear();

      // ShowSnack(context, "Payment Successful");
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (
      PaymentFailureResponse response,
    ) {
      onFailure(response);
      // log("Payment Failed");
      razorpay.clear();
      // ShowSnack(context, "Payment Failed");
    });
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (
      ExternalWalletResponse response,
    ) {
      // log("External Wallet Response");
      // ShowSnack(context, "External Wallet Response");
      razorpay.clear();
    });
  }
}
