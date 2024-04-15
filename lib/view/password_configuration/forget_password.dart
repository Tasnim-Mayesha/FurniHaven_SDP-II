import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iconsax/iconsax.dart";
import "package:sdp2/utils/global_colors.dart";
import "package:sdp2/view/password_configuration/reset_password.dart";
import "package:sdp2/view/widgets/button.dart";
import "../widgets/global_textform.dart";

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final TextEditingController emailController=TextEditingController();


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
              ),
            ),
            const SizedBox(height: 48,),
            GlobalTextForm(
              controller: emailController,
              text: 'Email',
              textInputType: TextInputType.emailAddress,
              obscure: false,
              icon: Icon(Iconsax.direct_right,color: GlobalColors.mainColor),
            ),
            const SizedBox(height: 24,),
            CustomButton(text: 'Submit',
              onTap: ()=>Get.off(() => const ResetPassword()))
          ],
        ),
      ),
    );
  }
}
