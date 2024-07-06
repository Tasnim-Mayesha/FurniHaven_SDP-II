import 'dart:io';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class Product3DViewer extends StatefulWidget {
  final String modelUrl;

  const Product3DViewer({super.key, required this.modelUrl});

  @override
  _Product3DViewerState createState() => _Product3DViewerState();
}

class _Product3DViewerState extends State<Product3DViewer> {
  String? _localModelPath;

  @override
  void initState() {
    super.initState();
    _downloadAndCacheModel();
  }

  Future<void> _downloadAndCacheModel() async {
    try {
      // Get the directory to save the file
      final directory = await getApplicationDocumentsDirectory();

      // Generate a unique file name based on the URL
      final fileName = widget.modelUrl.split('/').last.split('?').first;
      final filePath = '${directory.path}/$fileName';

      // Check if the file already exists
      if (await File(filePath).exists()) {
        setState(() {
          _localModelPath = filePath;
        });
        return;
      }

      // Download the model file
      final response = await http.get(Uri.parse(widget.modelUrl));
      final file = File(filePath);

      // Save the file locally
      await file.writeAsBytes(response.bodyBytes);

      // Update the state with the local file path
      setState(() {
        _localModelPath = filePath;
      });
    } catch (e) {
      print('Error downloading model: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: _localModelPath == null
          ? Center(child: CircularProgressIndicator())
          : ModelViewer(
        src: 'file://$_localModelPath', // Use file:// scheme
        ar: true,
      ),
    );
  }
}
