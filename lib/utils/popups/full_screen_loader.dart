
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../global_colors.dart';
import '../helpers/helper_functions.dart';
import 'animation_loader.dart';


class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: HelperFunctions.isDarkMode(Get.context!) ? GlobalColors.dark : GlobalColors.white ,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250,),
              AnimationLoaderWidget(text:text, animation:animation)
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}

