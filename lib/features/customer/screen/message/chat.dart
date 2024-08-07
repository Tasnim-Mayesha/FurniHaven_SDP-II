import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import '../../../../utils/global_colors.dart';

class ChatScreen extends StatefulWidget {
  final String sellerEmail;
  final String brandName;
  final String userId;
  final String userName;
  final String userImage;

  const ChatScreen({
    super.key,
    required this.sellerEmail,
    required this.brandName,
    required this.userId,
    required this.userName,
    required this.userImage,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? sellerId;
  String? userId;
  String? sellerName;
  String? sellerImage;

  @override
  void initState() {
    super.initState();
    _fetchSellerDetails();
    _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userId = user?.uid;
    });
  }

  Future<void> _fetchSellerDetails() async {
    final sellerSnapshot = await FirebaseFirestore.instance
        .collection('Sellers')
        .where('email', isEqualTo: widget.sellerEmail)
        .get();

    if (sellerSnapshot.docs.isNotEmpty) {
      final sellerData = sellerSnapshot.docs.first.data();
      setState(() {
        sellerImage = sellerData['profilePicture'];
        sellerName = sellerData['sellerName'];
        sellerId = sellerSnapshot.docs.first.id;
      });
    }
  }

  Future<void> _sendMessage(String text, [File? image]) async {
    if (text.isEmpty && image == null) return;

    String currentTime = DateFormat('HH:mm').format(DateTime.now());

    String? imageUrl;
    if (image != null) {
      imageUrl = await _uploadImage(image);
    }

    final chatData = {
      'sender': userId,
      'receiver': sellerId,
      'message': text,
      'imageUrl': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance.collection('Chats').add(chatData);
    _controller.clear();
  }

  Future<String?> _uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance.ref().child('chat_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _sendMessage('', File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: sellerId == userId
                  ? NetworkImage(sellerImage ?? '')
                  : NetworkImage(widget.userImage),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Text(
              sellerName != null ? '$sellerName (${widget.brandName})' : '${widget.userName}',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Chats')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final chatDocs = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, i) {
                    final chatData = chatDocs[i].data() as Map<String, dynamic>;
                    bool isMe = chatData['sender'] == userId;
                    return ChatBubble(
                      message: chatData['message'] ?? '',
                      image: chatData['imageUrl'],
                      isMe: isMe,
                      time: (chatData['timestamp'] as Timestamp?)?.toDate().toString() ?? '',
                    );
                  },
                );
              },
            ),
          ),
          ChatInputField(
            controller: _controller,
            onSend: _sendMessage,
            onPickImage: _pickImage,
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String? image;
  final bool isMe;
  final String time;

  const ChatBubble({
    super.key,
    required this.message,
    this.image,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (image != null)
            Material(
              color: isMe ? Colors.orange[400] : Colors.grey[300],
              borderRadius: isMe
                  ? const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
                  : const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  image!,
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          if (message.isNotEmpty)
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              child: Material(
                color: isMe ? Colors.orange[400] : Colors.grey[300],
                borderRadius: isMe
                    ? const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
                    : const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 5),
          Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String, [File?]) onSend;
  final Function() onPickImage;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: onPickImage,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Write message...',
                  border: InputBorder.none,
                ),
                minLines: 1,
                maxLines: null,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              onSend(controller.text);
            },
          ),
        ],
      ),
    );
  }
}