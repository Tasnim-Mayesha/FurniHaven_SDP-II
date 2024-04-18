import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/utils/global_colors.dart';
import 'package:sdp2/view/login_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 5), () {
      Get.to(()=> LoginView());
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body:  Center(
        // child: Text('Logo',style: TextStyle(
        //   color: Colors.white,
        //   fontWeight: FontWeight.bold,
        //   fontSize: 35
        // ),
        // ),
        child: Image.asset('assets/images/health.gif',scale: 0.5,),
      ),
    );
  }
}
