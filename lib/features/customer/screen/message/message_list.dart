import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  String? userId;
  String? userName;
  String? userImage;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      _fetchUserDetails();
    }
  }

  Future<void> _fetchUserDetails() async {
    if (userId != null) {
      final userSnapshot = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
      if (userSnapshot.exists) {
        setState(() {
          userName = userSnapshot['userName'];
          userImage = userSnapshot['profilePicture'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Chats')
              .where('sender', isEqualTo: userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final chatDocs = snapshot.data!.docs;

            // Get unique seller IDs from the chats
            final sellerIds = chatDocs.map((doc) => doc['receiver']).toSet().toList();

            return ListView.builder(
              itemCount: sellerIds.length,
              itemBuilder: (context, index) {
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('Sellers').doc(sellerIds[index]).get(),
                  builder: (context, sellerSnapshot) {
                    if (!sellerSnapshot.hasData) {
                      return const ListTile(
                        title: Text('Loading...'),
                      );
                    }

                    final sellerData = sellerSnapshot.data!.data() as Map<String, dynamic>?;
                    if (sellerData == null) {
                      return const ListTile(
                        title: Text('Seller not found'),
                      );
                    }

                    final sellerName = sellerData['sellerName'];
                    final sellerImage = sellerData['profilePicture'];
                    final sellerEmail = sellerData['email'];
                    final brandName = sellerData['brandName'];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: sellerImage != null
                            ? NetworkImage(sellerImage)
                            : const AssetImage('assets/images/placeholder.png') as ImageProvider,
                      ),
                      title: Text('$sellerName ($brandName)'),
                      //trailing: const Text('12:20'), // You can add last message time here
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              sellerEmail: sellerEmail,
                              brandName: brandName,
                              userId: userId!,
                              userName: userName!,
                              userImage: userImage!,
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