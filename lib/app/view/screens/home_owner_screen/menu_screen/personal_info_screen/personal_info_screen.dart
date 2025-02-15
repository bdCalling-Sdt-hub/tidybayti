import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/profile_controller/profile_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_personal_profile/custom_personal_profile.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xCCE8F3FA), Color(0xFFB5D8EE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (profileController.rxRequestStatus.value == Status.loading) {
              return const Center(child: CustomLoader());
            }

            if (profileController.rxRequestStatus.value ==
                Status.internetError) {
              return NoInternetScreen(onTap: profileController.getProfile);
            }

            if (profileController.rxRequestStatus.value == Status.error) {
              return GeneralErrorScreen(onTap: profileController.getProfile);
            }

            final profile = profileController.profileModel.value;

            return SingleChildScrollView(
              child: Column(
                children: [
                  /// ========== AppBar ==========
                  CustomMenuAppbar(
                    onTap: () {
                      Get.toNamed(AppRoutes.editProfileScreen, arguments: {
                        "firstName": profile.firstName,
                        "lastName": profile.lastName,
                        "phoneNumber": profile.phoneNumber,
                        "profileImage": profile.profileImage,
                      });
                      print("Profile Image URL:========== ${profile.profileImage}");


                    },
                    title: AppStrings.personalInformation.tr,
                    isEdit: true,
                  ),

                  /// ========== Profile Info ==========
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xCCE8F3FA), Color(0xCCE8F3FA)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        children: [
                          ClipOval(
                            child: profile.profileImage != null && profile.profileImage!.isNotEmpty
                                ? Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue, width: 4)),
                              child: CustomNetworkImage(
                                imageUrl: "${ApiUrl.networkUrl}${profile.profileImage}",
                                height: 128,
                                width: 128,
                              ),
                            )
                                : const CustomImage(
                              imageSrc: AppImages.avatar,
                              imageType: ImageType.png,
                            ),
                          ),
                          CustomText(
                            top: 10,
                            text: profile.firstName ?? "",
                            color: AppColors.dark400,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                          const CustomText(
                            text: 'Free User',
                            color: AppColors.dark300,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            bottom: 24,
                          ),

                          /// ========== Personal Details ==========
                          CustomPersonalProfile(
                            title: AppStrings.firstName.tr,
                            subTitle: profile.firstName ?? "",
                          ),
                          CustomPersonalProfile(
                            title: AppStrings.lastName.tr,
                            subTitle: profile.lastName ?? "",
                          ),
                          CustomPersonalProfile(
                            title: AppStrings.email.tr,
                            subTitle: profile.email ?? "",
                          ),
                          CustomPersonalProfile(
                            title: AppStrings.contactNumber.tr,
                            subTitle: profile.phoneNumber ?? "",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
