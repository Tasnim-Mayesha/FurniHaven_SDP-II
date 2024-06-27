import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/authentication/screen/signup/verify_email.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../../data/repositories/user/user_repository.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/helpers/network_manager.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../personilization/model/user_models.dart';


class SignupController extends GetxController{
  static SignupController get instance => Get.find();

  ///variables
  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final userName = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  ///SIGNUP
  void signup() async {
    try {
      //start loading
      FullScreenLoader.openLoadingDialog(
          "We are processing your information", AppImages.docerAnimation);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }


      //form validation
      if (!signupFormKey.currentState!.validate()) {
        //TFullScreenLoader.stopLoading();
        return;
      }


      //register user in the firebase authentication & save user data in the firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      //save authenticated user data in the firebase firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        username : userName.text.trim(),
        email: email.text.trim(),
        profilePicture: "",
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      FullScreenLoader.stopLoading();
      //show success message
      Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Account has been created! Verify email and continue.');

      //move to verify email screen
      Get.to(() =>const  VerifyEmailScreen());


    } catch (e) {
      //show some generic error to the user
      Loaders.errorSnackBar(title: 'Something Went Wrong!', message: e.toString());

    }finally{
      //remove loader
      FullScreenLoader.stopLoading();

    }
  }
}