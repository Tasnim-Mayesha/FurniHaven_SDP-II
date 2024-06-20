import 'package:flutter/material.dart';
import 'dart:io';

class ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;

  const ReviewCard({super.key, required this.review});

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
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: List.generate(
                        review['rating'].toInt(),
                            (index) => const Icon(
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
            const SizedBox(height: 10),
            Text(review['review']),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            Text(
              review['date'],
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
