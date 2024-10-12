import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_const/app_const.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';

import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

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
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=============================== Personal Information ========================
                CustomMenuAppbar(
                  onTap: () {
                    Get.toNamed(AppRoutes.editProfileScreen);
                  },
                  isEdit: true,
                  title: AppStrings.personalInformation,
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
                          Color(0xCCE8F3FA), // First color (with opacity)
                          Color(0xCCE8F3FA), // First color (with opacity)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child:  Column(
                      children: [
                         CustomNetworkImage(
                             boxShape: BoxShape.circle,
                             imageUrl: AppConstants.userNtr, height: 128, width: 128),
                         const CustomText(
                           top: 10,
                          text: 'Masum raj',
                          color: AppColors.dark400,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),  const CustomText(
                          text: 'Free User',
                          color: AppColors.dark300,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          bottom: 24,
                        ),
                        ///============================First Name=====================
                        const CustomProfileItem(
                          title: AppStrings.firstName,
                          subTitle: 'Masum ',
                        ),

                        ///================================last Name========================
                        const CustomProfileItem(
                          title: AppStrings.lastName,
                          subTitle: 'Raj',
                        ),

                        ///================================Email========================
                        const CustomProfileItem(
                          title: AppStrings.email,
                          subTitle: 'masumrna927@gmail.com',
                        ),

                        ///================================Contact No========================
                        const CustomProfileItem(
                          title: AppStrings.contactNumber,
                          subTitle: '0172228692',
                        ),

                        ///================================Address========================
                        const CustomProfileItem(
                          title: AppStrings.address,
                          subTitle: 'Dhaka',
                        ),
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

class CustomProfileItem extends StatelessWidget {
  final String title;
  final String subTitle;

  const CustomProfileItem({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          color: AppColors.dark300,
          text: title,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          bottom: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12),
          color: AppColors.blue50,
          child: CustomText(
            textAlign: TextAlign.start,
            text: subTitle,
            color: AppColors.dark300,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
