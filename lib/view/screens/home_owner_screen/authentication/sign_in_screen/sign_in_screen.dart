import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_images/app_images.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/view/components/custom_text_field/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                AppImages.signInBackground,
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 267.h,
                  ),

                  ///=============================Email=====================
                  const CustomTextField(
                    hintText: AppStrings.email,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ///===========================Enter Password======================
                  const CustomTextField(
                    hintText: AppStrings.enterPassword,
                  ),
                  ///============================Forgot Password================
                   Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.forgotPasswordScreen);
                        },
                        child: const CustomText(
                          decoration: TextDecoration.underline,
                          textAlign: TextAlign.right,
                          top: 24,
                          text: AppStrings.forgetPassword,
                          fontSize: 14,
                          color: AppColors.dark300,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),

                  ///============================Sign In Button=============
                  CustomButton(onTap: (){
                    Get.toNamed(AppRoutes.homeScreen);
                  },
                  fillColor: AppColors.employeeCardColor,
                    title: AppStrings.signIn,
                  ),
                  SizedBox(
                    height: 48.h,
                  ),

                  ///==============================Dont Have=============
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: AppStrings.dontHaveAnyAccount,
                            style: TextStyle(
                              color: AppColors.dark300,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: AppStrings.signUp,
                            style: const TextStyle(
                              color: AppColors.dark400,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.signUpScreen);
                              },
                          ),
                        ],
                      ),
                    ),
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
