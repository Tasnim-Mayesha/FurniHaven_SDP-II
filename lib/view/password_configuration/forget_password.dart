import "package:flutter/material.dart";
import "package:sdp2/utils/global_colors.dart";

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Forget Password',style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(height: 8,),
            Text(
              'Don\'t worry sometimes people can forget too,enter your email and we will send you a password reset link.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: GlobalColors.textColor.withOpacity(0.7)
              )
            )
          ],
        ),
      ),
    );
  }
}
