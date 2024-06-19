import 'package:flutter/material.dart';
import 'dart:io';

class ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;

  const ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(review['image']),
                  radius: 24,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: List.generate(
                        review['rating'].toInt(),
                            (index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(review['review']),
            SizedBox(height: 10),
            if (review['reviewImage'] != null && review['reviewImage'].isNotEmpty)
              review['reviewImage'].startsWith('assets/')
                  ? Image.asset(
                review['reviewImage'],
                fit: BoxFit.cover,
              )
                  : Image.file(
                File(review['reviewImage']),
                fit: BoxFit.cover,
              ),
            SizedBox(height: 10),
            Text(
              review['date'],
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
