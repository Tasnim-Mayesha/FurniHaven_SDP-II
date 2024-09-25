import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iconsax/iconsax.dart";
import "package:sdp2/utils/global_colors.dart";

import "../../../../../common/widgets/button.dart";
import "../../../../../validators/validation.dart";
import "../../../../authentication/controller/forget_password/forget_password_controller.dart";



class SellerForgetPassword extends StatelessWidget {
  SellerForgetPassword({super.key});
  final TextEditingController emailController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Forget Password'.tr,style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(height: 8,),
            Text(
              'Don\'t worry sometimes people can forget too,enter your email and we will send you a password reset link.'.tr,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: GlobalColors.textColor.withOpacity(0.7)
              ),
            ),
            const SizedBox(height: 48,),
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: Validator.validateEmail,
                decoration: InputDecoration(labelText: "Email", prefixIcon: Icon(Iconsax.direct_right,color: GlobalColors.mainColor,)),
              ),
            ),
            const SizedBox(height: 24,),
            CustomButton(text: 'Submit',
              onTap: ()=> controller.sendPasswordResetEmail(),)
          ],
        ),
      ),
    );
  }
}
