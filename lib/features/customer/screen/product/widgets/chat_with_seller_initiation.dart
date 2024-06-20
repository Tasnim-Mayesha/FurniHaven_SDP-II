import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/button.dart';
import 'package:sdp2/features/customer/screen/message/message_list.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

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
          borderRadius: BorderRadius.circular(35),  // Set the radius to half of the width/height
          child: CustomButton(
            text: 'Chat with Seller',
            onTap: () {
              Get.to(const MessageList());
            },
          ),
        ),
      ),

        const Spacer(),
          const InkWell(
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
