import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PaymentScreen(),
  ));
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = "Amazon Pay"; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paymentOption("Amazon Pay", "amazon_pay"),
            paymentOption("Credit Card", "credit_card"),
            paymentOption("Paypal", "paypal"),
            paymentOption("Google Pay", "google_pay"),
            SizedBox(height: 20),
            Divider(),
            priceDetails(),
            SizedBox(height: 20),
            confirmPaymentButton(),
          ],
        ),
      ),
    );
  }

  Widget paymentOption(String title, String value) {
    return ListTile(
      leading: Radio<String>(
        value: title,
        groupValue: selectedPayment,
        onChanged: (String? newValue) {
          setState(() {
            selectedPayment = newValue!;
          });
        },
      ),
      title: Text(title),
      trailing: paymentIcon(value),
    );
  }

  Widget paymentIcon(String type) {
    switch (type) {
      case "amazon_pay":
        return Image.asset('assets/icon/icon1.png', height: 25);
      case "credit_card":
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icon/icon1.png', height: 25),
            SizedBox(width: 5),
            Image.asset('assets/icon/icon1.png', height: 25),
          ],
        );
      case "paypal":
        return Image.asset('assets/icon/icon1.png', height: 25);
      case "google_pay":
        return Image.asset('assets/icon/icon1.png', height: 25);
      default:
        return SizedBox();
    }
  }

  Widget priceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        priceRow("Sub-Total", "\$300.50"),
        priceRow("Shipping Fee", "\$15.00"),
        SizedBox(height: 10),
        priceRow("Total Payment", "\$380.50", isTotal: true),
      ],
    );
  }

  Widget priceRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: isTotal ? 16 : 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(amount,
              style: TextStyle(
                  fontSize: isTotal ? 16 : 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: isTotal ? Colors.red : Colors.black)),
        ],
      ),
    );
  }

  Widget confirmPaymentButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: () {
          // Handle payment confirmation
        },
        child: Text("Confirm Payment",
            style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
