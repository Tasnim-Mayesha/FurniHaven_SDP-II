import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/button.dart';
import 'package:sdp2/features/customer/screen/message/chat.dart';
import '../../../../../common/widgets/bottomnavbar/customer_starting.dart';
import '../../../../../common/widgets/bottomnavbar/starting_controller.dart';

class ActionButtonsRow extends StatefulWidget {
  final String sellerEmail;
  final String brandName;

  ActionButtonsRow({Key? key, required this.sellerEmail, required this.brandName}) : super(key: key);

  @override
  _ActionButtonsRowState createState() => _ActionButtonsRowState();
}

class _ActionButtonsRowState extends State<ActionButtonsRow> {
  String userId = '';
  String userName = '';
  String userImage = '';

  @override
  void initState() {
    super.initState();
    fetchCurrentUserDetails();
  }

  Future<void> fetchCurrentUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String currentUserId = user.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(currentUserId).get();

      if (userDoc.exists) {
        setState(() {
          userId = userDoc.id;
          userName = userDoc['userName'];
          userImage = userDoc['profilePicture'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  35), // Set the radius to half of the width/height
              child: CustomButton(
                text: 'Chat with Seller',
                onTap: () {
                  Get.to(() => ChatScreen(
                    sellerEmail: widget.sellerEmail,
                    brandName: widget.brandName,
                    userId: userId,
                    userName: userName,
                    userImage: userImage,
                  ));
                },
              ),
            ),
          ),
          const Spacer(),
          const InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('AR',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                SizedBox(width: 5),
                Icon(Icons.arrow_upward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
