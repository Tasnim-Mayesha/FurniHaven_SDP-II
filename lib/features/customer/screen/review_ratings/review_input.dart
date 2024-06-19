import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../utils/global_colors.dart';

class ReviewInputPage extends StatefulWidget {
  final Function(String, double, String?) onSubmit;

  const ReviewInputPage({required this.onSubmit});

  @override
  _ReviewInputPageState createState() => _ReviewInputPageState();
}

class _ReviewInputPageState extends State<ReviewInputPage> {
  double rating = 0;
  final TextEditingController reviewController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Write Your Review',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    this.rating = rating;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: reviewController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your review here',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.camera_alt),
                      label: Text('Upload Photo'),
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
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  widget.onSubmit(
                    reviewController.text,
                    rating,
                    _imageFile?.path,
                  );
                  Navigator.pop(context);
                },
                child: Text('SUBMIT REVIEW'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.mainColor,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
