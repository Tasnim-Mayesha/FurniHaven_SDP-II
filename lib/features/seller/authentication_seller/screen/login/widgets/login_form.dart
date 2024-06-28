import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/button.dart';
import '../../../../../../utils/global_colors.dart';
import '../../../../../../validators/validation.dart';
import '../../../../../customer/screen/home/home_view.dart';

class SellerLoginForm extends StatelessWidget {
  const SellerLoginForm({
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
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Iconsax.password_check),
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
              CustomButton(text: 'Sign In',onTap: ()=>  const HomeView()//controller.emailAndPasswordSignIn(),
              ),
              
            ],
          ),
        )
    );
  }
}