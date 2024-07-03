import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/device/device_utility.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../onboarding_controller.dart';




class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Positioned(
        right: 24.0,
        bottom: DeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
          onPressed: () => OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(), backgroundColor: dark ? GlobalColors.mainColor : GlobalColors.mainColor),
          child: const Icon(Iconsax.arrow_right_3),
        ));
  }
}