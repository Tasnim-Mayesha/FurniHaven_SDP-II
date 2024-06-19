import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdp2/common/widgets/bottomnavbar/customer_starting.dart';
import 'package:sdp2/utils/global_colors.dart';

import 'package:sdp2/features/authentication/screen/signup/signup_view.dart';

import '../../../../common/widgets/appbar/custom_appbar_out.dart';
import '../../../../common/widgets/button.dart';
import '../../../../common/widgets/social_login.dart';
import '../password_configuration/forget_password.dart';

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
                // Email Input
                TextFormField(
                  controller: emailController,
                  expands: false,
                  decoration: InputDecoration(
                    labelText: 'Email'.tr,
                    prefixIcon: const Icon(Iconsax.direct,
                        color: GlobalColors.mainColorHex),
                  ),
                ),
                const SizedBox(height: 10),
                // Password Input
                TextFormField(
                  controller: passwordController,
                  expands: false,
                  decoration: InputDecoration(
                    labelText: 'Password'.tr,
                    prefixIcon: const Icon(Iconsax.password_check,
                        color: GlobalColors.mainColorHex),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.to(() => ForgetPassword()),
                      child: Text('Forgot Password ?'.tr),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Sign In'.tr,
                  onTap: () {
                    Get.to(() => CustMainPage());
                  },
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
