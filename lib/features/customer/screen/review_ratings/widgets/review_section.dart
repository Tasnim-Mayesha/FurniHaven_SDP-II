import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:sdp2/features/customer/screen/review_ratings/widgets/review_card.dart';

import '../../../../../utils/global_colors.dart';

class ReviewSection extends StatefulWidget {
  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Rabbil Hasan',
      'review': 'air max are always very comfortable fit, clean and just perfect in every way. just the box was too small and scrunched the sneakers up a little bit, not sure if the box was always this small but the 90s are and will always be one of my favorites.',
      'date': 'December 10, 2018',
      'rating': 5,
      'image': 'assets/users/rabbil.png',
      'reviewImage': 'assets/products/ar_chair_class.png',
    },
    {
      'name': 'Mithila Tanzim',
      'review': 'This is really amazing product, I like the design of product. I hope can buy it again!',
      'date': 'December 10, 2018',
      'rating': 5,
      'image': 'assets/users/mithila.png',
      'reviewImage': 'assets/products/ar_chair.png',
    },
    {
      'name': 'Nuraj Tahsin',
      'review': 'air max are always very comfortable fit, clean and just perfect in every way. just the box was too small and scrunched the sneakers up a little bit',
      'date': 'December 10, 2018',
      'rating': 5,
      'image': 'assets/users/nuraj.png',
      'reviewImage': 'assets/products/ar_chair.png',
    },
    {
      'name': 'Nafis Ahmed',
      'review': 'air max are always very comfortable fit, clean and just perfect in every way. just the box was too small',
      'date': 'December 10, 2018',
      'rating': 5,
      'image': 'assets/users/nafis.png',
      'reviewImage': 'assets/products/ar_chair.png',
    },
  ];

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
    return Column(
      children: [
        // Title for Reviews
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Reviews',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),

        // Display Reviews
        ...reviews.map((review) => ReviewCard(review: review)).toList(),

        // Write Review
        SizedBox(height: 20),
        Divider(thickness: 2),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Write Your Review',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
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
            // Add the new review to the list
            setState(() {
              reviews.add({
                'name': 'New User',
                'review': reviewController.text,
                'date': DateTime.now().toString().split(' ')[0],
                'rating': rating,
                'image': 'assets/default_user.png', // Default user image
                'reviewImage': _imageFile?.path,
              });
              reviewController.clear();
              rating = 0;
              _imageFile = null;
            });
          },
          child: Text('SUBMIT REVIEW'),
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColors.mainColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}
