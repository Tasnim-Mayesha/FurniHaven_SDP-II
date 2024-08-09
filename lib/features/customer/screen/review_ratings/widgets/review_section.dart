import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdp2/features/customer/screen/review_ratings/widgets/review_card.dart';
import '../../../../../utils/global_colors.dart';
import '../review_input.dart';

class ReviewSection extends StatefulWidget {
  final String productId; // Receive productId

  const ReviewSection({super.key, required this.productId});

  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Reviews',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewInputPage(
                  onSubmit: _addReview,
                  productId: widget.productId,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColors.mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          child: const Text('Give Review and Ratings'),
        ),
        /*StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Review and Ratings')
              .where('productId', isEqualTo: widget.productId)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text('No reviews yet.');
            }

            return Column(
              children: snapshot.data!.docs.map((doc) {
                return ReviewCard(review: doc.data() as Map<String, dynamic>);
              }).toList(),
            );
          },
        ),*/

        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Review and Ratings')
              .where('productId', isEqualTo: widget.productId)
              .orderBy('date', descending: true) // Sort by date in descending order
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {

              return const Text('Something went wrong');
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text('No reviews yet.');
            }

            return Column(
              children: snapshot.data!.docs.map((doc) {
                return ReviewCard(review: doc.data() as Map<String, dynamic>);
              }).toList(),
            );
          },
        ),

      ],
    );
  }

  Future<void> _addReview(String review, double rating, String? imageUrl) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
      final userName = userDoc.get('userName');
      final profilePicture = userDoc.get('profilePicture');

      await FirebaseFirestore.instance.collection('Review and Ratings').add({
        'userId': user.uid,
        'productId': widget.productId,
        'userName': userName,
        'profilePicture': profilePicture,
        'review': review,
        'rating': rating,
        'imageUrl': imageUrl,
        'date': DateTime.now(),
      });
    }
  }
}