import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/profile_controller/profile_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/global/helper/shared_prefe/shared_prefe.dart';
import 'package:tidybayte/app/global/helper/time_converter/time_converter.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_profile_item/custom_profile_item.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/employee_nav_bar/employee_navbar.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

import '../../../../utils/app_images/app_images.dart';

class EmployeeProfileScreen extends StatelessWidget {
  EmployeeProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const EmployeeNavbar(currentIndex: 2),
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
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=============================== profile Appbar ========================
                CustomMenuAppbar(
                  onTap: () {
                    final profile = profileController.profileModel.value;

                    Get.toNamed(AppRoutes.employeeEditProfile,
                        arguments: {
                          "firstName": profile.firstName,
                          "lastName": profile.lastName,
                          "phoneNumber": profile.phoneNumber,
                          "profileImage": profile.profileImage,
                        });
                    print("Profile Image URL:========== ${profile.profileImage}");
                  },
                  isEdit: true,
                  title: AppStrings.profile,
                  onBack: () {
                    Get.back();
                  },
                ),

                ///==========================Body Here=====================
                Obx(() {
                  switch (profileController.rxRequestStatus.value) {
                    case Status.loading:
                      return const Center(child: CustomLoader()); // Show loading indicator

                    case Status.internetError:
                      return NoInternetScreen(onTap: () {
                        profileController.getProfile();
                      });

                    case Status.error:
                      return GeneralErrorScreen(
                        onTap: () {
                          profileController.getProfile();
                        },
                      );

                    case Status.completed:
                      final data = profileController.profileModel.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.blue100,
                                // First color (with opacity)
                                AppColors.blue100,
                                // First color (with opacity)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              ClipOval(
                                child: data.profileImage != null &&
                                        data.profileImage!.isNotEmpty
                                    ? Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blue, width: 4)),
                                        child: CustomNetworkImage(
                                          imageUrl:
                                              "${ApiUrl.networkUrl}${data.profileImage}",
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
                                bottom: 10,
                                text:
                                    'Name: ${profileController.profileModel.value.firstName} '
                                    '${profileController.profileModel.value.lastName}',
                                color: AppColors.dark400,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),

                              ///============================email=====================
                              CustomProfileItem(
                                title: '${AppStrings.email}:',
                                subTitle: data.email ?? "",
                              ),

                              ///================================id========================
                              CustomProfileItem(
                                title: AppStrings.id,
                                subTitle: data.id ?? "",
                              ),

                              ///================================Contact No========================
                              CustomProfileItem(
                                title: "${AppStrings.contactNumber}:",
                                subTitle: data.phoneNumber ?? "",
                              ),

                              ///================================CPR========================
                              CustomProfileItem(
                                title: '${AppStrings.cprNumber}:',
                                subTitle: data.cprNumber ?? "",
                              ),

                              ///================================Passport:  ========================
                              CustomProfileItem(
                                title: '${AppStrings.passportNumber}:',
                                subTitle: data.passportNumber ?? "",
                              ),

                              ///================================jobType  ========================
                              CustomProfileItem(
                                title: '${AppStrings.jobType}:',
                                subTitle: data.jobType ?? "",
                              ),

                              ///================================joiningDate  ========================
                              CustomProfileItem(
                                title: AppStrings.joiningDate,
                                subTitle: DateConverter.estimatedDate(
                                    data.createdAt!.toLocal()),
                              ),

                              ///================================Address  ========================
                              CustomProfileItem(
                                title: AppStrings.address,
                                subTitle:data.address??"",
                              ),

                              ///================================Duty Time  ========================
                              CustomProfileItem(
                                title: 'Duty Time:',
                                subTitle: data.dutyTime ?? "",
                              ),

                              ///================================Break Time  ========================
                              CustomProfileItem(
                                title: 'Break Start Time:',
                                subTitle: "data.",
                              ),

                              ///================================Break End Time  ========================
                              CustomProfileItem(
                                title: 'Break End Time:',
                                subTitle: "data.",
                              ),

                              ///================================Working Day  ========================
                              CustomProfileItem(
                                title: 'Working Day:',
                                subTitle: data.workingDay != null
                                    ? data.workingDay!.join(", ")
                                    : "N/A",
                              ),

                              SizedBox(
                                height: 20.h,
                              ),

                              ///==============================Change Password=============
                              CustomButton(
                                onTap: () {
                                  Get.toNamed(AppRoutes.changePasswordScreen);
                                },
                                fillColor: AppColors.blue50,
                                title: AppStrings.changePassword,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),

                              ///==============================Log Out=============
                              CustomButton(
                                onTap: () async {
                                  await SharePrefsHelper.remove(
                                      AppConstants.token);
                                  await SharePrefsHelper.remove(
                                      AppConstants.profileID);
                                  SharePrefsHelper.setBool(
                                      AppConstants.rememberMe, false);
                                  SharePrefsHelper.setBool(
                                      AppConstants.isOwner, false);
                                  Get.toNamed(AppRoutes.choseOnBoardingScreen);
                                },
                                fillColor: AppColors.blue50,
                                title: AppStrings.logOut.tr,
                              )
                            ],
                          ),
                        ),
                      );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
