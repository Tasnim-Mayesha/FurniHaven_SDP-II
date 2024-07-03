
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:sdp2/common/widgets/button.dart";


import "../../../../data/repositories/authentication/authentication_repository.dart";
import "../../../../utils/constant.dart";
import "../../../../utils/global_colors.dart";
import "../../../../utils/helpers/helper_functions.dart";
import "../../../../utils/style/spacing_styles.dart";
import "../../controller/signup/verify_email_controller.dart";



class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Image
              Image(
                image: const AssetImage(AppImages.emailReceive),
                width: HelperFunctions.screenWidth() * 0.6,
              ),

              const SizedBox(height: 32.0),

              ///Title and Subtitle
              Text(
                "Verify your email address!",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32.0,
              ),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: 32.0,
              ),
              Text(
                "Congratulations! Your Account Awaits: Verify Your Email to Start Shopping and Experience a World of Unrivaled Deals and Personalized Offers.",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: 32.0,
              ),

              ///Buttons
              CustomButton(text: 'Continue',onTap: (){
                controller.checkEmailVerificationStatus();
              },
              ),
              const SizedBox(
                height: 32.0,
              ),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.sendEmailVerification(),
                      child:  Text("Resend Email",style: TextStyle(color: GlobalColors.mainColor),)))
            ],
          ),
        ),
      ),
    );
  }
}