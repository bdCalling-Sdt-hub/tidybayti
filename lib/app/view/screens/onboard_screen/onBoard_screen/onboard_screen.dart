import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';

import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                AppImages.onBoardBackground,
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 429.h,
                  ),

                  const CustomText(
                    text: AppStrings.welcome,
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                    color: AppColors.light50,
                  ),

                  const CustomText(
                    textAlign: TextAlign.start,
                    text: AppStrings.createAnAccountAndAccess,
                    fontSize: 24,
                    maxLines: 3,
                    fontWeight: FontWeight.w300,
                    color: AppColors.dark300,
                    bottom: 20,
                  ),
                  ///============================gettingStarted Button=============

                  CustomButton(
                    width: MediaQuery.of(context).size.width/1.7,
                    onTap: () {
                      Get.toNamed(AppRoutes.choseOnBoardingScreen);
                    },
                    fillColor: AppColors.employeeCardColor,
                    title: AppStrings.gettingStarted,
                  ),

                      SizedBox(
                        height: 36.h,
                      ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 6,
                        backgroundColor: AppColors.red,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: AppColors.customRedColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: AppColors.customRedColor,
                      ),
                    ],
                  ),

                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
