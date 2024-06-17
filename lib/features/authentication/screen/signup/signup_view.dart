import 'package:flutter/material.dart';


import '../../../../common/widgets/appbar/custom_appbar_out.dart';
import '../../../../common/widgets/social_login.dart';
import 'widgets/signup_form.dart';


class SignupView extends StatelessWidget {
  const SignupView({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar : CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  SignupForm(),
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