import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/authentication/screen/login/widgets/login_form.dart';
import 'package:sdp2/utils/global_colors.dart';

import '../../../../common/widgets/appbar/custom_appbar_out.dart';
import '../../../../common/widgets/social_login.dart';
import '../password_configuration/forget_password.dart';
import '../signup/signup_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/furnihaven_logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                )),
                const SizedBox(height: 24),
                Text(
                  'Login to your Account'.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 15),
                LoginForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.to(() => ForgetPassword()),
                      child: Text('Forgot Password ?'.tr),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                const SocialLogin(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        alignment: Alignment.center,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Don't have an account? ".tr),
          InkWell(
            child: Text(
              'Sign Up'.tr,
              style: TextStyle(
                color: GlobalColors.mainColor,
              ),
            ),
            onTap: () => Get.to(() => const SignupView()),
          )
        ]),
      ),
    );
  }
}
