import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_profile_item/custom_profile_item.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/employee_nav_bar/employee_navbar.dart';

import '../../../../utils/app_images/app_images.dart';
import '../../home_owner_screen/menu_screen/personal_info_screen/personal_info_screen.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key});

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
                    Get.toNamed(AppRoutes.employeeEditProfile);
                  },
                  isEdit: true,
                  title: AppStrings.profile,
                  onBack: () {
                    Get.back();
                  },
                ),

                ///==========================Body Here=====================

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.blue100, // First color (with opacity)
                          AppColors.blue100, // First color (with opacity)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        // CustomNetworkImage(
                        //     boxShape: BoxShape.circle,
                        //     imageUrl: AppConstants.employee,
                        //     height: 128,
                        //     width: 128),
                        const ClipOval(
                          child: SizedBox(
                            width: 128.0, // specify width
                            height: 128.0, // specify height
                            child: CustomImage(
                              imageSrc: AppImages.avatar,
                              imageType: ImageType.png,
                            ),
                          ),
                        ),

                        const CustomText(
                          top: 10,
                          text: 'Name:',
                          color: AppColors.dark400,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        const CustomText(
                          text: 'assistant',
                          color: AppColors.dark300,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          bottom: 24,
                        ),

                        ///============================First Name=====================
                        const CustomProfileItem(
                          title: '${AppStrings.designation}:',
                          subTitle: ' ',
                        ),

                        ///================================last Name========================
                        const CustomProfileItem(
                          title: AppStrings.id,
                          subTitle: '',
                        ),

                        ///================================Email========================
                        const CustomProfileItem(
                          title: '${AppStrings.email}:',
                          subTitle: '',
                        ),

                        ///================================Contact No========================
                        const CustomProfileItem(
                          title: "${AppStrings.contactNumber}:",
                          subTitle: '',
                        ),

                        ///================================Address========================
                        const CustomProfileItem(
                          title: '${AppStrings.address}:',
                          subTitle: '',
                        ),

                        ///================================CPR========================
                        const CustomProfileItem(
                          title: '${AppStrings.cPR}:',
                          subTitle: ' ',
                        ),

                        ///================================Passport:  ========================
                        const CustomProfileItem(
                          title: '${AppStrings.passport}:',
                          subTitle: '',
                        ),

                        ///================================drivingLicense  ========================
                        const CustomProfileItem(
                          title: '${AppStrings.drivingLicense}:',
                          subTitle: '',
                        ),

                        ///================================jobType  ========================
                        const CustomProfileItem(
                          title: '${AppStrings.jobType}:',
                          subTitle: '',
                        ),

                        ///================================joiningDate  ========================
                        const CustomProfileItem(
                          title: AppStrings.joiningDate,
                          subTitle: '',
                        ),

                        ///================================drivingLicense  ========================
                        const CustomProfileItem(
                          title: 'Duty Time',
                          subTitle: '',
                        ),

                        ///================================drivingLicense  ========================
                        const CustomProfileItem(
                          title: 'Working Day',
                          subTitle: '',
                        ),

                        SizedBox(
                          height: 20.h,
                        ),

                        ///==============================Change Password=============
                        CustomButton(
                          onTap: () {
                            showMyDialog(context);
                          },
                          fillColor: AppColors.blue50,
                          title: AppStrings.changePassword,
                        )   ,
                           SizedBox(height: 20.h,),
                        CustomButton(
                          onTap: () {
                            Get.toNamed(AppRoutes.onboardScreen);
                          },
                          fillColor: AppColors.blue50,
                          title: AppStrings.logOut,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    // The dialog can't be dismissed by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
          title: Row(
            children: [
              const CustomText(
                text: AppStrings.changePassword,
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const CustomImage(imageSrc: AppIcons.x))
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///===================================Present Password=============
              CustomTextField(
                fillColor: Color(0xFFB5D8EE),
                hintText: AppStrings.presentPassword,
                textEditingController: TextEditingController(),
              ),
              SizedBox(
                height: 10.h,
              ),

              ///===================================New Password=============
              CustomTextField(
                fillColor: Color(0xFFB5D8EE),
                hintText: AppStrings.newPassword,
                textEditingController: TextEditingController(),
              ),
              SizedBox(
                height: 10.h,
              ),

              ///===================================New Confirm Password=============
              CustomTextField(
                fillColor: Color(0xFFB5D8EE),
                hintText: AppStrings.confirmPassword,
                textEditingController: TextEditingController(),
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomButton(
                onTap: () {
                  Get.back();
                },
                fillColor: Color(0xFFB5D8EE),
                title: AppStrings.upDate,
              )
            ],
          ));
    },
  );
}
