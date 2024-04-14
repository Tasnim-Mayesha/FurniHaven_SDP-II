import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sdp2/utils/global_colors.dart';

class ButtonSignIn extends StatelessWidget{
  const ButtonSignIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: (){
        print('Login');
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
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
            'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )
        )
      ),
    );

  }
}