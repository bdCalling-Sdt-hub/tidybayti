import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';

import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';

class HomeOwnerChoseAuth extends StatelessWidget {
   HomeOwnerChoseAuth({super.key});

  final String role = Get.arguments ?? "Unknown";

  @override
  Widget build(BuildContext context) {
    print(role);
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
                  children: [
                    SizedBox(
                      height: 290.h,
                    ),
                    role== "Employee"?
                    SizedBox(
                      height: 100.h,
                    ):const SizedBox(),

                    ///============================signIn Button=============
                    Center(
                      child: Column(
                        children: [
                          CustomButton(
                            width: MediaQuery.of(context).size.width / 1.7,
                            onTap: () {
                              Get.toNamed(AppRoutes.signInScreen,arguments: role);
                            },
                            fillColor: AppColors.employeeCardColor,
                            title: AppStrings.signIn.tr,
                          ),

                          ///============================signUp Button=============
                          role== "Employee"?const SizedBox():
                          SizedBox(
                            height: 16.h,
                          ),
                          role== "Employee"?const SizedBox():
                          CustomButton(
                            width: MediaQuery.of(context).size.width / 1.7,
                            onTap: () {
                              Get.toNamed(AppRoutes.signUpScreen,);
                            },
                            fillColor: AppColors.employeeCardColor,
                            title: AppStrings.signUp.tr,
                          ),
                          role== "Employee"?const SizedBox():
                          SizedBox(
                            height: 152.h,
                          ),

                          ///=========================== Center the RichText correctly ============================
                          role== "Employee"?const SizedBox():
                          RichText(
                            textAlign: TextAlign.center,
                            // Center the text in the widget
                            text: TextSpan(
                              children: <TextSpan>[
                                 TextSpan(
                                  text: AppStrings.bySigningUp.tr,
                                  style: const TextStyle(
                                    color: AppColors.dark300,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                ),

                                ///==========================Terms of use=======================
                                TextSpan(
                                  text:
                                      " ${AppStrings.termsOfUse.tr}  ",
                                  style: const TextStyle(
                                    color: AppColors.dark400,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(
                                          AppRoutes.termsAndServiceScreen);
                                    },
                                ),
                                 TextSpan(
                                  text: "${AppStrings.and.tr}  ",
                                  style: const TextStyle(
                                    color: AppColors.dark300,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),

                                ///==============================Privacy policy====================
                                TextSpan(
                                  text: AppStrings.privacyPolicy.tr,
                                  style: const TextStyle(
                                    color: AppColors.dark400,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline
,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(
                                          AppRoutes.privacyPolicyScreen);
                                    },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 59.h,
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
