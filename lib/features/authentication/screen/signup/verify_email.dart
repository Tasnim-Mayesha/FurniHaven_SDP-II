import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/utils/constant.dart';
import 'package:sdp2/utils/global_colors.dart';
import 'package:sdp2/features/authentication/screen/login/login_view.dart';

import '../../../../common/widgets/success_screen.dart';


class VerifyEmailScreen extends StatelessWidget{
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          //always start from right side
          IconButton(onPressed: () => Get.offAll(()=> LoginView()), icon:const Icon(CupertinoIcons.clear))
        ],
      ),
      body:  SingleChildScrollView(
        //padding to give default equal space on all sides in all screens
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0,left: 0,bottom: 0,right: 0),
            child: Column(
              children: [
                ///Image
                Image(image: const AssetImage('assets/images/email_otp.jpg'),width: MediaQuery.of(Get.context!).size.width * 0.6,),
                const SizedBox(height: 32),

                ///Title & SubTitle
                Text('Verify your email address!',style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
                const SizedBox(height: 16),
                Text('support@codingwitht.com',style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
                const SizedBox(height: 16),
                Text('Verify Your Email to Start Exploring and Experience a World of Unrivaled Deals and Personalized Offers.',style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
                const SizedBox(height: 32),

                ///Buttons
                  InkWell(
                    onTap: () => Get.to(()=> SuccessScreen(
                      image: AppImages.success,
                      title: 'Your account successfully created!',
                      subTitle: 'Your Account is Created, Unleash the Joy of Seamless Online Shopping!',
                      onPressed: () => Get.to(() =>  LoginView()),
                    ),
                    ),
                    child: Container(
                        alignment: Alignment.center,
                        height: 55,
                        width: 320,
                        decoration: BoxDecoration(
                            color: GlobalColors.mainColor,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                              ),
                            ]
                        ),
                        child: const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            )
                        )
                    ),
                  ),

                const SizedBox(height: 16),
                SizedBox(width: double.infinity,child:TextButton(onPressed: (){},child: const Text('Resend Email'),),),
              ],
            ),
          )
      ),
    );
  }

}