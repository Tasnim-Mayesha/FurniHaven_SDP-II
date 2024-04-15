import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/view/login_view.dart';
import 'package:sdp2/view/password_configuration/forget_password.dart';
import 'package:sdp2/view/password_configuration/reset_password.dart';
import 'package:sdp2/view/signup_view.dart';
import 'package:sdp2/view/splash_view.dart';
import 'package:sdp2/view/verify_email.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashView', // Specify initial route
      getPages: [
        GetPage(name: '/splashView', page: () =>  SplashView()), // Define your splash view route
        GetPage(name: '/login', page: () => LoginView()), // Define your login view route
        GetPage(name: '/forgetPassword', page: () => ForgetPassword()), // Define your forget password view route
        GetPage(name: '/ResetPassword', page: () =>  ResetPassword()), // Define your reset password view route
        GetPage(name: '/signUp', page: () => SignupView()), // Define your sign up view route
        GetPage(name: '/verifyEmail', page: () =>  VerifyEmailScreen()), // Define your verify email view route
        // Add more routes as needed
      ],
      //home: SplashView(),
    );
  }
}
