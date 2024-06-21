import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/button.dart';
import 'package:sdp2/utils/global_colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed, required this.buttonTitle});

  final String image,title,subTitle,buttonTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 56, left: 24, bottom: 24,right: 24),
          child: Column(
            children: [
              const SizedBox(height: 64),
              ///Image
              Image(image: AssetImage(image),width: MediaQuery.of(Get.context!).size.width * 0.6,),
              const SizedBox(height: 32),
              ///Title & SubTitle
              Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: 16),
              Text(subTitle,style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,),
              const SizedBox(height: 64),

              ///Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: GlobalColors.mainColor,
                ),
                child: CustomButton(text:buttonTitle,
                  onTap: onPressed,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
