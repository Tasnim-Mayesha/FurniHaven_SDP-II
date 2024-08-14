import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _searchController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? sellerId;
  String? userId;
  String? sellerName;
  String? sellerImage;
  Map<String, dynamic>? _replyingTo;
  String _searchQuery = '';
  bool _isSearching = false;

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
      'replyTo': _replyingTo,
    };

    await FirebaseFirestore.instance.collection('Chats').add(chatData);
    _controller.clear();
    setState(() {
      _replyingTo = null;
    });
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

  void _setReplyingTo(Map<String, dynamic> message) {
    setState(() {
      _replyingTo = message;
    });
  }

  void _cancelReply() {
    setState(() {
      _replyingTo = null;
    });
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: sellerId != userId
                  ? NetworkImage(sellerImage ?? '')
                  : NetworkImage(widget.userImage),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Text(
              sellerName != null ? '$sellerName (${widget.brandName})' : widget.userName,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          _buildSearchField(), // Added search field below the AppBar
          if (_replyingTo != null)
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Replying to:',
                          style: TextStyle(color: Colors.black54),
                        ),
                        if (_replyingTo!['imageUrl'] != null)
                          CachedNetworkImage(
                            imageUrl: _replyingTo!['imageUrl'],
                            width: 100,
                            height: 100,
                            placeholder: (context, url) => CircularProgressIndicator(
                              backgroundColor: GlobalColors.mainColor,
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        if (_replyingTo!['message'] != null)
                          Text(
                            _replyingTo!['message']!,
                            style: const TextStyle(color: Colors.black54),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: _cancelReply,
                  ),
                ],
              ),
            ),
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
                final filteredChatDocs = chatDocs.where((doc) {
                  final chatData = doc.data() as Map<String, dynamic>;
                  final message = chatData['message'] ?? '';
                  return message.toLowerCase().contains(_searchQuery.toLowerCase());
                }).toList();

                return ListView.builder(
                  reverse: true,
                  itemCount: filteredChatDocs.length,
                  itemBuilder: (ctx, i) {
                    final chatData = filteredChatDocs[i].data() as Map<String, dynamic>;
                    bool isMe = chatData['sender'] == userId;
                    String formattedTime = chatData['timestamp'] != null
                        ? DateFormat('hh:mm a, dd/MM/yyyy')
                        .format((chatData['timestamp'] as Timestamp).toDate())
                        : 'Unknown Time'; // Handle null timestamp

                    return GestureDetector(
                      onLongPress: () => _setReplyingTo(chatData),
                      child: ChatBubble(
                        message: chatData['message'] ?? '',
                        image: chatData['imageUrl'],
                        isMe: isMe,
                        time: formattedTime,
                        replyTo: chatData['replyTo'],
                      ),
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

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              _updateSearchQuery('');
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: _updateSearchQuery,
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String? image;
  final bool isMe;
  final String time;
  final Map<String, dynamic>? replyTo;

  const ChatBubble({
    super.key,
    required this.message,
    this.image,
    required this.isMe,
    required this.time,
    this.replyTo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (replyTo != null) ...[
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Replying to:',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  if (replyTo!['imageUrl'] != null)
                    CachedNetworkImage(
                      imageUrl: replyTo!['imageUrl'],
                      width: 100,
                      height: 100,
                      placeholder: (context, url) => CircularProgressIndicator(
                        backgroundColor: GlobalColors.mainColor,
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  if (replyTo!['message'] != null)
                    Text(
                      replyTo!['message']!,
                      style: const TextStyle(color: Colors.black54, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
          ],
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
                child: CachedNetworkImage(
                  imageUrl: image!,
                  width: 250,
                  height: 250,
                  placeholder: (context, url) => CircularProgressIndicator(
                    backgroundColor: GlobalColors.mainColor,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
            icon: Icon(Icons.photo_camera, color: GlobalColors.mainColor),
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
            icon: Icon(Icons.send, color: GlobalColors.mainColor),
            onPressed: () {
              onSend(controller.text);
            },
          ),
        ],
      ),
    );
  }
}