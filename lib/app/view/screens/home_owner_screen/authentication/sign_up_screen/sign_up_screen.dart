import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                        height: 88.h,
                      ),

                      ///=============================First Name=====================
                      const CustomTextField(
                        hintText: AppStrings.firstName,
                        fillColor: AppColors.employeeCardColor,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ///===========================Last Name======================
                      const CustomTextField(
                        hintText: AppStrings.lastName,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ///===========================Contact Number======================
                      const CustomTextField(
                        hintText: AppStrings.contactNumber,
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      ///===========================Email======================
                      const CustomTextField(
                        hintText: AppStrings.email,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ///===========================Password======================
                      const CustomTextField(
                        hintText: AppStrings.password,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ///===========================Confirm Password======================
                      const CustomTextField(
                        hintText: AppStrings.confirmPassword,
                        isPassword: true,
                      ),

                      SizedBox(
                        height: 24.h,
                      ),

                      ///============================Create Account=============
                      CustomButton(onTap: (){
                        Get.toNamed(AppRoutes.signUpOtp);
                      },
                        fillColor: AppColors.employeeCardColor,
                        title: AppStrings.createAccount,
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
                                text: AppStrings.alreadyHaveAnYAccount,
                                style: TextStyle(
                                  color: AppColors.dark300,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),

                              TextSpan(
                                text: "  ${AppStrings.signIn}",
                                style: const TextStyle(
                                  color: AppColors.dark400,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoutes.signInScreen);
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
