import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sdp2/features/authentication/screen/login/login_view.dart';

import 'package:sdp2/features/authentication/screen/signup/signup_view.dart';

import 'package:sdp2/features/authentication/screen/signup/verify_email.dart';

import '../features/authentication/screen/password_configuration/forget_password.dart';
import '../features/customer/screen/home/home_view.dart';
import '../features/customer/screen/splash_view.dart';
import '../features/seller/views/main_page.dart';


class AppRoutes {
  static final pages = [
    //Customer
    GetPage(name: '/', page: () =>  HomeView()),
    GetPage(name: '/signup', page: () => SignupView()),
    GetPage(name: '/verify-email', page: () => VerifyEmailScreen()),
    GetPage(name: '/sign-in', page: () => LoginView()),
    GetPage(name: '/forget-password', page: () => ForgetPassword()),
    GetPage(name: '/splash-screen', page: () => SplashView()),

    // Seller
    GetPage(name: '/seller_dashboard', page: () => MainPage()),
  ];
}
