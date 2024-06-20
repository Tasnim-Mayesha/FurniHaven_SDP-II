import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import '../../../../utils/global_colors.dart'; // Add this import for date formatting


class ChatWithSeller extends StatefulWidget {
  final String brandImage;

  final String brandName;

  ChatWithSeller({required this.brandImage, required this.brandName});

  @override
  _ChatWithSellerState createState() => _ChatWithSellerState();
}

class _ChatWithSellerState extends State<ChatWithSeller> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _sendMessage(String text, [File? image]) {
    if (text.isEmpty && image == null) return;

    String currentTime = DateFormat('HH:mm').format(DateTime.now()); // Get current time

    setState(() {
      _messages.add({
        'text': text,
        'image': image,
        'isMe': true,
        'time': currentTime,
      });
    });
    _controller.clear();
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
        backgroundColor: GlobalColors.mainColor, // Set the app bar color
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Row(
            children: [
              Container(
                width: 50,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage(widget.brandImage), // Use the passed seller image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    'Chat with Seller', // Use the passed brand name
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (ctx, i) {
                return ChatBubble(
                  message: _messages[i]['text'] ?? '',
                  image: _messages[i]['image'],
                  isMe: _messages[i]['isMe'],
                  time: _messages[i]['time'],
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
  final File? image;
  final bool isMe;
  final String time;

  ChatBubble({required this.message, this.image, required this.isMe, required this.time});

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
                  ? BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
                  : BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.file(
                  image!,
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          if (message.isNotEmpty)
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6, // Max width 60% of screen width
              ),
              child: Material(
                color: isMe ? Colors.orange[400] : Colors.grey[300],
                borderRadius: isMe
                    ? BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
                    : BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
          SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 12),
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

  ChatInputField({
    required this.controller,
    required this.onSend,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: onPickImage,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Write message...',
                  border: InputBorder.none,
                ),
                minLines: 1,
                maxLines: null, // Allows multiple lines
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              onSend(controller.text);
            },
          ),
        ],
      ),
    );
  }
}
