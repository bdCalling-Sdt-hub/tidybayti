import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_images/app_images.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';

class HomeOwnerChoseAuth extends StatelessWidget {
  const HomeOwnerChoseAuth({super.key});

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
                  children: [
                    SizedBox(
                      height: 290.h,
                    ),

                    ///============================signIn Button=============
                    Center(
                      child: Column(
                        children: [
                          CustomButton(
                            width: MediaQuery.of(context).size.width / 1.7,
                            onTap: () {
                              Get.toNamed(AppRoutes.signInScreen);
                            },
                            fillColor: AppColors.employeeCardColor,
                            title: AppStrings.signIn,
                          ),

                          ///============================signUp Button=============
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomButton(
                            width: MediaQuery.of(context).size.width / 1.7,
                            onTap: () {
                              Get.toNamed(AppRoutes.signUpScreen);
                            },
                            fillColor: AppColors.employeeCardColor,
                            title: AppStrings.signUp,
                          ),
                          SizedBox(
                            height: 152.h,
                          ),

                          ///=========================== Center the RichText correctly ============================
                          RichText (
                            textAlign: TextAlign.center, // Center the text in the widget
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: AppStrings.bySigningUp,
                                  style: TextStyle(
                                    color: AppColors.dark300,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),

                                ///==========================Terms of use=======================
                                TextSpan(
                                  text: "${AppStrings.termsOfUse}  ",
                                  style: const TextStyle(
                                    color: AppColors.dark400,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(
                                          AppRoutes.termsAndServiceScreen);
                                    },
                                ),
                                const TextSpan(
                                  text: "${AppStrings.and}  ",
                                  style: TextStyle(
                                    color: AppColors.dark300,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),

                                ///==============================Privacy policy====================
                                TextSpan(
                                  text: AppStrings.privacyPolicy,
                                  style: const TextStyle(
                                    color: AppColors.dark400,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(AppRoutes.privacyPolicyScreen);
                                    },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 59.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                              SizedBox(
                                width: 10.w,
                              ),
                              const CircleAvatar(
                                radius: 6,
                                backgroundColor: AppColors.red ,
                              ),
                            ],
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
