import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdp2/data/repositories/seller/seller_repository.dart';
import 'package:sdp2/utils/global_colors.dart';

import '../../../../../common/widgets/appbar/custom_appbar_out.dart';
import '../../../../../common/widgets/button.dart';
import '../../../../../common/widgets/social_login.dart';
import '../../../views/main_page.dart';
import '../password_configuration/forget_password.dart';
import '../signup/signup_view.dart';

class SellerLoginView extends StatefulWidget {
  SellerLoginView({super.key});

  @override
  _SellerLoginViewState createState() => _SellerLoginViewState();
}

class _SellerLoginViewState extends State<SellerLoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Method to handle login
  Future<void> _login(BuildContext context) async {
    final sellerRepository = SellerRepository.instance;
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and Password cannot be empty");
      return;
    }

    try {
      User? user =
      await sellerRepository.loginUser(email: email, password: password);
      if (user != null) {
        // Fetch seller data
        // SellerModel seller = await sellerRepository.getSellerData(user.uid);
        // Navigate to MainPage
        Get.off(() => MainPage());
      }
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }

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
                // Password Input with visibility toggle
                TextFormField(
                  controller: passwordController,
                  expands: false,
                  obscureText: !_isPasswordVisible, // Hide/show password
                  decoration: InputDecoration(
                    labelText: 'Password'.tr,
                    prefixIcon: const Icon(Iconsax.password_check,
                        color: GlobalColors.mainColorHex),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Iconsax.eye // Eye open icon
                            : Iconsax.eye_slash, // Eye closed icon
                        color: GlobalColors.mainColorHex,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.to(() => SellerForgetPassword()),
                      child: Text('Forgot Password ?'.tr),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Sign In'.tr,
                  onTap: () => _login(context),
                ),
                const SizedBox(height: 25),
                //const SocialLogin(),
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
            onTap: () => Get.to(() => const SellerSignupView()),
          )
        ]),
      ),
    );
  }
}

