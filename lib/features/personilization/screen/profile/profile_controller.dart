import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/features/personilization/screen/profile/profile.dart';
import 'package:sdp2/features/personilization/screen/profile/profile_controller.dart';
import 'dart:io';
import '../../../../utils/global_colors.dart';
import '../AddContact/addContact.dart';
import '../ChangePassword/ChangePassword.dart';
import '../EditProfileItems/EditEmail.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile'.tr,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: GlobalColors.mainColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Obx(() {
                      return Stack(
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage: controller.image != null
                                ? FileImage(File(controller.image!.path))
                                : controller.imageUrl != null
                                ? NetworkImage(controller.imageUrl!)
                                : AssetImage('assets/images/profile.jpg') as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: controller.pickImage,
                              child: CircleAvatar(
                                radius: 12.0,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.deepOrange,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(width: 16.0),
                    Obx(() {
                      return Text(
                        controller.username ?? 'Loading...'.tr,
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 32.0),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.email, color: Colors.deepOrange),
                        title: Row(
                          children: [
                            Text(
                              'Email: '.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Obx(() {
                              return Expanded(
                                child: Text(
                                  controller.email ?? 'Loading...'.tr,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }),
                          ],
                        ),
                        trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                        onTap: () {
                          Get.to(() => const EditEmail());
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.phone_android_sharp, color: Colors.deepOrange),
                        title: Text(
                          'Add Phone Number'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                            fontSize: 16.0,
                          ),
                        ),
                        trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                        onTap: () {
                          Get.to(() => const AddContact());
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.lock, color: Colors.deepOrange),
                        title: Row(
                          children: [
                            Text(
                              'Password: '.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Expanded(
                              child: Text(
                                '********',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.navigate_next, color: Colors.deepOrange),
                        onTap: () {
                          Get.to(() => const ChangePassword());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            return controller.isLoading.value
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Container();
          }),
        ],
      ),
    );
  }
}
