import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/profile_controller/profile_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';

import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class EmployeeEditProfile extends StatefulWidget {
  const EmployeeEditProfile({super.key});

  @override
  State<EmployeeEditProfile> createState() => _EmployeeEditProfileState();
}

class _EmployeeEditProfileState extends State<EmployeeEditProfile> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    final args = Get.arguments ?? {};
    profileController.firstNameController.text = args["firstName"] ?? '';
    profileController.lastNameController.text = args["lastName"] ?? '';
    profileController.phoneNumberController.text = args["phoneNumber"] ?? '';
    profileController.image.value = args["profileImage"] ?? '';
    print("Received Image: =============${args["profileImage"]}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xCCE8F3FA), // First color (with opacity)
              Color(0xFFB5D8EE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///=============================== Edit Profile Appbar ========================
                  CustomMenuAppbar(
                    onTap: () {},
                    isEdit: false,
                    title: AppStrings.editProfile.tr,
                    onBack: () {
                      Get.back();
                    },
                  ),

                  ///==========================Body Here=====================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              profileController.selectImage();
                            },
                            child: Obx(() {
                              if (profileController.image.value.isNotEmpty) {
                                String imagePath =
                                    profileController.image.value;

                                if (imagePath.startsWith('/data') ||
                                    imagePath.startsWith('/storage')) {
                                  return ClipOval(
                                    child: Image.file(
                                      File(imagePath),
                                      height: 128.h,
                                      width: 128.w,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                } else {
                                  return ClipOval(
                                    child: Image.network(
                                      "${ApiUrl.baseUrl}/$imagePath",
                                      height: 128.h,
                                      width: 128.w,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }
                              } else {
                                return const Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    ClipOval(
                                        child: CustomImage(
                                      imageSrc: AppImages.avatar,
                                      imageType: ImageType.png,
                                      size: 100,
                                    )),
                                    Positioned(
                                      right: 5,
                                      bottom: 5,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.camera_alt,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///==============================Name Here=====================
                        CustomTextField(
                          textEditingController:
                              profileController.firstNameController,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///=================================Location Here===============
                        CustomTextField(
                          textEditingController:
                              profileController.lastNameController,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///===============================Phone Number Here=================
                        CustomTextField(
                          textEditingController:
                              profileController.phoneNumberController,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///===============================Phone Number Here=================
                        CustomTextField(
                          textEditingController:
                              profileController.addressController,
                        ),
                        SizedBox(
                          height: 175.h,
                        ),

                        ///=======================Save And Changes Button============
                        profileController.updateProfileLoading.value
                            ? const CustomLoader()
                            : CustomButton(
                                onTap: () {
                                  profileController.updateProfile();
                                },
                                fillColor: AppColors.employeeCardColor,
                                title: AppStrings.saveAndChange.tr,
                              )
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
