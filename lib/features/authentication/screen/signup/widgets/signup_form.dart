import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/button.dart';
import '../../../../../utils/global_colors.dart';
import '../../../../../validators/validation.dart';
import '../../../controller/signup/signup_controller.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    //final dark = HelperFunctions.isDarkMode(context);
    final controller=Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Center(
            child: Text('Logo',style: TextStyle(color: GlobalColors.mainColor,fontSize: 25,fontWeight: FontWeight.bold),),
          ),

          const SizedBox(height: 50),
          ///Username
          TextFormField(
            controller: controller.userName,
            validator: (value) => Validator.validateEmptyText('Username'.tr, value),

            expands: false,
            decoration:  InputDecoration(labelText: 'Username'.tr,prefixIcon: const Icon(Iconsax.user_edit,color: GlobalColors.mainColorHex,)),
          ),
          ///Email
          const SizedBox(height: 10),
          TextFormField(
            validator: (value) => Validator.validateEmail(value),
            controller: controller.email,
            expands: false,
            decoration:  InputDecoration(labelText: 'Email'.tr,prefixIcon: const Icon(Iconsax.direct,color: GlobalColors.mainColorHex,), ),
          ),

          ///Password
          const SizedBox(height: 10),
          Obx(
                () => TextFormField(
              validator: (value) => Validator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: 'Password'.tr,
                prefixIcon: const Icon(Iconsax.password_check,color: GlobalColors.mainColorHex,),
                suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                    !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(text: 'Sign Up'.tr,onTap: () => controller.signup()),
        ],
      ),
    );
  }
}

