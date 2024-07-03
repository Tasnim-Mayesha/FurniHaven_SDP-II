import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:sdp2/common/onboarding/widgets/onboarding_next_button.dart';
import 'package:sdp2/common/onboarding/widgets/onboarding_page.dart';
import 'package:sdp2/common/onboarding/widgets/onboarding_skip.dart';
import 'package:sdp2/utils/constant.dart';

import 'onboarding_controller.dart';





class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children:  const [
              OnBoardingPage(
                image: AppImages.onboarding1,
                title: "Choose your furniture",
                subTitle: "Welcome to a World of Limitless Choices - Your Perfect Furniture Awaits!",
              ),
              OnBoardingPage(
                image: AppImages.onboarding2,
                title: "Select Payment Method",
                subTitle: "For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!",
              ),
              OnBoardingPage(
                image: AppImages.onboarding3,
                title: "Deliver at your door step",
                subTitle: "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery",
              ),
            ],
          ),

          /// skip button
          const OnBoardingSkip(),

          ///Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          ///Circular Button
          const OnBoardingNextButton()

        ],
      ),
    );
  }
}


