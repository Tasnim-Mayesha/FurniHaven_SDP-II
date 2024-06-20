import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../../utils/global_colors.dart';

class ReviewInputWidget extends StatefulWidget {
  final Function(String review, double rating, File? imageFile) onSubmit;

  const ReviewInputWidget({super.key, required this.onSubmit});

  @override
  _ReviewInputWidgetState createState() => _ReviewInputWidgetState();
}

class _ReviewInputWidgetState extends State<ReviewInputWidget> {
  final TextEditingController reviewController = TextEditingController();
  double rating = 0;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Write Your Review',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              this.rating = rating;
            });
          },
        ),
        const SizedBox(height: 10),
        TextField(
          controller: reviewController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Write your review here',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Upload Photo'),
                onPressed: _pickImage,
              ),
            ),
            if (_imageFile != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(
                  _imageFile!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            widget.onSubmit(reviewController.text, rating, _imageFile);
            reviewController.clear();
            setState(() {
              rating = 0;
              _imageFile = null;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColors.mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('SUBMIT REVIEW'),
        ),
      ],
    );
  }
}
