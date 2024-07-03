import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sdp2/common/widgets/button.dart';
import 'package:sdp2/features/authentication/screen/login/login_view.dart';

import '../../../../utils/constant.dart';
import '../../../../utils/global_colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controller/forget_password/forget_password_controller.dart';


class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))]
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              /// Image with 60% of screen width
              Image(image: const AssetImage(AppImages.emailReceive), width: HelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: 32.0),

              /// Email, Title & Subtitle
              Text(email, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: 16.0),
              Text("Password Reset Email Sent", style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: 16.0),
              Text("Your Account Security is Our Priority! We've Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected.", style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: 32),

              /// Buttons
              CustomButton(text: "Done",onTap: (){
                Get.offAll(() =>  LoginView());
              }
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: TextButton(onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email), child:  Text("Resend Email",style: TextStyle(color: GlobalColors.mainColor),)),
              ),
            ],
          ),
        ),
      ),
    );
  }

}