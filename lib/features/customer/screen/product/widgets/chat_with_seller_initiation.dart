import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/button.dart';
import 'package:sdp2/features/customer/screen/message/message_list.dart';

class ActionButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 250,
            child: CustomButton(
              text: 'Chat with Seller',
              onTap: () {
                Get.to(MessageList());
              },
            ),
          ),
          Spacer(),
          InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('AR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
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
