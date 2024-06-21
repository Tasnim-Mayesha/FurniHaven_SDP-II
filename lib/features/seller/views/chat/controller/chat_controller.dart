import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SellerChatController extends GetxController {
  var messages = <Map<String, dynamic>>[].obs;
  TextEditingController controller = TextEditingController();
  ImagePicker picker = ImagePicker();

  void sendMessage(String text, [File? image]) {
    if (text.isEmpty && image == null) return;

    String currentTime = DateFormat('HH:mm').format(DateTime.now());

    messages.add({
      'text': text,
      'image': image,
      'isMe': true,
      'time': currentTime,
    });
    controller.clear();
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      sendMessage('', File(pickedFile.path));
    }
  }
}
