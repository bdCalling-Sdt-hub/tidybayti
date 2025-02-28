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
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/schedule_screen/schedule_screen.dart';

class MainSentSuccessfullyScreen extends StatelessWidget {
  const MainSentSuccessfullyScreen({super.key});

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
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///=============================== Menu Title ========================
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomMenuAppbar(
                    title: '',
                    onBack: () {
                      Get.back();
                    },
                  ),
                ],
              ),

              ///=============================== Menu Items ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [


                    Container(
                      height: 96,
                      width: 96,
                      decoration: const BoxDecoration(
                        color:AppColors.blue900,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(child: CustomImage(imageSrc: AppIcons.rightUp,)),
                    ),

                    CustomText(
                      top: 24,
                      bottom: 40,
                      maxLines: 2,
                      text: AppStrings.mailSendSuccessfully.tr,
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      color: AppColors.dark400,
                    ),


                    SizedBox(height: 10.h,),
                    CustomButton(
                      fillColor: Colors.white,
                      onTap: () {
                        Get.toNamed(AppRoutes.addEmployeeScreen);
                      },
                      title: AppStrings.addNewEmployee.tr,
                    ),

                    SizedBox(height: 10.h,),
                    CustomButton(
                      fillColor: Colors.white,
                      onTap: () {
                        // Get.toNamed(AppRoutes.)
                        Get.to(const ScheduleScreen());
                      },
                      title: AppStrings.scheduleOverview.tr,
                    ),
                    ///=========================backToHome==============

                    SizedBox(height: 10.h,),
                    CustomButton(
                      fillColor: Colors.white,
                      onTap: () {
                        Get.toNamed(AppRoutes.homeScreen);
                      },
                      title: AppStrings.backToHome.tr,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
