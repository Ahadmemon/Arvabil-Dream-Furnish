import 'package:flutter/material.dart';

class CarasoulDetailPage extends StatefulWidget {
  const CarasoulDetailPage({super.key});

  @override
  State<CarasoulDetailPage> createState() => _CarasoulDetailPageState();
}

class _CarasoulDetailPageState extends State<CarasoulDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),
      ),
    );
  }
}
