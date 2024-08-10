import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;
  final String currentUserId;

  const ReviewCard({
    super.key,
    required this.review,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    bool isLiked = (review['likedBy'] ?? []).contains(currentUserId);
    bool isDisliked = (review['dislikedBy'] ?? []).contains(currentUserId);

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
                  backgroundImage: NetworkImage(review['profilePicture']),
                  radius: 24,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['userName'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        ...List.generate(
                          review['rating'].toInt(),
                              (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(review['review']),
            const SizedBox(height: 10),
            if (review['imageUrl'] != null && review['imageUrl'].isNotEmpty)
              Image.network(
                review['imageUrl'],
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 10),
            Text(
              review['date'].toDate().toString(),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up, color: isLiked ? Colors.orange : Colors.grey),
                  onPressed: () => _handleLikeDislike('like'),
                ),
                Text('${review['likes']}'),
                const SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.thumb_down, color: isDisliked ? Colors.orange : Colors.grey),
                  onPressed: () => _handleLikeDislike('dislike'),
                ),
                Text('${review['dislikes']}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleLikeDislike(String action) async {
    final docRef = FirebaseFirestore.instance.collection('Review and Ratings').doc(review['id']);
    final userId = currentUserId;

    final docSnapshot = await docRef.get();
    final data = docSnapshot.data() as Map<String, dynamic>;
    final List<dynamic> likedBy = data['likedBy'] ?? [];
    final List<dynamic> dislikedBy = data['dislikedBy'] ?? [];

    if (action == 'like') {
      if (likedBy.contains(userId)) {
        // User is un-liking the review
        likedBy.remove(userId);
        await docRef.update({'likes': FieldValue.increment(-1)});
      } else {
        likedBy.add(userId);
        await docRef.update({'likes': FieldValue.increment(1)});
        if (dislikedBy.contains(userId)) {
          dislikedBy.remove(userId);
          await docRef.update({'dislikes': FieldValue.increment(-1)});
        }
      }
    } else if (action == 'dislike') {
      if (dislikedBy.contains(userId)) {
        // User is un-disliking the review
        dislikedBy.remove(userId);
        await docRef.update({'dislikes': FieldValue.increment(-1)});
      } else {
        dislikedBy.add(userId);
        await docRef.update({'dislikes': FieldValue.increment(1)});
        if (likedBy.contains(userId)) {
          likedBy.remove(userId);
          await docRef.update({'likes': FieldValue.increment(-1)});
        }
      }
    }

    await docRef.update({'likedBy': likedBy, 'dislikedBy': dislikedBy});
  }
}