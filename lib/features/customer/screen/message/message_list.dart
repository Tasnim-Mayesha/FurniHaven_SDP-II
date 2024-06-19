import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: Center(
        child: Text("Messafe Page",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),


    );
  }
}
