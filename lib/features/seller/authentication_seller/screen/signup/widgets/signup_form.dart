import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../common/widgets/button.dart';
import '../../../../../../utils/global_colors.dart';
import '../../../../../../validators/validation.dart';
import '../../../controller/signup/signup_controller.dart';

class SellerSignupForm extends StatelessWidget {
  const SellerSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(SellerSignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Image.asset(
            'assets/images/furnihaven_logo.png',
            width: 100,
            height: 100,
          ),

          const SizedBox(height: 50),

          ///Username
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                Validator.validateEmptyText('Username'.tr, value),
            expands: false,
            decoration: InputDecoration(
                labelText: 'Username'.tr,
                prefixIcon: const Icon(
                  Iconsax.user_edit,
                  color: GlobalColors.mainColorHex,
                )),
          ),
          const SizedBox(height: 10),

          ///company
          TextFormField(
            controller: controller.brandName,
            validator: (value) =>
                Validator.validateEmptyText('Brand Name'.tr, value),
            expands: false,
            decoration: InputDecoration(
                labelText: 'Brand Name'.tr,
                prefixIcon: const Icon(
                  Icons.house,
                  color: GlobalColors.mainColorHex,
                )),
          ),

          ///Email
          const SizedBox(height: 10),
          TextFormField(
            validator: (value) => Validator.validateEmail(value),
            controller: controller.email,
            expands: false,
            decoration: InputDecoration(
              labelText: 'Email'.tr,
              prefixIcon: const Icon(
                Iconsax.direct,
                color: GlobalColors.mainColorHex,
              ),
            ),
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
                prefixIcon: const Icon(
                  Iconsax.password_check,
                  color: GlobalColors.mainColorHex,
                ),
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
          CustomButton(text: 'Sign Up'.tr, onTap: () => controller.signup()),
        ],
      ),
    );
  }
}
