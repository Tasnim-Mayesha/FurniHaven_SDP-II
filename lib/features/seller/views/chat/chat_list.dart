import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../customer/screen/message/chat.dart';

class SellerMessageList extends StatefulWidget {
  const SellerMessageList({super.key});

  @override
  _SellerMessageListState createState() => _SellerMessageListState();
}

class _SellerMessageListState extends State<SellerMessageList> {
  String? sellerId;

  @override
  void initState() {
    super.initState();
    _getCurrentSeller();
  }

  Future<void> _getCurrentSeller() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        sellerId = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      body: sellerId == null
          ? const Center(child: Text('Please log in to view messages')) // Check if the seller is logged in
          : Padding(
        padding: const EdgeInsets.only(top: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Chats')
              .where('receiver', isEqualTo: sellerId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final chatDocs = snapshot.data!.docs;

            // Get unique user IDs from the chats
            final userIds = chatDocs.map((doc) => doc['sender']).toSet().toList();

            return ListView.builder(
              itemCount: userIds.length,
              itemBuilder: (context, index) {
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('Users').doc(userIds[index]).get(),
                  builder: (context, userSnapshot) {
                    if (!userSnapshot.hasData) {
                      return const ListTile(
                        title: Text('Loading...'),
                      );
                    }

                    final userData = userSnapshot.data!.data() as Map<String, dynamic>?;
                    if (userData == null) {
                      return const ListTile(
                        title: Text('User not found'),
                      );
                    }

                    final userName = userData['userName'];
                    final userImage = userData['profilePicture'];
                    final userEmail = userData['email'];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: userImage != null
                            ? NetworkImage(userImage)
                            : const AssetImage('assets/images/placeholder.png') as ImageProvider,
                      ),
                      title: Text(userName),
                      // trailing: const Text('12:20'), // Add last message time here if needed
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              sellerEmail: sellerId!,
                              brandName: '', // Add if applicable
                              userId: userIds[index],
                              userName: userName,
                              userImage: userImage,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
