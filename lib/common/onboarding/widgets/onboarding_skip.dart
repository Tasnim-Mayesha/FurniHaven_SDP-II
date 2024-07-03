import 'package:flutter/material.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/global_colors.dart';
import '../onboarding_controller.dart';



class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: DeviceUtils.getAppBarHeight(),
      right: 24.0,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child:  Text('Skip',style: TextStyle(color: GlobalColors.mainColor,fontSize: 15,fontWeight: FontWeight.w500),),
      ),
    );
  }
}