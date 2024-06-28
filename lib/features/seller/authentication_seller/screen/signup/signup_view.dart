import 'package:flutter/material.dart';
import 'package:sdp2/features/seller/authentication_seller/screen/signup/widgets/signup_form.dart';
import '../../../../../common/widgets/appbar/custom_appbar_out.dart';
import '../../../../../common/widgets/social_login.dart';

class SellerSignupView extends StatelessWidget {
  const SellerSignupView({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar : const CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  SellerSignupForm(),
                  SizedBox(height: 25),
                  SizedBox(height: 25),
                  SocialLogin(),
                ],

              ),
            )
        ),
      ),
    );
  }
}