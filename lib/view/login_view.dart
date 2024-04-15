import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdp2/utils/global_colors.dart';
import 'package:sdp2/view/password_configuration/forget_password.dart';
import 'package:sdp2/view/signup_view.dart';
import 'package:sdp2/view/widgets/button.dart';
import 'package:sdp2/view/widgets/global_textform.dart';
import 'package:sdp2/view/widgets/social_login.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
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
                    'Login to your Account',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Get.to(()=> ForgetPassword()),
                          child: Text('Forgot Password ?',style: TextStyle(color: GlobalColors.textColor),))
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomButton(text: 'Sign In',onTap: (){},),
                  const SizedBox(height: 25),
                  const SocialLogin(),
                ],
              ),
            ),
          )
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
          color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t have an account?'),
            InkWell(
              child: Text(
                  ' Sign Up',
                   style: TextStyle(
                     color: GlobalColors.mainColor,
                   ),
              ),
              onTap:() => Get.to(()=> SignupView())
            )
          ]
        ),
      ),
    );
  }
}