import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/seller/views/chat/controller/chat_controller.dart';
import 'dart:io';

import 'package:sdp2/utils/global_colors.dart';

class ChatWithCustomer extends StatelessWidget {
  final String customerImage;
  final String customerName;

  const ChatWithCustomer(
      {super.key, required this.customerImage, required this.customerName});

  @override
  Widget build(BuildContext context) {
    final SellerChatController controller = Get.put(SellerChatController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Center(
          child: Row(
            children: [
              Container(
                width: 50,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage(customerImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    customerName,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (ctx, i) {
                    return ChatBubble(
                      message: controller.messages[i]['text'] ?? '',
                      image: controller.messages[i]['image'],
                      isMe: controller.messages[i]['isMe'],
                      time: controller.messages[i]['time'],
                    );
                  },
                )),
          ),
          ChatInputField(controller: controller),
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

  const ChatBubble(
      {super.key,
      required this.message,
      this.image,
      required this.isMe,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (image != null)
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: isMe ? Colors.orange[400] : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.file(
                image!,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          if (message.isNotEmpty)
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(
                  message,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 5),
          Text(
            time,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  final SellerChatController controller;

  const ChatInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: controller.pickImage,
          ),
          Expanded(
            child: TextField(
              controller: controller.controller,
              decoration: const InputDecoration(
                  hintText: 'Write message...', border: InputBorder.none),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => controller.sendMessage(controller.controller.text),
          ),
        ],
      ),
    );
  }
}
