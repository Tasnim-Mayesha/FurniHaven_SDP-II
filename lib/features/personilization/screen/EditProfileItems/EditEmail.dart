import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/personilization/screen/profile/profile_controller.dart';

import '../profile/profile.dart';

class EditEmail extends StatelessWidget {
  const EditEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    final TextEditingController _emailController = TextEditingController(text: controller.email);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Email'.tr,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.deepOrange,
                ),
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'We will send verification to your Email address'.tr,
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
            const SizedBox(height: 16.0),
            Obx(() {
              return controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.isNotEmpty) {
                    await controller.updateEmail(_emailController.text);
                    Get.snackbar(
                      'Success',
                      'Your email has been updated successfully'.tr,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  minimumSize: const Size(double.infinity, 50.0),
                ),
                child: Text('Save'.tr),
              );
            }),
          ],
        ),
      ),
    );
  }
}
