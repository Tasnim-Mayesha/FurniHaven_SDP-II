import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../common/widgets/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constant.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// send email whenever verify screen appears
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }
  /// Send Email Verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please check your Inbox and Verify your Email');
    } catch (e) {
      Loaders.errorSnackBar(title: 'oh Snap', message: e.toString());
    }
  }
  /// Timer to automatically redirect an email verification
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
          (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
                () => SuccessScreen(
                image: AppImages.successAnimation,
                title: "Welcome to FurniHaven: Your Account is Created.",
                subTitle: "Unleash the Joy of Seamless Online Shopping!",
                onPressed: () =>
                    AuthenticationRepository.instance.screenRedirect(),
                  buttonTitle: 'Next',),
          );
        }
      },
    );
  }
  /// Manually Check if email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
            () => SuccessScreen(
            image: AppImages.successAnimation,
            title: "Welcome to FurniHaven: Your Account is Created.",
            subTitle: "Unleash the Joy of Seamless Online Shopping!",
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect(),
              buttonTitle: 'Next',),
      );
    }
  }
}