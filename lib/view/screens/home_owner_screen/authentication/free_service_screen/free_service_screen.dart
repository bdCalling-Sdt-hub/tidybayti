import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_images/app_images.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

class FreeServiceScreen extends StatelessWidget {
  const FreeServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.signInBackground,
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Positioned(
            top: 113.h, // Adjust based on your design requirements
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: AppStrings.youHaveFiveDays,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      color: AppColors.freeServiceColor,
                    ),
                    SizedBox(height: 24.h),
                    CustomText(
                      text: AppStrings.congratulations,
                      textAlign: TextAlign.start,
                      maxLines: 4,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.dark300,
                    ),
                    SizedBox(height: 24.h),
                    CustomText(
                      text: AppStrings.ourSubscriptionPackages,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.blue900,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Button
          Positioned(
            bottom: 20.h, // Add space from the bottom
            left: 20.w,
            right: 20.w,
            child: CustomButton(
              onTap: () {
                // Get.toNamed();
              },
              fillColor: AppColors.employeeCardColor,
              title: AppStrings.continues,
            ),
          ),
        ],
      ),
    );
  }
}
