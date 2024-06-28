import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iconsax/iconsax.dart";
import "package:sdp2/features/seller/authentication_seller/screen/password_configuration/reset_password.dart";
import "package:sdp2/utils/global_colors.dart";

import "../../../../../common/widgets/button.dart";

class SellerForgetPassword extends StatelessWidget {
  SellerForgetPassword({super.key});
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
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Iconsax.direct_right, color: GlobalColors.mainColor),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                // Add more validation logic if needed
                return null;
              },
            ),
            const SizedBox(height: 24,),
            CustomButton(text: 'Submit',
              onTap: ()=>Get.to(() => const SellerResetPassword()))
          ],
        ),
      ),
    );
  }
}
