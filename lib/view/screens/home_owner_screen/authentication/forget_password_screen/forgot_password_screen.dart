import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_images/app_images.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/view/components/custom_text_field/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                        height: 334.h,
                      ),

                      ///=============================Email=====================
                      const CustomTextField(
                        hintText: AppStrings.emailForVerification,
                      ),


                      SizedBox(
                        height: 24.h,
                      ),

                      ///============================Send Email=============
                      CustomButton(onTap: (){
                        Get.toNamed(AppRoutes.forgotPasswordOtp);
                      },
                        fillColor: AppColors.employeeCardColor,
                        title: AppStrings.sendEmail,
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
