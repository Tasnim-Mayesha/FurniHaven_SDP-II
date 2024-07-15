import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/utils/global_colors.dart';
import 'profile_controller.dart';
import '../AddContact/addContact.dart';
import '../ChangePassword/ChangePassword.dart';
import '../EditProfileItems/EditEmail.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Center the title
        backgroundColor: GlobalColors.mainColor, // Set the AppBar color
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the back button color to white
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
                    Stack(
                      children: [
                        GetBuilder<ProfileController>(
                          builder: (_) {
                            return CircleAvatar(
                              radius: 35.0,
                              backgroundImage: controller.image != null
                                  ? FileImage(File(controller.image!.path))
                                  : controller.imageUrl != null
                                      ? NetworkImage(controller.imageUrl!)
                                      : const AssetImage(
                                              'assets/images/profile.jpg')
                                          as ImageProvider,
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: controller.pickImage,
                            child: const CircleAvatar(
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
                    ),
                    const SizedBox(width: 16.0),
                    GetBuilder<ProfileController>(
                      builder: (_) {
                        return Text(
                          controller.username ?? 'Loading...'.tr,
                          style: const TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading:
                            const Icon(Icons.email, color: Colors.deepOrange),
                        title: Row(
                          children: [
                            Text(
                              'Email: '.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(
                                width:
                                    4.0), // Optional: add some spacing between the label and email
                            Expanded(
                              child: Text(
                                'shitolsadia@gmail.com'.tr,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.navigate_next,
                            color: Colors.deepOrange),
                        onTap: () {
                          Get.to(() => const EditEmail());
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.phone_android_sharp,
                            color: Colors.deepOrange),
                        title: Text(
                          'Add Phone Number'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                            fontSize: 16.0,
                          ),
                        ),
                        trailing: const Icon(Icons.navigate_next,
                            color: Colors.deepOrange),
                        onTap: () {
                          Get.to(() => const AddContact());
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading:
                            const Icon(Icons.lock, color: Colors.deepOrange),
                        title: Row(
                          children: [
                            Text(
                              'Password: '.tr,
                              style: const TextStyle(
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
                                overflow: TextOverflow
                                    .ellipsis, // Ensure text does not overflow
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.navigate_next,
                            color: Colors.deepOrange),
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
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
