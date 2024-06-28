import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/utils/constant.dart';

import '../../../../../common/widgets/button.dart';
import '../login/login_view.dart';


class SellerResetPassword extends StatelessWidget {
  const SellerResetPassword ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 24, bottom: 24,right: 24),
          child: Column(
            children: [
              const Center(child: Image(image: AssetImage(AppImages.resetPassword))),
              const SizedBox(height: 24),

              ///Title & SubTitle
              const Text('Password Reset Email Sent',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              const SizedBox(height: 16),
              Text('Your Account Security is Our Priority! We\'ve Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected.',style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: 32),
              /// Buttons
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Done',
                  onTap: () => Get.offAll(() =>  SellerLoginView()),
                )
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: TextButton(onPressed: (){}, child: const Text('Resend Email')),
              ),
            ],
          ),
        ),
      )
    );
  }
}
