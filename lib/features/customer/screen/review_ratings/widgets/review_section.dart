import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:sdp2/features/customer/screen/review_ratings/widgets/review_card.dart';
import '../../../../../utils/global_colors.dart';
import '../review_input.dart';

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
      'rating': 5.0,
      'image': 'assets/users/rabbil.png',
      'reviewImage': 'assets/products/ar_chair_class.png',
    },
    {
      'name': 'Mithila Tanzim',
      'review': 'This is really amazing product, I like the design of product. I hope can buy it again!',
      'date': 'December 10, 2018',
      'rating': 5.0,
      'image': 'assets/users/mithila.png',
      'reviewImage': 'assets/products/ar_chair.png',
    },
    {
      'name': 'Nuraj Tahsin',
      'review': 'air max are always very comfortable fit, clean and just perfect in every way. just the box was too small and scrunched the sneakers up a little bit',
      'date': 'December 10, 2018',
      'rating': 5.0,
      'image': 'assets/users/nuraj.png',
      'reviewImage': 'assets/products/ar_chair.png',
    },
    {
      'name': 'Nafis Ahmed',
      'review': 'air max are always very comfortable fit, clean and just perfect in every way. just the box was too small',
      'date': 'December 10, 2018',
      'rating': 5.0,
      'image': 'assets/users/nafis.png',
      'reviewImage': 'assets/products/ar_chair.png',
    },
  ];

  void _addReview(String review, double rating, String? imagePath) {
    setState(() {
      reviews.insert(0, {
        'name': 'New User',
        'review': review,
        'date': DateTime.now().toString().split(' ')[0],
        'rating': rating,
        'image': 'assets/users/default.png', // Default user image
        'reviewImage': imagePath,
      });
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

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewInputPage(onSubmit: _addReview),
              ),
            );
          },
          child: Text('Give Review and Ratings'),
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColors.mainColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),

        // Display Reviews
        ...reviews.map((review) => ReviewCard(review: review)).toList(),
      ],
    );
  }
}
