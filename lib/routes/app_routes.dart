import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sdp2/seller/views/main_page.dart';
import 'package:sdp2/view/login_view.dart';
import 'package:sdp2/view/password_configuration/forget_password.dart';
import 'package:sdp2/view/signup_view.dart';
import 'package:sdp2/view/splash_view.dart';
import 'package:sdp2/view/verify_email.dart';

import '../view/home_view.dart';

class AppRoutes {
  static final pages = [
    //Customer
    GetPage(name: '/', page: () => const HomeView()),
    GetPage(name: '/signup', page: () => SignupView()),
    GetPage(name: '/verify-email', page: () => VerifyEmailScreen()),
    GetPage(name: '/sign-in', page: () => LoginView()),
    GetPage(name: '/forget-password', page: () => ForgetPassword()),
    GetPage(name: '/splash-screen', page: () => SplashView()),

    // Seller
    GetPage(name: '/seller_dashboard', page: () => MainPage()),
  ];
}
