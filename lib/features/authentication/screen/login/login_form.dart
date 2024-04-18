import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdp2/view/home_view.dart';

import '../../../../utils/global_colors.dart';
import '../../../../validators/validation.dart';
import '../../../../view/widgets/button.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(LoginController());

    return Form(
        //key: controller.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              ///Email
              TextFormField(
                //controller: controller.email,
                validator: (value) => Validator.validateEmail(value),
                decoration:  const InputDecoration(prefixIcon: Icon(Iconsax.direct_right,color: GlobalColors.mainColorHex,), labelText: 'Email',),
              ),
              const SizedBox(height: 10,),
              ///Password
              const SizedBox(height: 10),
              Obx(
                    () => TextFormField(
                  validator: (value) => Validator.validatePassword(value),
                  //controller: controller.password,
                  //obscureText: controller.hidePassword.value,
                  expands: false,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Iconsax.password_check),
                    //suffixIcon: //IconButton(
                        //onPressed: () => controller.hidePassword.value =
                        //!controller.hidePassword.value,
                        //icon: Icon(controller.hidePassword.value
                           // ? Iconsax.eye_slash
                            //: Iconsax.eye)),
                  ),
                ),
              ),
              const SizedBox(height: 10,),

              const SizedBox(height: 10),
              ///Sign in button
              CustomButton(text: 'Sign In',onTap: ()=> const HomeView()//controller.emailAndPasswordSignIn(),
              ),
              
            ],
          ),
        )
    );
  }
}