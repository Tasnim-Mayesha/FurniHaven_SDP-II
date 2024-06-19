import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Product3DViewer extends StatefulWidget {
  const Product3DViewer({super.key});

  @override
  _Product3DViewerState createState() => _Product3DViewerState();
}

class _Product3DViewerState extends State<Product3DViewer> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      width: double.infinity,
      child: ModelViewer(
        src: 'assets/product3d/office_chair.glb',
        ar: true,

      ),
    );
  }
}