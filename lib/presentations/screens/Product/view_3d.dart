import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Product360ViewScreen extends StatelessWidget {
  final String productName;
  final String selected3dImage;

  const Product360ViewScreen({
    super.key,
    required this.productName,
    required this.selected3dImage,
  });

  bool get _has3DModel =>
      selected3dImage.trim().isNotEmpty &&
      (selected3dImage.startsWith("http") || selected3dImage.endsWith(".glb"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "$productName - 360° View",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child:
                  _has3DModel
                      ? ModelViewer(
                        src: selected3dImage,
                        alt: "A 3D model of $productName",
                        autoRotate: true,
                        cameraControls: true,
                        backgroundColor: Colors.white,
                      )
                      : const Text(
                        "No 3D model available for this product.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
            ),
          ),
          if (_has3DModel)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "*This is a computer-generated model. The actual product may differ.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red.shade400,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
