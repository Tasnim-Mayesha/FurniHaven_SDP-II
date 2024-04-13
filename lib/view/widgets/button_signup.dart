import 'package:flutter/material.dart';
import 'package:sdp2/utils/global_colors.dart';
import 'package:sdp2/view/verify_email.dart';

class ButtonSignUp extends StatelessWidget{
  const ButtonSignUp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyEmailScreen()));
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
            'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )
        )
      ),
    );

  }
}
