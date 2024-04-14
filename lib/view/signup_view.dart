import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdp2/utils/global_colors.dart';
import 'package:sdp2/view/widgets/button_signup.dart';
import 'package:sdp2/view/widgets/global_textform.dart';
import 'package:sdp2/view/widgets/social_login.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController confirmPasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Logo',
                      style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Create your Account',
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 15),
                  ///Email Input
                  GlobalTextForm(
                    controller: emailController,
                    text: 'Email',
                    textInputType: TextInputType.emailAddress,
                    obscure: false,
                    icon: Icon(Iconsax.direct_right,color: GlobalColors.mainColor),
                  ),
                  const SizedBox(height: 10),
                  ///Password Input
                  GlobalTextForm(
                    controller: passwordController,
                    text: 'Password',
                    textInputType: TextInputType.text,
                    obscure: true,
                    icon: Icon(Iconsax.password_check,color: GlobalColors.mainColor,),
                  ),
                  const SizedBox(height: 10),
                  ///Password Input
                  GlobalTextForm(
                    controller: confirmPasswordController,
                    text: 'Confirm Password',
                    textInputType: TextInputType.text,
                    obscure: true,
                    icon: Icon(Icons.password_outlined,color: GlobalColors.mainColor,),
                  ),
                  const SizedBox(height: 25),
                  const ButtonSignUp(),
                  const SizedBox(height: 25),
                  const SocialLogin(),
                ],

              ),
            )
        ),
      ),
    );
  }
}